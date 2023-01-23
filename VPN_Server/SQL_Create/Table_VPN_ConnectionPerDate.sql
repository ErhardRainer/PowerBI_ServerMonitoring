USE [Monitoring]
GO

/****** Object:  Table [dbo].[VPN_ConnectionPerDate]    Script Date: 23.01.2023 01:06:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VPN_ConnectionPerDate](
	[DateValue] [datetime] NULL,
	[ID] [int] NOT NULL,
	[Bandwidth] [int] NULL,
	[HostName] [nvarchar](255) NULL,
	[ConnectionDuration] [int] NULL,
	[ConnectionType] [nvarchar](255) NULL,
	[TotalBytesIn] [bigint] NULL,
	[TotalBytesOut] [bigint] NULL,
	[TransitionTechnology] [nvarchar](255) NULL,
	[TunnelType] [nvarchar](255) NULL,
	[UserActivityState] [nvarchar](255) NULL,
	[UserName] [nvarchar](255) NULL,
	[ClientExternalAddress] [nvarchar](255) NULL,
	[ClientIPv4Address] [nvarchar](255) NULL,
	[ClientIPv6Address] [nvarchar](255) NULL,
	[Checksum] [int] NULL
) ON [PRIMARY]
GO


