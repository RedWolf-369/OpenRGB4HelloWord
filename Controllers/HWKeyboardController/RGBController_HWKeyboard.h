/*-----------------------------------------*\
|  RGBController_DasKeyboard.h              |
|                                           |
|  Generic RGB Interface for Das Keyboard   |
|  RGB keyboard devices                     |
|                                           |
|  Frank Niessen (denk_mal) 12/16/2020      |
\*-----------------------------------------*/

#pragma once

#include "RGBController.h"
#include "HWKeyboardController.h"
#include "QDebug"
enum
{
    HW_KEYBOARD_MODE_DIRECT         = 0x01,
    HW_KEYBOARD_MODE_FLASHING       = 0x1F,
    HW_KEYBOARD_MODE_BREATHING      = 0x08,
    HW_KEYBOARD_MODE_SPECTRUM_CYCLE = 0x14
};


class RGBController_HWKeyboard : public RGBController
{
public:
    RGBController_HWKeyboard(HWKeyboardController* controller_ptr);
    ~RGBController_HWKeyboard();

    void SetupZones();
    void ResizeZone(int zone, int new_size);

    void DeviceUpdateLEDs();
    void UpdateZoneLEDs(int zone);
    void UpdateSingleLED(int led);

    void DeviceUpdateMode();

private:
    HWKeyboardController*  controller;

    std::vector<RGBColor>   double_buffer;
    bool                    updateDevice;
};
