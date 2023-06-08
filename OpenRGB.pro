#-----------------------------------------------------------------------------------------------#
# OpenRGB 0.x QMake Project                                                                     #
#                                                                                               #
#   Adam Honse (CalcProgrammer1)                        5/25/2020                               #
#-----------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------#
# Qt Configuration                                                                              #
#-----------------------------------------------------------------------------------------------#
QT +=                                                                                           \
    core                                                                                        \
    gui                                                                                         \

#-----------------------------------------------------------------------------------------------#
# Set compiler to use C++17 to make std::filesystem available                                   #
#-----------------------------------------------------------------------------------------------#
CONFIG +=   c++17                                                                               \
            lrelease                                                                            \
            embed_translations                                                                  \

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

greaterThan(QT_MAJOR_VERSION, 5): DEFINES += _QT6

#-----------------------------------------------------------------------------------------------#
# pkg-config Configuration                                                                      #
#-----------------------------------------------------------------------------------------------#
greaterThan(QT_MAJOR_VERSION, 4) {
    PKG_CONFIG = $$pkgConfigExecutable()
} else {
    PKG_CONFIG = "pkgconf"
}

#-----------------------------------------------------------------------------------------------#
# Application Configuration                                                                     #
#-----------------------------------------------------------------------------------------------#
MAJOR       = 0
MINOR       = 8
REVISION    = 1
VERSION     = $$MAJOR"."$$MINOR$$REVISION
TARGET      = HelloWordORGB
TEMPLATE    = app

#-----------------------------------------------------------------------------------------------#
# Automatically generated build information                                                     #
#-----------------------------------------------------------------------------------------------#
win32:BUILDDATE = $$system(date /t)
unix:BUILDDATE  = $$system(date -R -d "@${SOURCE_DATE_EPOCH:-$(date +%s)}")
GIT_COMMIT_ID   = $$system(git log -n 1 --pretty=format:"%H")
GIT_COMMIT_DATE = $$system(git log -n 1 --pretty=format:"%ci")
GIT_BRANCH      = $$system(git branch --show-current)

DEFINES +=                                                                                      \
    VERSION_STRING=\\"\"\"$$VERSION\\"\"\"                                                      \
    BUILDDATE_STRING=\\"\"\"$$BUILDDATE\\"\"\"                                                  \
    GIT_COMMIT_ID=\\"\"\"$$GIT_COMMIT_ID\\"\"\"                                                 \
    GIT_COMMIT_DATE=\\"\"\"$$GIT_COMMIT_DATE\\"\"\"                                             \
    GIT_BRANCH=\\"\"\"$$GIT_BRANCH\\"\"\"

#-----------------------------------------------------------------------------------------------#
# OpenRGB Common                                                                                #
#-----------------------------------------------------------------------------------------------#
INCLUDEPATH +=                                                                                  \
    dependencies/ColorWheel                                                                     \
    dependencies/Swatches/                                                                      \
    dependencies/CRCpp/                                                                         \
    dependencies/hueplusplus-1.0.0/include                                                      \
    dependencies/hueplusplus-1.0.0/include/hueplusplus                                          \
    dependencies/httplib                                                                        \
    dependencies/json/                                                                          \
    dependencies/libe131/src/                                                                   \
    dependencies/libcmmk/include/                                                               \
    dependencies/mdns                                                                           \
    hidapi_wrapper/                                                                             \
    i2c_smbus/                                                                                  \
    i2c_tools/                                                                                  \
    net_port/                                                                                   \
    pci_ids/                                                                                    \
    serial_port/                                                                                \
    super_io/                                                                                   \
    AutoStart/                                                                                  \
    RGBController/                                                                              \
    qt/

contains(QMAKE_PLATFORM, freebsd) {
    INCLUDEPATH -=                                                                              \
        Controllers/GigabyteRGBFusion2GPUController/
}

HEADERS +=                                                                                      \
    Colors.h                                                                                    \
    Controllers/HWKeyboardController/HWKeyboardController.h \
    Controllers/HWKeyboardController/RGBController_HWKeyboard.h \
    dependencies/ColorWheel/ColorWheel.h                                                        \
    dependencies/Swatches/swatches.h                                                            \
    dependencies/json/json.hpp                                                                  \
    dependencies/libcmmk/include/libcmmk/libcmmk.h                                              \
    LogManager.h                                                                                \
    NetworkClient.h                                                                             \
    NetworkProtocol.h                                                                           \
    NetworkServer.h                                                                             \
    OpenRGBPluginInterface.h                                                                    \
    PluginManager.h                                                                             \
    ProfileManager.h                                                                            \
    ResourceManager.h                                                                           \
    SettingsManager.h                                                                           \
    Detector.h                                                                                  \
    DeviceDetector.h                                                                            \
    filesystem.h                                                                                \
    qt/DetectorTableModel.h                                                                     \
    qt/HelloWordDFUPage.h \
    qt/OpenRGBClientInfoPage.h                                                                  \
    qt/OpenRGBConsolePage.h                                                                     \
    qt/OpenRGBDeviceInfoPage.h                                                                  \
    qt/OpenRGBDevicePage.h                                                                      \
    qt/OpenRGBDialog.h                                                                          \
    hidapi_wrapper/hidapi_wrapper.h                                                             \
    i2c_smbus/i2c_smbus.h                                                                       \
    i2c_tools/i2c_tools.h                                                                       \
    net_port/net_port.h                                                                         \
    pci_ids/pci_ids.h                                                                           \
    qt/DeviceView.h                                                                             \
    qt/OpenRGBDialog2.h                                                                         \
    qt/OpenRGBPluginContainer.h                                                                 \
    qt/OpenRGBPluginsPage/OpenRGBPluginsEntry.h                                                 \
    qt/OpenRGBPluginsPage/OpenRGBPluginsList.h                                                  \
    qt/OpenRGBPluginsPage/OpenRGBPluginsPage.h                                                  \
    qt/OpenRGBProfileSaveDialog.h                                                               \
    qt/OpenRGBServerInfoPage.h                                                                  \
    qt/OpenRGBSettingsPage.h                                                                    \
    qt/OpenRGBSoftwareInfoPage.h                                                                \
    qt/OpenRGBSupportedDevicesPage.h                                                            \
    qt/OpenRGBSystemInfoPage.h                                                                  \
    qt/OpenRGBThemeManager.h                                                                    \
    qt/OpenRGBZoneResizeDialog.h                                                                \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsEntry.h                                   \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsPage.h                                    \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsEntry.h                               \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsPage.h                                \
    qt/OpenRGBZonesBulkResizer.h                                                                \
    qt/QTooltipedSlider.h                                                                       \
    qt/TabLabel.h                                                                               \
    serial_port/find_usb_serial_port.h                                                          \
    serial_port/serial_port.h                                                                   \
    super_io/super_io.h                                                                         \
    AutoStart/AutoStart.h                                                                       \
    RGBController/RGBController.h                                                               \
    RGBController/RGBController_Dummy.h                                                         \
    RGBController/RGBControllerKeyNames.h                                                       \
    RGBController/RGBController_Network.h                                                       \

contains(QMAKE_PLATFORM, freebsd) {
    HEADERS -=                                                                                  \
        Controllers/GigabyteRGBFusion2GPUController/GigabyteRGBFusion2GPUController.h           \
        Controllers/GigabyteRGBFusion2GPUController/RGBController_GigabyteRGBFusion2GPU.h       \
        Controllers/HoltekController/HoltekA070Controller.h                                     \
        Controllers/HoltekController/HoltekA1FAController.h                                     \
        Controllers/HoltekController/RGBController_HoltekA070.h                                 \
        Controllers/HoltekController/RGBController_HoltekA1FA.h
}

SOURCES +=                                                                                      \
    Controllers/HWKeyboardController/HWKeyboardController.cpp \
    Controllers/HWKeyboardController/HWKeyboardControllerDetect.cpp \
    Controllers/HWKeyboardController/RGBController_HWKeyboard.cpp \
    dependencies/Swatches/swatches.cpp                                                          \
    dependencies/dmiinfo.cpp                                                                    \
    dependencies/ColorWheel/ColorWheel.cpp                                                      \
    dependencies/hueplusplus-1.0.0/src/Action.cpp                                               \
    dependencies/hueplusplus-1.0.0/src/APICache.cpp                                             \
    dependencies/hueplusplus-1.0.0/src/BaseDevice.cpp                                           \
    dependencies/hueplusplus-1.0.0/src/BaseHttpHandler.cpp                                      \
    dependencies/hueplusplus-1.0.0/src/Bridge.cpp                                               \
    dependencies/hueplusplus-1.0.0/src/BridgeConfig.cpp                                         \
    dependencies/hueplusplus-1.0.0/src/CLIPSensors.cpp                                          \
    dependencies/hueplusplus-1.0.0/src/ColorUnits.cpp                                           \
    dependencies/hueplusplus-1.0.0/src/EntertainmentMode.cpp                                    \
    dependencies/hueplusplus-1.0.0/src/ExtendedColorHueStrategy.cpp                             \
    dependencies/hueplusplus-1.0.0/src/ExtendedColorTemperatureStrategy.cpp                     \
    dependencies/hueplusplus-1.0.0/src/Group.cpp                                                \
    dependencies/hueplusplus-1.0.0/src/HueCommandAPI.cpp                                        \
    dependencies/hueplusplus-1.0.0/src/HueDeviceTypes.cpp                                       \
    dependencies/hueplusplus-1.0.0/src/HueException.cpp                                         \
    dependencies/hueplusplus-1.0.0/src/Light.cpp                                                \
    dependencies/hueplusplus-1.0.0/src/ModelPictures.cpp                                        \
    dependencies/hueplusplus-1.0.0/src/NewDeviceList.cpp                                        \
    dependencies/hueplusplus-1.0.0/src/Scene.cpp                                                \
    dependencies/hueplusplus-1.0.0/src/Schedule.cpp                                             \
    dependencies/hueplusplus-1.0.0/src/Sensor.cpp                                               \
    dependencies/hueplusplus-1.0.0/src/SimpleBrightnessStrategy.cpp                             \
    dependencies/hueplusplus-1.0.0/src/SimpleColorHueStrategy.cpp                               \
    dependencies/hueplusplus-1.0.0/src/SimpleColorTemperatureStrategy.cpp                       \
    dependencies/hueplusplus-1.0.0/src/StateTransaction.cpp                                     \
    dependencies/hueplusplus-1.0.0/src/TimePattern.cpp                                          \
    dependencies/hueplusplus-1.0.0/src/UPnP.cpp                                                 \
    dependencies/hueplusplus-1.0.0/src/Utils.cpp                                                \
    dependencies/hueplusplus-1.0.0/src/ZLLSensors.cpp                                           \
    dependencies/libe131/src/e131.c                                                             \
    dependencies/libcmmk/src/libcmmk.c                                                          \
    main.cpp                                                                                    \
    cli.cpp                                                                                     \
    LogManager.cpp                                                                              \
    NetworkClient.cpp                                                                           \
    NetworkServer.cpp                                                                           \
    PluginManager.cpp                                                                           \
    ProfileManager.cpp                                                                          \
    ResourceManager.cpp                                                                         \
    SettingsManager.cpp                                                                         \
    qt/DetectorTableModel.cpp                                                                   \
    qt/HelloWordDFUPage.cpp \
    qt/OpenRGBClientInfoPage.cpp                                                                \
    qt/OpenRGBConsolePage.cpp                                                                   \
    qt/OpenRGBDeviceInfoPage.cpp                                                                \
    qt/OpenRGBDevicePage.cpp                                                                    \
    qt/OpenRGBDialog.cpp                                                                        \
    i2c_smbus/i2c_smbus.cpp                                                                     \
    i2c_tools/i2c_tools.cpp                                                                     \
    net_port/net_port.cpp                                                                       \
    qt/DeviceView.cpp                                                                           \
    qt/OpenRGBDialog2.cpp                                                                       \
    qt/OpenRGBPluginContainer.cpp                                                               \
    qt/OpenRGBPluginsPage/OpenRGBPluginsEntry.cpp                                               \
    qt/OpenRGBPluginsPage/OpenRGBPluginsList.cpp                                                \
    qt/OpenRGBPluginsPage/OpenRGBPluginsPage.cpp                                                \
    qt/OpenRGBProfileSaveDialog.cpp                                                             \
    qt/OpenRGBServerInfoPage.cpp                                                                \
    qt/OpenRGBSettingsPage.cpp                                                                  \
    qt/OpenRGBSoftwareInfoPage.cpp                                                              \
    qt/OpenRGBSupportedDevicesPage.cpp                                                          \
    qt/OpenRGBSystemInfoPage.cpp                                                                \
    qt/OpenRGBThemeManager.cpp                                                                  \
    qt/OpenRGBZoneResizeDialog.cpp                                                              \
    qt/OpenRGBZonesBulkResizer.cpp                                                              \
    qt/QTooltipedSlider.cpp                                                                     \
    qt/TabLabel.cpp                                                                             \
    qt/hsv.cpp                                                                                  \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsEntry.cpp                                 \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsPage.cpp                                  \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsEntry.cpp                             \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsPage.cpp                              \
    serial_port/serial_port.cpp                                                                 \
    super_io/super_io.cpp                                                                       \
    AutoStart/AutoStart.cpp                                                                     \
    RGBController/RGBController.cpp                                                             \
    RGBController/RGBController_Dummy.cpp                                                       \
    RGBController/RGBControllerKeyNames.cpp                                                     \
    RGBController/RGBController_Network.cpp                                                     \

contains(QMAKE_PLATFORM, freebsd) {
    SOURCES -=                                                                                  \
        Controllers/GigabyteRGBFusion2GPUController/GigabyteRGBFusion2GPUController.cpp         \
        Controllers/GigabyteRGBFusion2GPUController/GigabyteRGBFusion2GPUControllerDetect.cpp   \
        Controllers/GigabyteRGBFusion2GPUController/RGBController_GigabyteRGBFusion2GPU.cpp     \
        Controllers/HoltekController/HoltekA070Controller.cpp                                   \
        Controllers/HoltekController/HoltekA1FAController.cpp                                   \
        Controllers/HoltekController/HoltekControllerDetect.cpp                                 \
        Controllers/HoltekController/RGBController_HoltekA070.cpp                               \
        Controllers/HoltekController/RGBController_HoltekA1FA.cpp
}

RESOURCES +=                                                                                    \
    qt/resources.qrc                                                                            \

TRANSLATIONS +=                                                                                 \
    qt/i18n/OpenRGB_de.ts                                                                       \
    qt/i18n/OpenRGB_en.ts                                                                       \
    qt/i18n/OpenRGB_en_AU.ts                                                                    \
    qt/i18n/OpenRGB_en_GB.ts                                                                    \
    qt/i18n/OpenRGB_es.ts                                                                       \
    qt/i18n/OpenRGB_fr.ts                                                                       \
    qt/i18n/OpenRGB_ms_MY.ts                                                                    \
    qt/i18n/OpenRGB_pl.ts                                                                       \
    qt/i18n/OpenRGB_pt_BR.ts                                                                    \
    qt/i18n/OpenRGB_ru.ts                                                                       \
    qt/i18n/OpenRGB_zh.ts                                                                       \
    qt/i18n/OpenRGB_zh_TW.ts                                                                    \

FORMS +=                                                                                        \
    qt/HelloWordDFUPage_UI.ui \
    qt/OpenRGBClientInfoPage.ui                                                                 \
    qt/OpenRGBConsolePage.ui                                                                    \
    qt/OpenRGBDeviceInfoPage.ui                                                                 \
    qt/OpenRGBDevicePage.ui                                                                     \
    qt/OpenRGBDialog.ui                                                                         \
    qt/OpenRGBDialog2.ui                                                                        \
    qt/OpenRGBPluginContainer.ui                                                                \
    qt/OpenRGBProfileSaveDialog.ui                                                              \
    qt/OpenRGBServerInfoPage.ui                                                                 \
    qt/OpenRGBSettingsPage.ui                                                                   \
    qt/OpenRGBSoftwareInfoPage.ui                                                               \
    qt/OpenRGBSupportedDevicesPage.ui                                                           \
    qt/OpenRGBSystemInfoPage.ui                                                                 \
    qt/OpenRGBZoneResizeDialog.ui                                                               \
    qt/OpenRGBPluginsPage/OpenRGBPluginsEntry.ui                                                \
    qt/OpenRGBPluginsPage/OpenRGBPluginsPage.ui                                                 \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsEntry.ui                                  \
    qt/OpenRGBSerialSettingsPage/OpenRGBSerialSettingsPage.ui                                   \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsEntry.ui                              \
    qt/OpenRGBYeelightSettingsPage/OpenRGBYeelightSettingsPage.ui                               \
    qt/OpenRGBZonesBulkResizer.ui                                                               \
    qt/TabLabel.ui

#-----------------------------------------------------------------------------------------------#
# Windows-specific Configuration                                                                #
#-----------------------------------------------------------------------------------------------#
win32:INCLUDEPATH +=                                                                            \
    dependencies/display-library/include                                                        \
    dependencies/hidapi                                                                         \
    dependencies/winring0/include                                                               \
    dependencies/libusb-1.0.22/include                                                          \
    dependencies/mbedtls-2.24.0/include                                                         \
    dependencies/NVFC                                                                           \
    dependencies/openrazer-win32                                                                \
    wmi/                                                                                        \


win32:SOURCES +=                                                                                \
#   dependencies/hidapi/hidapi.c                                                                \
    dependencies/hueplusplus-1.0.0/src/WinHttpHandler.cpp                                       \
    dependencies/mbedtls-2.24.0/library/aes.c                                                   \
    dependencies/mbedtls-2.24.0/library/aesni.c                                                 \
    dependencies/mbedtls-2.24.0/library/arc4.c                                                  \
    dependencies/mbedtls-2.24.0/library/aria.c                                                  \
    dependencies/mbedtls-2.24.0/library/asn1parse.c                                             \
    dependencies/mbedtls-2.24.0/library/asn1write.c                                             \
    dependencies/mbedtls-2.24.0/library/base64.c                                                \
    dependencies/mbedtls-2.24.0/library/bignum.c                                                \
    dependencies/mbedtls-2.24.0/library/blowfish.c                                              \
    dependencies/mbedtls-2.24.0/library/camellia.c                                              \
    dependencies/mbedtls-2.24.0/library/ccm.c                                                   \
    dependencies/mbedtls-2.24.0/library/certs.c                                                 \
    dependencies/mbedtls-2.24.0/library/chacha20.c                                              \
    dependencies/mbedtls-2.24.0/library/chachapoly.c                                            \
    dependencies/mbedtls-2.24.0/library/cipher.c                                                \
    dependencies/mbedtls-2.24.0/library/cipher_wrap.c                                           \
    dependencies/mbedtls-2.24.0/library/cmac.c                                                  \
    dependencies/mbedtls-2.24.0/library/ctr_drbg.c                                              \
    dependencies/mbedtls-2.24.0/library/debug.c                                                 \
    dependencies/mbedtls-2.24.0/library/des.c                                                   \
    dependencies/mbedtls-2.24.0/library/dhm.c                                                   \
    dependencies/mbedtls-2.24.0/library/ecdh.c                                                  \
    dependencies/mbedtls-2.24.0/library/ecdsa.c                                                 \
    dependencies/mbedtls-2.24.0/library/ecjpake.c                                               \
    dependencies/mbedtls-2.24.0/library/ecp.c                                                   \
    dependencies/mbedtls-2.24.0/library/ecp_curves.c                                            \
    dependencies/mbedtls-2.24.0/library/entropy.c                                               \
    dependencies/mbedtls-2.24.0/library/entropy_poll.c                                          \
    dependencies/mbedtls-2.24.0/library/error.c                                                 \
    dependencies/mbedtls-2.24.0/library/gcm.c                                                   \
    dependencies/mbedtls-2.24.0/library/havege.c                                                \
    dependencies/mbedtls-2.24.0/library/hkdf.c                                                  \
    dependencies/mbedtls-2.24.0/library/hmac_drbg.c                                             \
    dependencies/mbedtls-2.24.0/library/md.c                                                    \
    dependencies/mbedtls-2.24.0/library/md2.c                                                   \
    dependencies/mbedtls-2.24.0/library/md4.c                                                   \
    dependencies/mbedtls-2.24.0/library/md5.c                                                   \
    dependencies/mbedtls-2.24.0/library/memory_buffer_alloc.c                                   \
    dependencies/mbedtls-2.24.0/library/net_sockets.c                                           \
    dependencies/mbedtls-2.24.0/library/nist_kw.c                                               \
    dependencies/mbedtls-2.24.0/library/oid.c                                                   \
    dependencies/mbedtls-2.24.0/library/padlock.c                                               \
    dependencies/mbedtls-2.24.0/library/pem.c                                                   \
    dependencies/mbedtls-2.24.0/library/pk.c                                                    \
    dependencies/mbedtls-2.24.0/library/pk_wrap.c                                               \
    dependencies/mbedtls-2.24.0/library/pkcs5.c                                                 \
    dependencies/mbedtls-2.24.0/library/pkcs11.c                                                \
    dependencies/mbedtls-2.24.0/library/pkcs12.c                                                \
    dependencies/mbedtls-2.24.0/library/pkparse.c                                               \
    dependencies/mbedtls-2.24.0/library/pkwrite.c                                               \
    dependencies/mbedtls-2.24.0/library/platform.c                                              \
    dependencies/mbedtls-2.24.0/library/platform_util.c                                         \
    dependencies/mbedtls-2.24.0/library/poly1305.c                                              \
    dependencies/mbedtls-2.24.0/library/psa_crypto.c                                            \
    dependencies/mbedtls-2.24.0/library/psa_crypto_se.c                                         \
    dependencies/mbedtls-2.24.0/library/psa_crypto_slot_management.c                            \
    dependencies/mbedtls-2.24.0/library/psa_crypto_storage.c                                    \
    dependencies/mbedtls-2.24.0/library/psa_its_file.c                                          \
    dependencies/mbedtls-2.24.0/library/ripemd160.c                                             \
    dependencies/mbedtls-2.24.0/library/rsa.c                                                   \
    dependencies/mbedtls-2.24.0/library/rsa_internal.c                                          \
    dependencies/mbedtls-2.24.0/library/sha1.c                                                  \
    dependencies/mbedtls-2.24.0/library/sha256.c                                                \
    dependencies/mbedtls-2.24.0/library/sha512.c                                                \
    dependencies/mbedtls-2.24.0/library/ssl_cache.c                                             \
    dependencies/mbedtls-2.24.0/library/ssl_ciphersuites.c                                      \
    dependencies/mbedtls-2.24.0/library/ssl_cli.c                                               \
    dependencies/mbedtls-2.24.0/library/ssl_cookie.c                                            \
    dependencies/mbedtls-2.24.0/library/ssl_msg.c                                               \
    dependencies/mbedtls-2.24.0/library/ssl_srv.c                                               \
    dependencies/mbedtls-2.24.0/library/ssl_ticket.c                                            \
    dependencies/mbedtls-2.24.0/library/ssl_tls.c                                               \
    dependencies/mbedtls-2.24.0/library/threading.c                                             \
    dependencies/mbedtls-2.24.0/library/timing.c                                                \
    dependencies/mbedtls-2.24.0/library/version.c                                               \
    dependencies/mbedtls-2.24.0/library/version_features.c                                      \
    dependencies/mbedtls-2.24.0/library/x509.c                                                  \
    dependencies/mbedtls-2.24.0/library/x509_create.c                                           \
    dependencies/mbedtls-2.24.0/library/x509_crl.c                                              \
    dependencies/mbedtls-2.24.0/library/x509_crt.c                                              \
    dependencies/mbedtls-2.24.0/library/x509_csr.c                                              \
    dependencies/mbedtls-2.24.0/library/x509write_crt.c                                         \
    dependencies/mbedtls-2.24.0/library/x509write_csr.c                                         \
    dependencies/mbedtls-2.24.0/library/xtea.c                                                  \
    dependencies/NVFC/nvapi.cpp                                                                 \
    i2c_smbus/i2c_smbus_amdadl.cpp                                                              \
    i2c_smbus/i2c_smbus_i801.cpp                                                                \
    i2c_smbus/i2c_smbus_nct6775.cpp                                                             \
    i2c_smbus/i2c_smbus_nvapi.cpp                                                               \
    i2c_smbus/i2c_smbus_piix4.cpp                                                               \
    serial_port/find_usb_serial_port_win.cpp                                                    \
    wmi/wmi.cpp                                                                                 \
    wmi/acpiwmi.cpp                                                                             \
    AutoStart/AutoStart-Windows.cpp                                                             \


win32:HEADERS +=                                                                                \
    dependencies/display-library/include/adl_defines.h                                          \
    dependencies/display-library/include/adl_sdk.h                                              \
    dependencies/display-library/include/adl_structures.h                                       \
    dependencies/winring0/include/OlsApi.h                                                      \
    dependencies/NVFC/nvapi.h                                                                   \
    i2c_smbus/i2c_smbus_i801.h                                                                  \
    i2c_smbus/i2c_smbus_nct6775.h                                                               \
    i2c_smbus/i2c_smbus_nvapi.h                                                                 \
    i2c_smbus/i2c_smbus_piix4.h                                                                 \
    wmi/wmi.h                                                                                   \
    wmi/acpiwmi.h                                                                               \
    AutoStart/AutoStart-Windows.h                                                               \


win32:contains(QMAKE_TARGET.arch, x86_64) {
    LIBS +=                                                                                     \
        -lws2_32                                                                                \
        -liphlpapi                                                                              \
        -L"$$PWD/dependencies/winring0/x64/" -lWinRing0x64                                      \
        -L"$$PWD/dependencies/libusb-1.0.22/MS64/dll" -llibusb-1.0                              \
        -L"$$PWD/dependencies/hidapi-win/x64/" -lhidapi                                         \
}

win32:contains(QMAKE_TARGET.arch, x86) {
    LIBS +=                                                                                     \
        -lws2_32                                                                                \
        -liphlpapi                                                                              \
        -L"$$PWD/dependencies/winring0/Win32/" -lWinRing0                                       \
        -L"$$PWD/dependencies/libusb-1.0.22/MS32/dll" -llibusb-1.0                              \
        -L"$$PWD/dependencies/hidapi-win/x86/" -lhidapi                                         \
}

win32:DEFINES -=                                                                                \
    UNICODE

win32:DEFINES +=                                                                                \
    USE_HID_USAGE                                                                               \
    _MBCS                                                                                       \
    WIN32                                                                                       \
    _CRT_SECURE_NO_WARNINGS                                                                     \
    _WINSOCK_DEPRECATED_NO_WARNINGS                                                             \
    WIN32_LEAN_AND_MEAN                                                                         \

win32:RC_ICONS +=                                                                               \
    qt/OpenRGB.ico

#-----------------------------------------------------------------------------------------------#
# Windows GitLab CI Configuration                                                               #
#-----------------------------------------------------------------------------------------------#
win32:CONFIG(debug, debug|release) {
    win32:DESTDIR = debug
}

win32:CONFIG(release, debug|release) {
    win32:DESTDIR = release
}

win32:OBJECTS_DIR = _intermediate_$$DESTDIR/.obj
win32:MOC_DIR     = _intermediate_$$DESTDIR/.moc
win32:RCC_DIR     = _intermediate_$$DESTDIR/.qrc
win32:UI_DIR      = _intermediate_$$DESTDIR/.ui

#-----------------------------------------------------------------------------------------------#
# Copy dependencies to output directory                                                         #
#-----------------------------------------------------------------------------------------------#

win32:contains(QMAKE_TARGET.arch, x86_64) {
    copydata.commands  = $(COPY_FILE) \"$$shell_path($$PWD/dependencies/openrazer-win32/OpenRazer64.dll      )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/winring0/x64/WinRing0x64.dll         )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/winring0/x64/WinRing0x64.sys         )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/libusb-1.0.22/MS64/dll/libusb-1.0.dll)\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/hidapi-win/x64/hidapi.dll            )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

win32:contains(QMAKE_TARGET.arch, x86) {
    copydata.commands  = $(COPY_FILE) \"$$shell_path($$PWD/dependencies/openrazer-win32/OpenRazer.dll        )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/winring0/Win32/WinRing0.dll          )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/winring0/Win32/WinRing0.sys          )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/winring0/x64/WinRing0x64.sys         )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/libusb-1.0.22/MS32/dll/libusb-1.0.dll)\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)
    copydata.commands += $(COPY_FILE) \"$$shell_path($$PWD/dependencies/hidapi-win/x86/hidapi.dll            )\" \"$$shell_path($$DESTDIR)\" $$escape_expand(\n\t)

    first.depends = $(first) copydata
    export(first.depends)
    export(copydata.commands)
    QMAKE_EXTRA_TARGETS += first copydata
}

#-----------------------------------------------------------------------------------------------#
# Linux-specific Configuration                                                                  #
#-----------------------------------------------------------------------------------------------#
contains(QMAKE_PLATFORM, linux) {
    TARGET = $$lower($$TARGET)

    INCLUDEPATH +=                                                                              \
    Controllers/FaustusController                                                               \
    Controllers/LinuxLEDController                                                              \

    HEADERS +=                                                                                  \
    i2c_smbus/i2c_smbus_linux.h                                                                 \
    AutoStart/AutoStart-Linux.h                                                                 \
    Controllers/AsusTUFLaptopLinuxController/AsusTUFLaptopLinuxController.h                     \
    Controllers/AsusTUFLaptopLinuxController/RGBController_AsusTUFLaptopLinux.h                 \
    Controllers/ENESMBusController/ENESMBusInterface/ENESMBusInterface_SpectrixS40G.h           \
    Controllers/FaustusController/RGBController_Faustus.h                                       \
    Controllers/LinuxLEDController/LinuxLEDController.h                                         \
    Controllers/LinuxLEDController/RGBController_LinuxLED.h                                     \
    Controllers/OpenRazerController/RGBController_OpenRazer.h                                   \

    LIBS +=                                                                                     \
    -lusb-1.0                                                                                   \
    -lmbedx509                                                                                  \
    -lmbedtls                                                                                   \
    -lmbedcrypto                                                                                \
    -ldl                                                                                        \

    COMPILER_VERSION = $$system($$QMAKE_CXX " -dumpversion")
    if (!versionAtLeast(COMPILER_VERSION, "9")) {
         LIBS += -lstdc++fs
    }

    QMAKE_CXXFLAGS += -Wno-implicit-fallthrough

    #-------------------------------------------------------------------------------------------#
    # Determine which hidapi to use based on availability                                       #
    #   Prefer hidraw backend, then libusb                                                      #
    #-------------------------------------------------------------------------------------------#
    packagesExist(hidapi-hidraw) {
        LIBS += -lhidapi-hidraw

        #---------------------------------------------------------------------------------------#
        # hidapi-hidraw >= 0.10.1 supports USAGE/USAGE_PAGE                                     #
        # Define USE_HID_USAGE if hidapi-hidraw supports it                                     #
        #---------------------------------------------------------------------------------------#
        HIDAPI_HIDRAW_VERSION = $$system($$PKG_CONFIG --modversion hidapi-hidraw)
        if(versionAtLeast(HIDAPI_HIDRAW_VERSION, "0.10.1")) {
            DEFINES += USE_HID_USAGE
        }
    } else {
        packagesExist(hidapi-libusb) {
            LIBS += -lhidapi-libusb
        } else {
            LIBS += -lhidapi
        }
    }

    SOURCES +=                                                                                  \
    dependencies/hueplusplus-1.0.0/src/LinHttpHandler.cpp                                       \
    i2c_smbus/i2c_smbus_linux.cpp                                                               \
    serial_port/find_usb_serial_port_linux.cpp                                                  \
    AutoStart/AutoStart-Linux.cpp                                                               \
    Controllers/AsusTUFLaptopLinuxController/AsusTUFLaptopLinuxController.cpp                   \
    Controllers/AsusTUFLaptopLinuxController/AsusTUFLaptopLinuxDetect.cpp                       \
    Controllers/AsusTUFLaptopLinuxController/RGBController_AsusTUFLaptopLinux.cpp               \
    Controllers/ENESMBusController/XPGSpectrixS40GDetect.cpp                                    \
    Controllers/ENESMBusController/ENESMBusInterface/ENESMBusInterface_SpectrixS40G.cpp         \
    Controllers/FaustusController/RGBController_Faustus.cpp                                     \
    Controllers/LinuxLEDController/LinuxLEDController.cpp                                       \
    Controllers/LinuxLEDController/LinuxLEDControllerDetect.cpp                                 \
    Controllers/LinuxLEDController/RGBController_LinuxLED.cpp                                   \
    Controllers/OpenRazerController/OpenRazerDetect.cpp                                         \
    Controllers/OpenRazerController/RGBController_OpenRazer.cpp                                 \

    #-------------------------------------------------------------------------------------------#
    # Set up install paths                                                                      #
    # These install paths are used for AppImage and .deb packaging                              #
    #-------------------------------------------------------------------------------------------#
    isEmpty(PREFIX) {
        PREFIX = /usr
    }

    #-------------------------------------------------------------------------------------------#
    # Custom target for dynamically created udev_rules                                          #
    #   Ordinarily you would add the 'udev_rules' target to both QMAKE_EXTRA_TARGETS to add a   #
    #   rule in the Makefile and PRE_TARGETDEPS to ensure it is a dependency of the TARGET      #
    #                                                                                           #
    #   ie. QMAKE_EXTRA_TARGETS += udev_rules                                                   #
    #       PRE_TARGETDEPS      += udev_rules                                                   #
    #-------------------------------------------------------------------------------------------#
    CONFIG(release, debug|release) {
        udev_rules.CONFIG       = no_check_exist
        udev_rules.target       = 60-openrgb.rules
        udev_rules.path         = $$PREFIX/lib/udev/rules.d/

        exists($$udev_rules.target) {
            message($$udev_rules.target " - UDEV rules file exists. Removing from build")
            udev_rules.files    = $$udev_rules.target
        } else {
            message($$udev_rules.target " - UDEV rules file missing. Adding script to build")
            #-------------------------------------------------------------------------------------------#
            # This is a compiler config flag to save the preproccessed .ii & .s                         #
            #   files so as to automatically process the UDEV rules and the Supported Devices           #
            #-------------------------------------------------------------------------------------------#
            QMAKE_CXXFLAGS+=-save-temps
            QMAKE_CXXFLAGS-=-pipe
            udev_rules.extra    = $$PWD/scripts/build-udev-rules.sh $$PWD $$GIT_COMMIT_ID
            udev_rules.files    = $$OUT_PWD/60-openrgb.rules
        }
    }

    #-------------------------------------------------------------------------------------------#
    # Add static files to installation                                                                      #
    #-------------------------------------------------------------------------------------------#
    target.path=$$PREFIX/bin/
    desktop.path=$$PREFIX/share/applications/
    desktop.files+=qt/OpenRGB.desktop
    icon.path=$$PREFIX/share/icons/hicolor/128x128/apps/
    icon.files+=qt/OpenRGB.png
    metainfo.path=$$PREFIX/share/metainfo/
    metainfo.files+=qt/org.openrgb.OpenRGB.metainfo.xml
    INSTALLS += target desktop icon metainfo udev_rules
}

#-----------------------------------------------------------------------------------------------#
# FreeBSD-specific Configuration                                                                #
#-----------------------------------------------------------------------------------------------#
contains(QMAKE_PLATFORM, freebsd) {
    TARGET = $$lower($$TARGET)

    INCLUDEPATH +=                                                                              \
    Controllers/FaustusController                                                               \
    Controllers/LinuxLEDController                                                              \

    HEADERS +=                                                                                  \
    AutoStart/AutoStart-FreeBSD.h                                                               \
    Controllers/ENESMBusController/ENESMBusInterface/ENESMBusInterface_SpectrixS40G.h           \
    Controllers/FaustusController/RGBController_Faustus.h                                       \
    Controllers/LinuxLEDController/LinuxLEDController.h                                         \
    Controllers/LinuxLEDController/RGBController_LinuxLED.h                                     \
    Controllers/OpenRazerController/RGBController_OpenRazer.h                                   \

    LIBS +=                                                                                     \
    -lusb                                                                                       \
    -lmbedx509                                                                                  \
    -lmbedtls                                                                                   \
    -lmbedcrypto                                                                                \

    COMPILER_VERSION = $$system($$QMAKE_CXX " -dumpversion")
    if (!versionAtLeast(COMPILER_VERSION, "9")) {
         LIBS += -lstdc++fs
    }

    #-------------------------------------------------------------------------------------------#
    # Determine which hidapi to use based on availability                                       #
    #   Prefer hidraw backend, then libusb                                                      #
    #-------------------------------------------------------------------------------------------#
    packagesExist(hidapi-hidraw) {
        LIBS += -lhidapi-hidraw

        #---------------------------------------------------------------------------------------#
        # hidapi-hidraw >= 0.10.1 supports USAGE/USAGE_PAGE                                     #
        # Define USE_HID_USAGE if hidapi-hidraw supports it                                     #
        #---------------------------------------------------------------------------------------#
        HIDAPI_HIDRAW_VERSION = $$system($$PKG_CONFIG --modversion hidapi-hidraw)
        if(versionAtLeast(HIDAPI_HIDRAW_VERSION, "0.10.1")) {
            DEFINES += USE_HID_USAGE
        }
    } else {
        packagesExist(hidapi-libusb) {
            LIBS += -lhidapi-libusb
        } else {
            LIBS += -lhidapi
        }
    }

    SOURCES +=                                                                                  \
    dependencies/hueplusplus-1.0.0/src/LinHttpHandler.cpp                                       \
    serial_port/find_usb_serial_port_linux.cpp                                                  \
    AutoStart/AutoStart-FreeBSD.cpp                                                             \
    Controllers/ENESMBusController/XPGSpectrixS40GDetect.cpp                                    \
    Controllers/ENESMBusController/ENESMBusInterface/ENESMBusInterface_SpectrixS40G.cpp         \
    Controllers/FaustusController/RGBController_Faustus.cpp                                     \
    Controllers/LinuxLEDController/LinuxLEDController.cpp                                       \
    Controllers/LinuxLEDController/LinuxLEDControllerDetect.cpp                                 \
    Controllers/LinuxLEDController/RGBController_LinuxLED.cpp                                   \
    Controllers/OpenRazerController/OpenRazerDetect.cpp                                         \
    Controllers/OpenRazerController/RGBController_OpenRazer.cpp                                 \

    #-------------------------------------------------------------------------------------------#
    # Set up install paths                                                                      #
    # These install paths are used for AppImage and .deb packaging                              #
    #-------------------------------------------------------------------------------------------#
    isEmpty(PREFIX) {
        PREFIX = /usr
    }

    target.path=$$PREFIX/bin/
    desktop.path=$$PREFIX/share/applications/
    desktop.files+=qt/OpenRGB.desktop
    icon.path=$$PREFIX/share/icons/hicolor/128x128/apps/
    icon.files+=qt/OpenRGB.png
    metainfo.path=$$PREFIX/share/metainfo/
    metainfo.files+=qt/org.openrgb.OpenRGB.metainfo.xml
    rules.path=$$PREFIX/lib/udev/rules.d/
    rules.files+=60-openrgb.rules
    INSTALLS += target desktop icon metainfo rules
}

unix:!macx:CONFIG(asan) {
    message("ASan Mode")
    QMAKE_CFLAGS=-fsanitize=address
    QMAKE_CXXFLAGS=-fsanitize=address
    QMAKE_LFLAGS=-fsanitize=address
}

#-----------------------------------------------------------------------------------------------#
# MacOS-specific Configuration                                                                  #
#-----------------------------------------------------------------------------------------------#
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.15

macx:ICON = qt/OpenRGB.icns

#-------------------------------------------------------------------------------------------#
# Common MacOS definitions                                                                  #
#-------------------------------------------------------------------------------------------#
macx {
    DEFINES +=                                                                                  \
    USE_HID_USAGE                                                                               \

    QMAKE_CXXFLAGS +=                                                                           \
    -Wno-narrowing                                                                              \

    HEADERS +=                                                                                  \
    AutoStart/AutoStart-MacOS.h                                                                 \
    qt/macutils.h                                                                               \

    SOURCES +=                                                                                  \
    dependencies/hueplusplus-1.0.0/src/LinHttpHandler.cpp                                       \
    serial_port/find_usb_serial_port_linux.cpp                                                  \
    AutoStart/AutoStart-MacOS.cpp                                                               \
    qt/macutils.mm                                                                              \

    # Use mbedtls v2 instead of latest
    MBEDTLS_PREFIX = $$system(brew --prefix mbedtls@2)

    INCLUDEPATH +=                                                                              \
    $$MBEDTLS_PREFIX/include                                                                    \

    LIBS +=                                                                                     \
    -lusb-1.0                                                                                   \
    -lhidapi                                                                                    \
    -lmbedx509                                                                                  \
    -lmbedcrypto                                                                                \
    -lmbedtls                                                                                   \
    -L$$MBEDTLS_PREFIX/lib                                                                      \
}

#-------------------------------------------------------------------------------------------#
# Apple Silicon (arm64) Homebrew installs at /opt/homebrew                                  #
#-------------------------------------------------------------------------------------------#
macx:contains(QMAKE_HOST.arch, arm64) {
    INCLUDEPATH +=                                                                              \
    /opt/homebrew/include                                                                       \

    LIBS +=                                                                                     \
    -L/opt/homebrew/lib                                                                         \
}

#-------------------------------------------------------------------------------------------#
# Intel (x86_64) Homebrew installs at /usr/local/lib                                        #
#-------------------------------------------------------------------------------------------#
macx:contains(QMAKE_HOST.arch, x86_64) {
    INCLUDEPATH +=                                                                              \
    dependencies/macUSPCIO                                                                      \
    /usr/local/include                                                                          \
    /usr/local/homebrew/include                                                                 \

    SOURCES +=                                                                                  \
    i2c_smbus/i2c_smbus_i801.cpp                                                                \

    HEADERS +=                                                                                  \
    dependencies/macUSPCIO/macUSPCIOAccess.h                                                    \
    i2c_smbus/i2c_smbus_i801.h                                                                  \

    LIBS +=                                                                                     \
    -L/usr/local/lib                                                                            \
    -L/usr/local/homebrew/lib                                                                   \

    DEFINES +=                                                                                  \
    _MACOSX_X86_X64                                                                             \
}

DISTFILES += \
    debian/openrgb-udev.postinst \
    debian/openrgb.postinst
