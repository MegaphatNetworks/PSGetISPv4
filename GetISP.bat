@echo off
rem Be sure to put this file in your %systemroot% folder
cd C:\Users\Gabriel\Desktop\Dev\wget\Complete\v04\
Echo GetISP IPv4 Block - (c) 2020 Megaphat Networks
Echo Retrieve the Country and ISP information for a specific IPv4 address.
Echo Usage: GetBlock 8.8.8.8
Echo -
powershell -ep bypass .\getblock.ps1 %1
