USE [hotel]
GO

/****** Object:  Table [dbo].[Sign_up]    Script Date: 08/06/2021 16:15:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sign_up](
	[NFC_ID] [int] NOT NULL,
	[Service_ID] [int] NOT NULL,
	[Sign_up_datetime] [datetime] NOT NULL,
 CONSTRAINT [PK_Sign_up_1] PRIMARY KEY CLUSTERED 
(
	[NFC_ID] ASC,
	[Service_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sign_up]  WITH CHECK ADD  CONSTRAINT [FK_Sign_up_Customer] FOREIGN KEY([NFC_ID])
REFERENCES [dbo].[Customer] ([NFC_ID])
GO

ALTER TABLE [dbo].[Sign_up] CHECK CONSTRAINT [FK_Sign_up_Customer]
GO

ALTER TABLE [dbo].[Sign_up]  WITH CHECK ADD  CONSTRAINT [FK_Sign_up_Service] FOREIGN KEY([Service_ID])
REFERENCES [dbo].[Service] ([Service_ID])
GO

ALTER TABLE [dbo].[Sign_up] CHECK CONSTRAINT [FK_Sign_up_Service]
GO

