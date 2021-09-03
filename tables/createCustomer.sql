USE [hotel]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 09/06/2021 16:16:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[NFC_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Birthdate] [date] NOT NULL,
	[ID_number] [varchar](50) NOT NULL,
	[ID_type] [varchar](50) NOT NULL,
	[Issuing_authority] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[NFC_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_idnumber] UNIQUE NONCLUSTERED 
(
	[ID_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_phone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_email] CHECK  (([Email] like '%@%'))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_email]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_idtype] CHECK  (([ID_type]='passport' OR [ID_type]='identity card' OR [ID_type]='academic identity' OR [ID_type]='driving license'))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_idtype]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_name] CHECK  ((NOT [Name] like '%[0-9]%'))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_name]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_phone] CHECK  (([Phone] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_phone]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CK_surname] CHECK  ((NOT [Surname] like '%[0-9]%'))
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_surname]
GO

