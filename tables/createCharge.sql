USE [hotel]
GO

/****** Object:  Table [dbo].[Charge]    Script Date: 08/06/2021 16:13:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Charge](
	[NFC_ID] [int] NOT NULL,
	[Service_ID] [int] NOT NULL,
	[Charge_datetime] [datetime] NOT NULL,
	[Charge_amount] [int] NOT NULL,
	[Charge_description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Charge] PRIMARY KEY CLUSTERED 
(
	[NFC_ID] ASC,
	[Service_ID] ASC,
	[Charge_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Charge]  WITH CHECK ADD  CONSTRAINT [FK_Charge_Customer] FOREIGN KEY([NFC_ID])
REFERENCES [dbo].[Customer] ([NFC_ID])
GO

ALTER TABLE [dbo].[Charge] CHECK CONSTRAINT [FK_Charge_Customer]
GO

ALTER TABLE [dbo].[Charge]  WITH CHECK ADD  CONSTRAINT [FK_Charge_Service] FOREIGN KEY([Service_ID])
REFERENCES [dbo].[Service] ([Service_ID])
GO

ALTER TABLE [dbo].[Charge] CHECK CONSTRAINT [FK_Charge_Service]
GO

ALTER TABLE [dbo].[Charge]  WITH CHECK ADD  CONSTRAINT [CK_Charge] CHECK  (([Charge_amount]>=(0)))
GO

ALTER TABLE [dbo].[Charge] CHECK CONSTRAINT [CK_Charge]
GO

