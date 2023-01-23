USE [Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_VPN_ConnectionPerDate]    Script Date: 23.01.2023 12:28:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- 2023-01-23 - ER - initiale Version
-- 2023-01-23 - ER - Delta-Berechnung
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
on d.DateValue between DateAdd(mi,5,v.[ConnectionStartTime]) and DateAdd(mi,5,v.[CurrentDate])
Where [DateValue] not in  (Select [DateValue] from [dbo].[VPN_ConnectionPerDate] where [ID] <> 0)
order by DAteValue desc
	OPTION (MAXRECURSION 0)

-- Delta Berechnung
;With CTE as (
SELECT [DateValue], DATEADD(MINUTE, -5, [DateValue]) as [CompareDate]
      ,[ID]
      ,[TotalBytesIn]
      ,[TotalBytesOut]
  FROM [Monitoring].[dbo].[VPN_ConnectionPerDate]
  where ID <> 0),
  UpdateQuery as (


  Select cte1.[DateValue], cte1.[CompareDate], cte1.ID, cte1.[TotalBytesIn] - cte2.[TotalBytesIn] as [TotalBytesIn_Difference]  
  ,  cte1.[TotalBytesOut] - cte2.[TotalBytesOut] as [TotalBytesOut_Difference] 
  from CTE as cte1  left outer join CTE as cte2
  on cte1.CompareDate = cte2.[DateValue])

  Update t
  Set t.[TotalBytesIn_Difference] = s.[TotalBytesIn_Difference],
  t.[TotalBytesOut_Difference] = s.[TotalBytesOut_Difference]
  from UpdateQuery as s
  inner join [dbo].[VPN_ConnectionPerDate] as t
  on s.[DateValue] = t.[DateValue]

  Update [dbo].[VPN_ConnectionPerDate]
  Set [TotalBytesIn_Difference] = 0,
  [TotalBytesOut_Difference] = 0
  Where [TotalBytesIn_Difference] is null and [TotalBytesOut_Difference] is null

End 
GO


