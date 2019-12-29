import os
import time
import datetime

#Turn on the hotspot
def WiFiOn():
    os.system("powershell -executionpolicy RemoteSigned -file wifi_on.ps1") 

#Turn off the hotspot
def WiFiOff():
    os.system("powershell -executionpolicy RemoteSigned -file wifi_off.ps1")


while True:
    WiFiOn()
    print(f"{str(datetime.datetime.now())} --- WiFi set to On")
    time.sleep(300) #Working Timer in seconds
    WiFiOff()
    print(f"{str(datetime.datetime.now())} --- WiFi set to Off")
    time.sleep(3) #Delay for reloading in seconds
    
