/*-----------------------------------------*\
|  DasKeyboardController.cpp                |
|                                           |
|  Driver for Das Keyboard RGB keyboard     |
|  lighting controller                      |
|                                           |
|  Frank Niessen (denk_mal) 12/16/2020      |
\*-----------------------------------------*/

#include <cstring>
#include "HWKeyboardController.h"
#include "QDebug"
using namespace std::chrono_literals;

HWKeyboardController::HWKeyboardController(hid_device *dev_handle, const char *path)
{
    dev                    = dev_handle;
    location               = path;
    version                = "V1.0";
    useTraditionalSendData = true;

    SendInitialize();
}

HWKeyboardController::~HWKeyboardController()
{
    hid_close(dev);
}

std::string HWKeyboardController::GetDeviceLocation()
{
    return "HID: " + location;
}

std::string HWKeyboardController::GetSerialString()
{
    wchar_t serial_string[128] = {};
    int     err                = hid_get_serial_number_string(dev, serial_string, 128);

    std::string return_string;
    if(err == 0)
    {
        std::wstring return_wstring = serial_string;
        return_string = std::string(return_wstring.begin(), return_wstring.end());
    }

    if(return_string.empty())
    {
        return_string = version;
    }

    return return_string;
}

std::string HWKeyboardController::GetVersionString()
{
    if(version.length() < 17)
    {
        return version;
    }

    std::string fw_version  = "V";
    fw_version             += version.substr(6, 2);
    fw_version             += ".";
    fw_version             += version.substr(15, 2);
    fw_version             += ".0";

    return fw_version;
}

std::string HWKeyboardController::GetLayoutString()
{
    /*-----------------------------------------------------*\
    | Experimental for now; should be '16' for US and '28'  |
    | for EU layout                                         |
    \*-----------------------------------------------------*/

    return "US";
}

void HWKeyboardController::SendColors(unsigned char key_id, unsigned char mode,
                                       unsigned char red, unsigned char green, unsigned char blue)
{
    qDebug()<<"SendColors()";
    if(key_id < 130)
    {
        unsigned char usb_buf[] = {0x02,
                                   0x08,
                                   0x78,
                                   0x08,
                                   static_cast<unsigned char>(key_id),
                                   mode,
                                   red,
                                   green,
                                   blue};

        SendData(usb_buf, sizeof(usb_buf));
    }
}


void HWKeyboardController::SendInitialize()
{
   qDebug()<<"SendInitialize()";
}

void HWKeyboardController::SendApply()
{
    /*-----------------------------------------------------*\
    | Set up Terminate Color packet                         |
    \*-----------------------------------------------------*/
    unsigned char usb_buf_send[]    = {0x02, 0x03, 0x78, 0x0a};
    unsigned char usb_buf_receive[] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    qDebug()<<"SendApply()";
    SendData(usb_buf_send, sizeof(usb_buf_send));
    ReceiveData(usb_buf_receive, sizeof(usb_buf_receive));
}

void HWKeyboardController::SendData(const unsigned char *data, const unsigned int length)
{
    if(useTraditionalSendData)
    {
        qDebug()<<"SendDataTraditional";
        SendDataTraditional(data, length);
    }
    else
    {
        SendDataModern(data, length);
    }
}

void HWKeyboardController::SendDataModern(const unsigned char *data, const unsigned int length)
{
    /*-----------------------------------------------------*\
    | modern SendData (send whole bytes in one transfer)    |
    \*-----------------------------------------------------*/
    unsigned char usb_buf[65];

    unsigned int err_cnt = 3;
    int          res     = -1;
    while(res == -1)
    {
        /*-----------------------------------------------------*\
        | Fill data into send buffer                            |
        \*-----------------------------------------------------*/
        unsigned int chk_sum = 0;
        usb_buf[0] = 1;

        for(unsigned int idx = 0; idx < length; idx++)
        {
            usb_buf[idx + 1] = data[idx];
            chk_sum ^= data[idx];
        }
        usb_buf[length + 1] = chk_sum;

        res = hid_send_feature_report(dev, usb_buf, length + 2);
        if(res == -1)
        {
            if(!err_cnt--)
            {
                return;
            }
        }
        /*-----------------------------------------------------*\
        | Hack to work around a firmware bug in v21.27.0        |
        \*-----------------------------------------------------*/
        std::this_thread::sleep_for(0.3ms);
    }
}

/**
 * @brief HWKeyboardController::SendDataTraditional
 * @param data   the data you want to send keyboard
 * @param length
 */
void HWKeyboardController::SendDataTraditional(const unsigned char *data, const unsigned int length)
{
    /*-----------------------------------------------------*\
    | traditional SendData (split into chunks of 33 byte)    |
    \*-----------------------------------------------------*/
    unsigned char usb_buf[33];
    unsigned char pocketNum = length/30;
    /*-----------------------------------------------------*\
    | Fill data into send buffer                            |
    \*-----------------------------------------------------*/
    unsigned int err_cnt = 3;
    //unsigned int chk_sum = 0;
    usb_buf[0] = 2;
    usb_buf[1] = 0xac;
    unsigned char topIndex = 0;
    for(unsigned int idx = 0; idx < pocketNum; idx++)
    {
        usb_buf[2] = idx;
        for(char i = 0;i<30;i++){
            usb_buf[i+3] = data[topIndex++];
        }
        //topIndex = topIndex + 30;
        int res = hid_write(dev, usb_buf, 33);
        qDebug()<<"data has send: "<<usb_buf;
        if(res == -1)
        {
            qDebug()<<"send error!";
            idx = 0;
            if(!err_cnt--)
            {
                return;
            }
        }

        /*-----------------------------------------------------*\
        | Hack to work around a firmware bug in v21.27.0        |
        \*-----------------------------------------------------*/
        std::this_thread::sleep_for(0.1ms);
    }
    qDebug()<<"send data success!";
}

int HWKeyboardController::ReceiveData(unsigned char *data, const unsigned int max_length)
{
    unsigned char              usb_buf[9];
    std::vector<unsigned char> receive_buf;

    /*-----------------------------------------------------*\
    | Fill data from receive buffer                         |
    \*-----------------------------------------------------*/
    unsigned int chk_sum = 0;

    do
    {
        memset(usb_buf, 0x00, sizeof(usb_buf));
        usb_buf[0x00] = 0x01;

        int res = hid_read(dev, usb_buf, 8);
        if(res == -1)
        {
            break;
        }

        if(usb_buf[0])
        {
            for(unsigned int ii = 0; ii < 8; ii++)
            {
                receive_buf.push_back(usb_buf[ii]);
                chk_sum ^= usb_buf[ii];
            }
        }
    } while(usb_buf[0]);

    /*-----------------------------------------------------*\
    | clean up data buffer                                  |
    \*-----------------------------------------------------*/
    for(unsigned int ii = 0; ii < max_length; ii++)
    {
        data[ii] = 0;
    }

    /*-----------------------------------------------------*\
    | If checksum is not correct, return with empty buffer  |
    \*-----------------------------------------------------*/
    if(chk_sum)
    {
        return -1;
    }

    size_t response_size = 0;
    if(receive_buf.size() > 1)
    {
        response_size = receive_buf.at(1);
        if(response_size + 2 > receive_buf.size())
        {
            return -1;
        }
        if(response_size > max_length)
        {
            response_size = static_cast<int>(max_length);
        }

        /*-----------------------------------------------------*\
        | Remove first two bytes (signature?) and content length|
        \*-----------------------------------------------------*/
        for(size_t ii = 0; ii < response_size - 1; ii++)
        {
            data[ii] = receive_buf.at(ii + 2);
        }
    }

    return response_size;
}
