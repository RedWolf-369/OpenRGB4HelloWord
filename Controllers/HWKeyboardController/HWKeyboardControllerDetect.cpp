#include "Detector.h"
#include "HWKeyboardController.h"
#include "RGBController.h"
#include "RGBController_HWKeyboard.h"
#include <hidapi/hidapi.h>

/*-----------------------------------------------------*\
| Das Keyboard vendor ID                                |
\*-----------------------------------------------------*/
#define HW_KEYBOARD_VID                0x1001

/*-----------------------------------------------------*\
| Keyboard product IDs                                  |
\*-----------------------------------------------------*/
#define HW_KEYBOARD_PID             0xf103


/******************************************************************************************\
*                                                                                          *
*   DetectDasKeyboardControllers                                                           *
*                                                                                          *
*       Tests the USB address to see if a Das Keyboard RGB controller exists there.        *
*       We need the second interface to communicate with the keyboard                      *
*                                                                                          *
\******************************************************************************************/

void HWKeyboardControllers(hid_device_info *info_in, const std::string &name)
{
    hid_device_info *info = info_in;

    while(info)
    {
        if(info->vendor_id        == HW_KEYBOARD_VID     &&
          info->product_id       == HW_KEYBOARD_PID)

        {

            break;
        }
        info = info->next;
    }

    if(!info)
    {
        return;
    }

    hid_device *dev = hid_open_path(info->path);

    if(dev)
    {
        HWKeyboardController *controller = new HWKeyboardController(dev, info->path);

        if(controller->GetLayoutString() == "NONE")
        {
            delete controller;
        }
        else
        {
            RGBController_HWKeyboard *rgb_controller = new RGBController_HWKeyboard(controller);
            rgb_controller->SetupZones();
            rgb_controller->name = name;

            ResourceManager::get()->RegisterRGBController(rgb_controller);
        }
    }
}   /* HWKeyboardController() */

void DetectHWKeyboard(hid_device_info *info, const std::string &name)
{
    hid_device *dev = hid_open_path(info->path);

    if(dev)
    {
        HWKeyboardController *controller = new HWKeyboardController(dev, info->path);

        if(controller->GetLayoutString() == "NONE")
        {
            delete controller;
        }
        else
        {
            RGBController_HWKeyboard *rgb_controller = new RGBController_HWKeyboard(controller);
            rgb_controller->SetupZones();
            rgb_controller->name = name;
            ResourceManager::get()->RegisterRGBController(rgb_controller);
        }
    }
}   /* DetectHWKeyboard() */

REGISTER_HID_DETECTOR_PU("HW Keyboard RGB",  DetectHWKeyboard,          HW_KEYBOARD_VID, HW_KEYBOARD_PID , 0xffc0,   0x0c00);

