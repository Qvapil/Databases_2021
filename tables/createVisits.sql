USE [hotel]
GO

/****** Object:  Table [dbo].[Visits]    Script Date: 08/06/2021 16:15:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Visits](
	[Area_ID] [int] NOT NULL,
	[NFC_ID] [int] NOT NULL,
	[Visit_datetime] [datetime] NOT NULL,
	[Exit_datetime] [datetime] NULL,
 CONSTRAINT [PK_Visits_1] PRIMARY KEY CLUSTERED 
(
	[Area_ID] ASC,
	[NFC_ID] ASC,
	[Visit_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [FK_Visits_Area] FOREIGN KEY([Area_ID])
REFERENCES [dbo].[Area] ([Area_ID])
GO

ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [FK_Visits_Area]
GO

ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [FK_Visits_Customer] FOREIGN KEY([NFC_ID])
REFERENCES [dbo].[Customer] ([NFC_ID])
GO

ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [FK_Visits_Customer]
GO

ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [CK_exit_after_visiting] CHECK  (([Visit_datetime]<=[Exit_datetime]))
GO

ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [CK_exit_after_visiting]
GO

