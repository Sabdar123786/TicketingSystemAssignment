USE [master]
GO
/****** Object:  Database [TicketingSystemDB]    Script Date: 02/07/2024 15:07:29 ******/
CREATE DATABASE [TicketingSystemDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TicketingSystemDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TicketingSystemDB.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TicketingSystemDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TicketingSystemDB_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TicketingSystemDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TicketingSystemDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TicketingSystemDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TicketingSystemDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TicketingSystemDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TicketingSystemDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TicketingSystemDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TicketingSystemDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [TicketingSystemDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TicketingSystemDB] SET  MULTI_USER 
GO
ALTER DATABASE [TicketingSystemDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TicketingSystemDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TicketingSystemDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TicketingSystemDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TicketingSystemDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TicketingSystemDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 02/07/2024 15:07:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 02/07/2024 15:07:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [nvarchar](max) NOT NULL,
	[priority] [nvarchar](max) NOT NULL,
	[Module] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[OrderId] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[EmailSent] [bit] NOT NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240629175758_Ticket', N'6.0.31')
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [userId], [priority], [Module], [Title], [OrderId], [Description], [EmailSent]) VALUES (1, N'sabdarkhan2001s@gmail.com', N'High', N'Payment', N'Payment status issue', N'100103003431212', N'My payment ', 0)
INSERT [dbo].[Tickets] ([Id], [userId], [priority], [Module], [Title], [OrderId], [Description], [EmailSent]) VALUES (2, N'sabdarkhan2001s@gmail.com', N'High', N'Payment', N'Payment status issue', N'100103003431212', N'My payment status is not updated in the order. Payment reference#2325232323225', 0)
INSERT [dbo].[Tickets] ([Id], [userId], [priority], [Module], [Title], [OrderId], [Description], [EmailSent]) VALUES (3, N'er.sabdarkhan2001s@gmail.com', N'High', N'Payment', N'Payment status issue', N'100103003431212', N'My payment status is not updated in the order. Payment reference#2325232323225', 0)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
USE [master]
GO
ALTER DATABASE [TicketingSystemDB] SET  READ_WRITE 
GO
