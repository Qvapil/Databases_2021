USE [hotel]
GO

/****** Object:  Table [dbo].[Service]    Script Date: 08/06/2021 16:15:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Service](
	[Service_ID] [int] IDENTITY(1,1) NOT NULL,
	[Service_description] [varchar](50) NOT NULL,
	[Sign_up_type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[Service_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [CK_Sign_up_type] CHECK  (([Sign_up_type]='sign up' AND ([Service_description]='stay at room' OR [Service_description]='gym use' OR [Service_description]='sauna use' OR [Service_description]='conference room use') OR [Sign_up_type]='no sign up' AND ([Service_description]='drink at bar' OR [Service_description]='food/drink at restaurant' OR [Service_description]='haircut')))
GO

ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [CK_Sign_up_type]
GO

