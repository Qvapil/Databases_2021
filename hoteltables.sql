/*USE [master]
GO
/****** Object:  Database [hotel]    Script Date: 10/06/2021 19:40:09 ******/
CREATE DATABASE [hotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'hotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\hotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'hotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\hotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [hotel] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [hotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [hotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [hotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [hotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [hotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [hotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [hotel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [hotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [hotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [hotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [hotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [hotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [hotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [hotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [hotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [hotel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [hotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [hotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [hotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [hotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [hotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [hotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [hotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [hotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [hotel] SET  MULTI_USER 
GO
ALTER DATABASE [hotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [hotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [hotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [hotel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [hotel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [hotel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [hotel] SET QUERY_STORE = OFF
GO*/

USE [hotel]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  View [dbo].[Customer Info]    Script Date: 10/06/2021 19:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Customer Info] as
select Surname, Name, Birthdate, Phone, Email
from Customer
GO
/****** Object:  Table [dbo].[Charge]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  View [dbo].[Service Info]    Script Date: 10/06/2021 19:40:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[Service Info] as
select sum(Charge_amount) as Revenue, Charge_description, count(Charge_description) as Count
from Charge
where Service_Id>1
group by Charge_description
GO
/****** Object:  Table [dbo].[Access]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Table [dbo].[Area]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Table [dbo].[Provided_at]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Table [dbo].[Service]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Table [dbo].[Sign_up]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Table [dbo].[Visits]    Script Date: 10/06/2021 19:40:09 ******/
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
/****** Object:  Index [IX_birthdate]    Script Date: 10/06/2021 19:40:09 ******/
CREATE NONCLUSTERED INDEX [IX_birthdate] ON [dbo].[Customer]
(
	[Birthdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_exit]    Script Date: 10/06/2021 19:40:09 ******/
CREATE NONCLUSTERED INDEX [IX_exit] ON [dbo].[Visits]
(
	[Exit_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Visits]    Script Date: 10/06/2021 19:40:09 ******/
CREATE NONCLUSTERED INDEX [IX_Visits] ON [dbo].[Visits]
(
	[Visit_datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[Access]  WITH CHECK ADD  CONSTRAINT [CK_end_after_access] CHECK  (([Access_datetime]<[End_datetime]))
GO
ALTER TABLE [dbo].[Access] CHECK CONSTRAINT [CK_end_after_access]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [CK_Area_name] CHECK  (([Area_name] like 'room [1-5][0-7][0-9]' OR [Area_name] like 'room [1-5]80' OR [Area_name]='reception' OR [Area_name]='hair salon' OR [Area_name] like 'restaurant [1-4]' OR [Area_name] like 'bar [1-6]' OR [Area_name] like 'gym [1-4]' OR [Area_name] like 'sauna [1-9]' OR [Area_name]='sauna 10' OR [Area_name] like 'conference room [1-9]' OR [Area_name]='conference room 10' OR [Area_name] like 'escalator [1-5]' OR [Area_name] like 'N corridor [1-5]' OR [Area_name] like 'S corridor [1-5]' OR [Area_name] like 'E corridor [1-5]' OR [Area_name] like 'W corridor [1-5]'))
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [CK_Area_name]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [CK_numberofbeds] CHECK  (([Number_of_beds]>=(1) AND [Number_of_beds]<=(4) AND [Area_name] like 'room%' OR [Number_of_beds]=(0)))
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [CK_numberofbeds]
GO
ALTER TABLE [dbo].[Charge]  WITH CHECK ADD  CONSTRAINT [CK_Charge] CHECK  (([Charge_amount]>=(0)))
GO
ALTER TABLE [dbo].[Charge] CHECK CONSTRAINT [CK_Charge]
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
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [CK_Sign_up_type] CHECK  (([Sign_up_type]='sign up' AND ([Service_description]='stay at room' OR [Service_description]='gym use' OR [Service_description]='sauna use' OR [Service_description]='conference room use') OR [Sign_up_type]='no sign up' AND ([Service_description]='drink at bar' OR [Service_description]='food/drink at restaurant' OR [Service_description]='haircut')))
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [CK_Sign_up_type]
GO
ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [CK_exit_after_visiting] CHECK  (([Visit_datetime]<=[Exit_datetime]))
GO
ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [CK_exit_after_visiting]
GO
USE [master]
GO
ALTER DATABASE [hotel] SET  READ_WRITE 
GO
