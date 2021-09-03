USE [hotel]
GO

/****** Object:  Table [dbo].[Area]    Script Date: 08/06/2021 16:13:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Area](
	[Area_ID] [int] IDENTITY(1,1) NOT NULL,
	[Number_of_beds] [int] NOT NULL,
	[Area_name] [varchar](50) NOT NULL,
	[Area_location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[Area_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Area_location] UNIQUE NONCLUSTERED 
(
	[Area_location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Area_name] UNIQUE NONCLUSTERED 
(
	[Area_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [CK_Area_name] CHECK  (([Area_name] like 'room [1-5][0-7][0-9]' OR [Area_name] like 'room [1-5]80' OR [Area_name]='reception' OR [Area_name]='hair salon' OR [Area_name] like 'restaurant [1-4]' OR [Area_name] like 'bar [1-6]' OR [Area_name] like 'gym [1-4]' OR [Area_name] like 'sauna [1-9]' OR [Area_name]='sauna 10' OR [Area_name] like 'conference room [1-9]' OR [Area_name]='conference room 10' OR [Area_name] like 'escalator [1-5]' OR [Area_name] like 'N corridor [1-5]' OR [Area_name] like 'S corridor [1-5]' OR [Area_name] like 'E corridor [1-5]' OR [Area_name] like 'W corridor [1-5]'))
GO

ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [CK_Area_name]
GO

ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [CK_numberofbeds] CHECK  (([Number_of_beds]>=(1) AND [Number_of_beds]<=(4) AND [Area_name] like 'room%' OR [Number_of_beds]=(0)))
GO

ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [CK_numberofbeds]
GO

