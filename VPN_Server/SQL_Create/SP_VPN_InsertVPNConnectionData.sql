USE [Monitoring]
GO

/****** Object:  StoredProcedure [dbo].[sp_VPN_InsertVPNConnectionData]    Script Date: 23.01.2023 01:06:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_VPN_InsertVPNConnectionData]
(
    @Bandwidth INT,
    @HostName NVARCHAR(255),
    @ConnectionDuration INT,
    @ConnectionStartTime  NVARCHAR(255),
    @ConnectionType NVARCHAR(255),
    @TotalBytesIn BIGINT,
    @TotalBytesOut BIGINT,
    @TransitionTechnology NVARCHAR(255),
    @TunnelType NVARCHAR(255),
    @UserActivityState NVARCHAR(255),
    @UserName NVARCHAR(255),
    @ClientExternalAddress NVARCHAR(255),
    @ClientIPv4Address NVARCHAR(255),
    @ClientIPv6Address NVARCHAR(255)
)
AS
BEGIN
    DECLARE @checksum INT
	Declare @StartTime as datetime = CONVERT(DATETIME, @ConnectionStartTime, 101)
    SET @checksum = HASHBYTES('SHA2_512', CONCAT(@ConnectionStartTime, @ConnectionType, @TunnelType, @ClientExternalAddress, @UserName))
    IF EXISTS(SELECT * FROM VPN_ConnectionData WHERE Checksum = @checksum)
    BEGIN
        UPDATE VPN_ConnectionData SET Bandwidth = @Bandwidth, HostName = @HostName, ConnectionDuration = @ConnectionDuration, 
		TotalBytesIn = @TotalBytesIn, TotalBytesOut = @TotalBytesOut, TransitionTechnology = @TransitionTechnology, UserActivityState = @UserActivityState, 
		ClientIPv4Address = @ClientIPv4Address, ClientIPv6Address = @ClientIPv6Address,  [CurrentDate] = getdate()
		WHERE Checksum = @checksum
    END
    ELSE
    BEGIN
        INSERT INTO VPN_ConnectionData (Bandwidth, HostName, ConnectionDuration, ConnectionStartTime, ConnectionType, 
		TotalBytesIn, TotalBytesOut, TransitionTechnology, TunnelType, UserActivityState, UserName, ClientExternalAddress, 
		ClientIPv4Address, ClientIPv6Address, Checksum, [CurrentDate])
        VALUES (@Bandwidth, @HostName, @ConnectionDuration, @StartTime, @ConnectionType, 
		@TotalBytesIn, @TotalBytesOut, @TransitionTechnology, @TunnelType, @UserActivityState, @UserName, @ClientExternalAddress, 
		@ClientIPv4Address, @ClientIPv6Address, @checksum,  getdate())
    END
END
GO


