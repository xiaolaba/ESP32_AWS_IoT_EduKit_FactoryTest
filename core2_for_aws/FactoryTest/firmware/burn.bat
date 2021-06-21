REM AWS_Core2 FactoryTest
REM firmware for burn & test

:: To erase esp32 completely, do not rely on Arduino IDE and code upload, it has cluster and odd thing when uses FATFS, 
:: unless format SPIFFS or FATFS everytime on the fly
:: xiaolaba, 2020-MAR-02
:: Arduino 1.8.13, esptool and path,

cls
@echo AWS_Core2 FactoryTest, burn firmware
@echo xiaolaba, 2021-06-21, test done.
@echo.
@echo off

set comport=COM5
::set esptoolpath="C:\Users\user0\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\3.0.0/esptool.exe"
set esptoolpath="esptool.exe"
set project=FactoryTest


:::: erase whole flash of esp32
:::: remove two coluns if yoy want to enable the erase process
::%esptoolpath% --chip esp32 ^
::--port %comport% ^
::--baud 921600 ^
::erase_flash


pause

REM burn firmware
%esptoolpath% ^
--chip esp32 ^
--port %comport% ^
--baud 921600 ^
--before default_reset ^
--after hard_reset write_flash -z ^
--flash_mode dio ^
--flash_freq 80m ^
--flash_size detect ^
0xe000 boot_app0.bin ^
0x1000 bootloader_dio_80m.bin ^
0x10000 %project%.ino.bin ^
0x8000 %project%.ino.partitions.bin

pause


