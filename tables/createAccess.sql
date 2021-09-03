USE [hotel]
GO

/****** Object:  Table [dbo].[Access]    Script Date: 08/06/2021 16:13:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Access](
	[NFC_ID] [int] NOT NULL,
	[Area_ID] [int] NOT NULL,
	[Access_datetime] [datetime] NOT NULL,
	[End_datetime] [datetime] NULL,
 CONSTRAINT [PK_Access] PRIMARY KEY CLUSTERED 
(
	[NFC_ID] ASC,
	[Area_ID] ASC,
	[Access_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Access]  WITH CHECK ADD  CONSTRAINT [FK_Access_Area] FOREIGN KEY([Area_ID])
REFERENCES [dbo].[Area] ([Area_ID])
GO

ALTER TABLE [dbo].[Access] CHECK CONSTRAINT [FK_Access_Area]
GO

ALTER TABLE [dbo].[Access]  WITH CHECK ADD  CONSTRAINT [FK_Access_Customer] FOREIGN KEY([NFC_ID])
REFERENCES [dbo].[Customer] ([NFC_ID])
GO

ALTER TABLE [dbo].[Access] CHECK CONSTRAINT [FK_Access_Customer]
GO

ALTER TABLE [dbo].[Access]  WITH CHECK ADD  CONSTRAINT [CK_end_after_access] CHECK  (([Access_datetime]<[End_datetime]))
GO

ALTER TABLE [dbo].[Access] CHECK CONSTRAINT [CK_end_after_access]
GO

