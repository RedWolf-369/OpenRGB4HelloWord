/*-----------------------------------------*\
|  RGBController_DasKeyboard.cpp            |
|                                           |
|  Generic RGB Interface for Das Keyboard   |
|  RGB keyboard devices                     |
|                                           |
|  Frank Niessen (denk_mal) 12/16/2020      |
\*-----------------------------------------*/

#include "RGBControllerKeyNames.h"
#include "RGBController_HWKeyboard.h"
#include "QDebug"
using namespace std::chrono_literals;

//0xFFFFFFFF indicates an unused entry in matrix
#define NA  0xFFFFFFFF
#define MATRIX_WIDTH  18
#define MATRIX_HEIGHT 7
// US Layout TODO: mus be checked/corrected
static unsigned int matrix_map_us[MATRIX_HEIGHT][MATRIX_WIDTH] =
    {
        {100,99,98,97,96,95,94,93,92,91,90,89,88,87,86,85,NA,NA},//  NA, 126,  NA,  NA,  NA},
        { 13,NA, 12, 11, 10, 9, 8, 7,6, 5, 4, 3, 2, 1,0,NA,NA,NA},// 14
        { 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,26, 27, 28,NA,NA,NA},// 15
        { 43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,NA,NA,NA},// 15
        { 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,55, 56, 57,NA ,NA,NA,NA},//14
        { 71,70,69,68,67,66,65,64,63,62,61,60,59,58,NA,NA,NA,NA},//  NA, 103, 109, 115, 122},
        { 72, 73, 74, NA,75,NA, 76, 77, 78, NA,NA,79, 80, 81, 82, 83, 84,NA},//  96, 102,  NA, 114,  NA},

    };

// EU Layout
static unsigned int matrix_map_eu[7][16] =
    {

    };

static const char *zone_names[] =
    {
        ZONE_EN_KEYBOARD
    };

static zone_type zone_types[] =
    {
        ZONE_TYPE_MATRIX,
    };

static const unsigned int zone_sizes[] =
    {
        101
    };

// UK Layout
static const char *led_names[] =
    {
        KEY_EN_PAUSE_BREAK,
        KEY_EN_F12,
        KEY_EN_F11,
        KEY_EN_F10,
        KEY_EN_F9,
        KEY_EN_F8,
        KEY_EN_F7,
        KEY_EN_F6,
        KEY_EN_F5,
        KEY_EN_F4,
        KEY_EN_F3,
        KEY_EN_F2,
        KEY_EN_F1,
        KEY_EN_ESCAPE,

        KEY_EN_BACK_TICK,
        KEY_EN_1,
        KEY_EN_2,
        KEY_EN_3,
        KEY_EN_4,
        KEY_EN_5,
        KEY_EN_6,
        KEY_EN_7,
        KEY_EN_8,
        KEY_EN_9,
        KEY_EN_0,
        KEY_EN_MINUS,
        KEY_EN_PLUS,
        KEY_EN_BACKSPACE,
        KEY_EN_INSERT,

        KEY_EN_DELETE,
        KEY_EN_ANSI_BACK_SLASH,
        KEY_EN_RIGHT_BRACKET,
        KEY_EN_LEFT_BRACKET,
        KEY_EN_P,
        KEY_EN_O,
        KEY_EN_I,
        KEY_EN_U,
        KEY_EN_Y,
        KEY_EN_T,
        KEY_EN_R,
        KEY_EN_E,
        KEY_EN_W,
        KEY_EN_Q,
        KEY_EN_TAB,

        KEY_EN_CAPS_LOCK,
        KEY_EN_A,
        KEY_EN_S,
        KEY_EN_D,
        KEY_EN_F,
        KEY_EN_G,
        KEY_EN_H,
        KEY_EN_J,
        KEY_EN_K,
        KEY_EN_L,
        KEY_EN_SEMICOLON,
        KEY_EN_QUOTE,
        KEY_EN_ANSI_ENTER,
        KEY_EN_PAGE_UP,

        KEY_EN_PAGE_DOWN,
        KEY_EN_UP_ARROW,
        KEY_EN_RIGHT_SHIFT,
        KEY_EN_FORWARD_SLASH,
        KEY_EN_PERIOD,
        KEY_EN_COMMA,
        KEY_EN_M,
        KEY_EN_N,
        KEY_EN_B,
        KEY_EN_V,
        KEY_EN_C,
        KEY_EN_X,
        KEY_EN_Z,
        KEY_EN_LEFT_SHIFT,

        KEY_EN_LEFT_CONTROL,
        KEY_EN_LEFT_WINDOWS,
        KEY_EN_RIGHT_ALT,
        KEY_EN_SPACE,
        KEY_EN_RIGHT_ALT,
        "Key:FN",
        KEY_EN_RIGHT_CONTROL,
        KEY_EN_LEFT_ARROW,
        KEY_EN_DOWN_ARROW,
        KEY_EN_RIGHT_ARROW,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,

        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
        KEY_EN_UNUSED,
    KEY_EN_PAUSE_BREAK,
    };

/**------------------------------------------------------------------*\
    @name HW Keyboard
    @category Keyboard
    @type USB
    @save :x:
    @direct :white_check_mark:
    @effects :white_check_mark:
    @detectors DetectHWKeyboardControllers,DetectHWKeyboard
    @comment
\*-------------------------------------------------------------------*/

RGBController_HWKeyboard::RGBController_HWKeyboard(HWKeyboardController* controller_ptr)
{
    controller  = controller_ptr;

    for(unsigned int ii = 0; ii < zone_sizes[0]; ii++)
    {
        double_buffer.push_back(-1);
    }

    updateDevice = true;

    name        = "HelloWord Keyboard Device";
    vendor      = "Undefine";
    type        = DEVICE_TYPE_KEYBOARD;
    description = "HelloWord Keyboard Device powered by AliceCui";
    location    = controller->GetDeviceLocation();
    serial      = controller->GetSerialString();
    version     = controller->GetVersionString();

    modes.resize(1);
    modes[0].name       = "Direct";
    modes[0].value      = HW_KEYBOARD_MODE_DIRECT;
    modes[0].flags      = MODE_FLAG_HAS_PER_LED_COLOR;
    modes[0].color_mode = MODE_COLORS_PER_LED;
}

RGBController_HWKeyboard::~RGBController_HWKeyboard()
{
    /*---------------------------------------------------------*\
    | Delete the matrix map                                     |
    \*---------------------------------------------------------*/
    unsigned int zone_size = zones.size();

    for(unsigned int zone_index = 0; zone_index < zone_size; zone_index++)
    {
        delete zones[zone_index].matrix_map;
    }

    delete controller;
}

void RGBController_HWKeyboard::SetupZones()
{
    /*---------------------------------------------------------*\
    | Set up zones                                              |
    \*---------------------------------------------------------*/
    unsigned int total_led_count = 0;

    for(unsigned int zone_idx = 0; zone_idx < 1; zone_idx++)
    {
        zone new_zone;
        new_zone.name               = zone_names[zone_idx];
        new_zone.type               = zone_types[zone_idx];
        new_zone.leds_min           = zone_sizes[zone_idx];
        new_zone.leds_max           = zone_sizes[zone_idx];
        new_zone.leds_count         = zone_sizes[zone_idx];
        new_zone.matrix_map         = new matrix_map_type;
        new_zone.matrix_map->height = MATRIX_HEIGHT;
        new_zone.matrix_map->width  = MATRIX_WIDTH;

        if(controller->GetLayoutString() == "US")
        {
            new_zone.matrix_map->map = (unsigned int *) &matrix_map_us;
        }
        else
        {
            new_zone.matrix_map->map = (unsigned int *) &matrix_map_eu;
        }

        zones.push_back(new_zone);

        total_led_count += zone_sizes[zone_idx];
    }

    for(unsigned int led_idx = 0; led_idx < total_led_count; led_idx++)
    {
        led new_led;
        new_led.name                = led_names[led_idx];
        leds.push_back(new_led);
    }

    SetupColors();
}

void RGBController_HWKeyboard::ResizeZone(int /*zone*/, int /*new_size*/)
{
    /*---------------------------------------------------------*\
    | This device does not support resizing zones               |
    \*---------------------------------------------------------*/
}

void RGBController_HWKeyboard::DeviceUpdateLEDs()
{
    UpdateZoneLEDs(0);
}

void RGBController_HWKeyboard::UpdateZoneLEDs(int /*zone*/)
{
    updateDevice = false;
    qDebug()<<"UpdateZoneLEDs() start";
    /*
    for(unsigned int led_idx = 0; led_idx < leds.size(); led_idx++)
    {
        UpdateSingleLED(static_cast<int>(led_idx));
    }
*/

    //every packet can send 10 leds
    int rgb_buffer_size = ((int)(leds.size()/10)+1)*10*3;
    unsigned char * rgb_buffer = new unsigned char[rgb_buffer_size];
    memset(rgb_buffer,0,rgb_buffer_size);
    for(int i =0 ; i<rgb_buffer_size/3;i++){
        if(i>=leds.size()){
            break;
        }
        qDebug()<<"UpdateZoneLEDs() color index : "<<i;
        rgb_buffer[i*3] = RGBGetRValue(colors[i]);
        rgb_buffer[i*3 + 1] = RGBGetGValue(colors[i]);
         rgb_buffer[i*3 + 2] = RGBGetBValue(colors[i]);
    }
    controller->SendData(rgb_buffer,rgb_buffer_size);
    qDebug()<<"UpdateZoneLEDs() end";
    updateDevice = true;
}

void RGBController_HWKeyboard::UpdateSingleLED(int led)
{
    mode selected_mode = modes[active_mode];

    if(double_buffer[led] == colors[led])
    {
        return;
    }

    controller->SendColors(led, selected_mode.value,
                           RGBGetRValue(colors[led]),
                           RGBGetGValue(colors[led]),
                           RGBGetBValue(colors[led]));

    double_buffer[led] = colors[led];

    if(updateDevice)
    {
        controller->SendApply();
    }
}

void RGBController_HWKeyboard::DeviceUpdateMode()
{
}
