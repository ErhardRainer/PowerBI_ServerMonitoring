USE [Monitoring]
GO

/****** Object:  Table [dbo].[VPN_ConnectionData]    Script Date: 23.01.2023 01:05:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VPN_ConnectionData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Bandwidth] [int] NULL,
	[HostName] [nvarchar](255) NULL,
	[ConnectionDuration] [int] NULL,
	[ConnectionStartTime] [datetime] NULL,
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
	[CurrentDate] [datetime] NULL,
	[Checksum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


