
# Longfor-Smart-Building-Project

Longfor(http://www.longfor.com/)
is the top 5 Real Estate company in China, and the first adopt Azure IoT Hub,
Stream Analytics in their Smart Building Solution on August 2016. Due to this technical
engagement, Longfor signed 100k$ Azure deal for deployment their smart building
solution. 

As L300 request, I mention 3 parts contribution on this project as following:
## 1. Solution Architect

Before 2016, Longfor built V1.0 smart building system, and deploy 20k sensor to collectiing building operation data, including power data, elevator operation data etc.

![Smart Building System V1.0 Architect](/Images/Old Architect.PNG)

There are some suffer issue on this version, such as :
- Take more cost and time on transfer data between region site to monitor certer
- Too complex to deploy new feature on this region architect
- No realtime whole buildings monitor view
- No realtime alert functionality

After discussion with Longfor team, and leverage Azure IoT Services, we redefine Longfor Smart Buliding Solution Architect. 

![Smart Building System V1.0 Architect](/Images/New Architect.PNG)

## 2. FEC Linux EasyARM-iMX257 IoT Hub SDK Integration

In this project, Longfor team use FEC Linux EasyARM-iMX257 as their IoT Gateway device, its OS is not the standard Linux OS, but a customized OS. we need to support them to re-compile our IoT Hub SDK for their client, then Longfor team use the re-compile SDK to finish integrated compile on the device. 

![FEC Linux EasyARM-iMX257](/Images/EasyARMiMX257.png)

Our re-compile IoT Hub SDK in [IoT Hub Example on Embedded Linux] (https://github.com/LitLi/Longfor-Smart-building-Project/tree/master/IoT%20Hub%20Example%20on%20Embedded%20Linux), the folder structure as follow:
  - ROOT
  - |azure c shared utility
  - |azure-umqtt-c
  - |iothub_client
  - |serializer
  - |sample
  -  --|Linux2
  -  --|openssl
  
## 3. Stream Analytics Script

In this project, help ISV to setup and configure IoT
Hub, SA, and Azure SQL Database. More detail content and script files in [Data
Pipeline](https://github.com/LitLi/SmartVendingMachine-Project/tree/master/Data%20Pineline)
