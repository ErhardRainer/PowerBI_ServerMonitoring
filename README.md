# PowerBI_ServerMonitoring
Sktipte und Dashboard für das Monitoring

== VPN_Server ==

(1) Create Database "Monitoring" on your SQL Server

(2) Install the following Scripts

* SP_VPN_ConnectionPerDate.sql - Script to Create the Stored Procedure dbo.SP_VPN_ConnectionPerDate
* SP_VPN_InsertVPNConnectionData.sql - Script to Create the Stored Procedure dbo.SP_VPN_InsertVPNConnectionData
* Table_VPN_ConnectionData.sql - Script to Create Table dbo.VPN_ConnectionData
* Table_VPN_ConnectionPerDate.sql - Script to Create Table VPN_ConnectionPerDate

(3) Add Powershell-Script "VPN_Moniotring.ps1" on your VPN-Server and Shedule it every 5 Minutes

How to schedule a Powershell-Script every 5min:
* https://www.sharepointdiary.com/2013/03/create-scheduled-task-for-powershell-script.html
