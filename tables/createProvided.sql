USE [hotel]
GO

/****** Object:  Table [dbo].[Provided_at]    Script Date: 08/06/2021 16:15:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Provided_at](
	[Area_ID] [int] NOT NULL,
	[Service_ID] [int] NOT NULL,
 CONSTRAINT [PK_Provided_at] PRIMARY KEY CLUSTERED 
(
	[Area_ID] ASC,
	[Service_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Provided_at]  WITH CHECK ADD  CONSTRAINT [FK_Provided_at_Area] FOREIGN KEY([Area_ID])
REFERENCES [dbo].[Area] ([Area_ID])
GO

ALTER TABLE [dbo].[Provided_at] CHECK CONSTRAINT [FK_Provided_at_Area]
GO

ALTER TABLE [dbo].[Provided_at]  WITH CHECK ADD  CONSTRAINT [FK_Provided_at_Service] FOREIGN KEY([Service_ID])
REFERENCES [dbo].[Service] ([Service_ID])
GO

ALTER TABLE [dbo].[Provided_at] CHECK CONSTRAINT [FK_Provided_at_Service]
GO

