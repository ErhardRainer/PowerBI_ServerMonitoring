USE [Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_VPN_ConnectionPerDate]    Script Date: 23.01.2023 01:06:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_VPN_ConnectionPerDate]
AS
BEGIN 
DECLARE @startDate DATETIME = DATEADD(minute, DATEDIFF(minute, 0, DATEADD(month, -1, GETDATE())) / 5 * 5, 0);
DECLARE @endDate DATETIME = GETDATE();

Delete [dbo].[VPN_ConnectionPerDate] where [ID] = 0
;
WITH DateList AS 
(
    SELECT @startDate AS DateValue
    UNION ALL
    SELECT DATEADD(minute, 5, 
        DATEADD(minute, DATEDIFF(minute, 0, DateValue) / 5 * 5, 0))
    FROM DateList
    WHERE DateValue + 5 < @endDate + 5
)
insert into [dbo].[VPN_ConnectionPerDate]([DateValue]
      ,[ID]
      ,[Bandwidth]
      ,[HostName]
      ,[ConnectionDuration]
      ,[ConnectionType]
      ,[TotalBytesIn]
      ,[TotalBytesOut]
      ,[TransitionTechnology]
      ,[TunnelType]
      ,[UserActivityState]
      ,[UserName]
      ,[ClientExternalAddress]
      ,[ClientIPv4Address]
      ,[ClientIPv6Address]
      ,[Checksum])
SELECT DateValue,isnull([ID],0) as [ID]
      ,[Bandwidth]
      ,[HostName]
      ,[ConnectionDuration]
      ,[ConnectionType]
      ,[TotalBytesIn]
      ,[TotalBytesOut]
      ,[TransitionTechnology]
      ,[TunnelType]
      ,[UserActivityState]
      ,[UserName]
      ,[ClientExternalAddress]
      ,[ClientIPv4Address]
      ,[ClientIPv6Address]
      ,[Checksum]	
FROM DateList as d
left outer join [dbo].[VPN_ConnectionData] as v
on d.DateValue between v.[ConnectionStartTime] and v.[CurrentDate]
Where [DateValue] not in  (Select [DateValue] from [dbo].[VPN_ConnectionPerDate] where [ID] <> 0)
order by DAteValue desc
	OPTION (MAXRECURSION 0)


End 
GO


