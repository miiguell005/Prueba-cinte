USE [master]
GO
/****** Object:  Database [Cinte]    Script Date: 12/06/2020 3:01:49 ******/
CREATE DATABASE [Cinte]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cinte', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2019\MSSQL\DATA\Cinte.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cinte_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2019\MSSQL\DATA\Cinte_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Cinte] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cinte].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cinte] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cinte] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cinte] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cinte] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cinte] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cinte] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cinte] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cinte] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cinte] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cinte] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cinte] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cinte] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cinte] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cinte] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cinte] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Cinte] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cinte] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cinte] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cinte] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cinte] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cinte] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cinte] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cinte] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cinte] SET  MULTI_USER 
GO
ALTER DATABASE [Cinte] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cinte] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cinte] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cinte] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Cinte] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Cinte]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 12/06/2020 3:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[IdLog] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[Usuario] [varchar](255) NULL,
	[Fecha] [datetime2](7) NOT NULL,
	[Evento] [varchar](255) NOT NULL,
	[Excepcion] [varchar](max) NULL,
	[Detalle] [varchar](max) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[IdLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoIdentificacion]    Script Date: 12/06/2020 3:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoIdentificacion](
	[IdTipoIdentificacion] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](7) NOT NULL,
 CONSTRAINT [PK_TipoIdentificacion] PRIMARY KEY CLUSTERED 
(
	[IdTipoIdentificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 12/06/2020 3:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoIdentificacion] [int] NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[Apellido] [varchar](255) NOT NULL,
	[NumeroIdentificacion] [varchar](50) NOT NULL,
	[Contrasenia] [varchar](255) NOT NULL,
	[Correo] [varchar](255) NOT NULL,
	[IdCreado] [int] NULL,
	[Creado] [datetime2](7) NOT NULL,
	[IdModificado] [int] NULL,
	[Modificado] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (1, NULL, N'', CAST(N'2020-06-12 01:20:00.0667070' AS DateTime2), N'Login', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Modulo\LogModulo.cs:line 35
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 68', N'Número de identificación: 123123')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (2, NULL, N'', CAST(N'2020-06-12 01:21:45.4262236' AS DateTime2), N'Login', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Modulo\LogModulo.cs:line 35
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 68', N'Número de identificación: 123123')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (3, NULL, N'', CAST(N'2020-06-12 01:21:52.6197462' AS DateTime2), N'Login', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Modulo\LogModulo.cs:line 35
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 68', N'Número de identificación: 123123')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (4, NULL, N'', CAST(N'2020-06-12 01:24:15.0607967' AS DateTime2), N'Login', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar)
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion)', N'Número de identificación: 123123')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (5, NULL, N'', CAST(N'2020-06-12 01:24:43.7071493' AS DateTime2), N'Login', N'System.Reflection.TargetException: Non-static method requires a target.
   at System.Reflection.RuntimeMethodInfo.CheckConsistency(Object target)
   at System.Reflection.RuntimeMethodInfo.InvokeArgumentsCheck(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
   at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)
   at System.Reflection.RuntimePropertyInfo.GetValue(Object obj, Object[] index)
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar)
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion)', N'Número de identificación: 123123')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (6, 1, N'qwe qwe ', CAST(N'2020-06-12 01:24:59.4871124' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (7, 1, N'qwee qwe ', CAST(N'2020-06-12 01:25:14.5698148' AS DateTime2), N'Editar Usuario', N'System.ArgumentOutOfRangeException: startIndex must be less than length of string.
Parameter name: startIndex
   at System.String.Remove(Int32 startIndex)
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar)
   at Prueba_Cinte.Controllers.UsuariosController.PutUsuario(Int32 id, Usuario usuarioDto)', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (8, 1, N'qwee qwe ', CAST(N'2020-06-12 01:26:19.8073244' AS DateTime2), N'Editar Usuario', N'System.ArgumentOutOfRangeException: startIndex must be less than length of string.
Parameter name: startIndex
   at System.String.Remove(Int32 startIndex)
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar)
   at Prueba_Cinte.Controllers.UsuariosController.PutUsuario(Int32 id, Usuario usuarioDto)', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (9, 1, N'qwee qwe ', CAST(N'2020-06-12 01:27:17.2075511' AS DateTime2), N'Editar Usuario', N'', N'Contrasenia: 123 ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (10, 1, N'qwee qwe ', CAST(N'2020-06-12 01:27:58.7688573' AS DateTime2), N'Crear Usuario', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Modulo\LogModulo.cs:line 35
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 176', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (11, 1, N'qwee qwe ', CAST(N'2020-06-12 01:28:11.0171035' AS DateTime2), N'Crear Usuario', N'System.Exception: Usuario con número de identificación 1233 ya se encuentra registrado
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 148', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (12, 1, N'qwee qwe ', CAST(N'2020-06-12 01:28:29.7797733' AS DateTime2), N'Crear Usuario', N'System.Exception: Usuario con número de identificación 1233 ya se encuentra registrado
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 148', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (13, 1, N'qwee qwe ', CAST(N'2020-06-12 01:29:02.5546630' AS DateTime2), N'Crear Usuario', N'System.NullReferenceException: Object reference not set to an instance of an object.
   at Prueba_Cinte.Modulo.LogModulo.HayCambios[T](T objOld, T objNew, String propiedadesAValidar) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Modulo\LogModulo.cs:line 35
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 176', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (14, 1, N'qwee qwe ', CAST(N'2020-06-12 01:30:39.9161614' AS DateTime2), N'Crear Usuario', N'', N'Contrasenia:  ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (15, 5, N'test2 test2 ', CAST(N'2020-06-12 01:31:09.3410957' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (16, 5, N'test2 test2 ', CAST(N'2020-06-12 01:31:32.5256748' AS DateTime2), N'Editar Usuario', N'', N'Contrasenia: 123 ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (17, 5, N'test2 test2 ', CAST(N'2020-06-12 01:33:29.6383769' AS DateTime2), N'Editar Usuario', N'', N'Modificado: 12/06/2020 1:33:27 ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (18, 5, N'test2 test2 ', CAST(N'2020-06-12 01:38:29.6109721' AS DateTime2), N'Editar Usuario', N'', N'Nombre: tqwe, Apellido: test2qweqe, Modificado: 12/06/2020 1:35:35 ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (19, 5, N'test2 test2 ', CAST(N'2020-06-12 01:39:05.2370303' AS DateTime2), N'Eliminar Usuario', N'System.Exception: El usuario con id: 0 no se encontró
   at Prueba_Cinte.Controllers.UsuariosController.DeleteUsuario(Int32 idUsuario) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 206', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (20, 5, N'', CAST(N'2020-06-12 01:40:33.2173608' AS DateTime2), N'Eliminar Usuario', N'', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (21, 5, N'', CAST(N'2020-06-12 01:43:15.1335452' AS DateTime2), N'Eliminar Usuario', N'', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (22, 1, N'qwee qwe ', CAST(N'2020-06-12 01:48:14.9444119' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (23, 0, N'', CAST(N'2020-06-12 01:55:27.5172642' AS DateTime2), N'Crear Usuario', N'', N'IdTipoIdentificacion: 0, Nombre: , Apellido: , NumeroIdentificacion: , Correo:  ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (24, 1, N'qwee qwe ', CAST(N'2020-06-12 01:56:22.5907841' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (25, 0, N'', CAST(N'2020-06-12 01:59:23.5413429' AS DateTime2), N'Crear Usuario', N'', N'IdTipoIdentificacion: 1, Nombre: pepito, Apellido: Perez, NumeroIdentificacion: 101010, Correo: qwe111@gmail.com ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (26, 8, N'pepito Perez ', CAST(N'2020-06-12 01:59:31.9081912' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (27, 8, N'pepito Perez ', CAST(N'2020-06-12 02:21:19.5943929' AS DateTime2), N'Crear Usuario', N'System.Exception: El nombre del usuario es obligatorio
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 152', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (28, 8, N'pepito Perez ', CAST(N'2020-06-12 02:23:28.2724187' AS DateTime2), N'Crear Usuario', N'System.Exception: El nombre del usuario es obligatorio
   at Prueba_Cinte.Controllers.UsuariosController.PostUsuario(Usuario usuarioDto) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 152', N'')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (29, 1, N'qwee qwe ', CAST(N'2020-06-12 02:29:31.4601428' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (30, NULL, N'', CAST(N'2020-06-12 02:32:52.0602905' AS DateTime2), N'Login', N'System.Exception: El número de identificacion o la contraseña es incorrecta
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 60', N'Número de identificación: qweqwe')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (31, NULL, N'', CAST(N'2020-06-12 02:36:46.2200157' AS DateTime2), N'Login', N'System.Exception: El número de identificacion o la contraseña es incorrecta
   at Prueba_Cinte.Controllers.UsuariosController.GetLogin(String Contrasenia, String numeroIdentificacion) in C:\Proyectos\Prueba_Cinte\Prueba_Cinte\Controllers\UsuariosController.cs:line 60', N'Número de identificación: qweqwe')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (32, NULL, N'', CAST(N'2020-06-12 02:37:52.8224548' AS DateTime2), N'Crear Usuario', N'', N'IdTipoIdentificacion: 1, Nombre: Miguel, Apellido: Rodriguez, NumeroIdentificacion: 1014258234, Correo: miiguell005@gmail.com ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (33, 9, N'Miguel Rodriguez ', CAST(N'2020-06-12 02:38:22.8104595' AS DateTime2), N'Login', N'', N'Login exitoso')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (34, 9, N'Miguel Rodriguez ', CAST(N'2020-06-12 02:38:50.8677032' AS DateTime2), N'Eliminar Usuario', N'', N'IdUsuario: 7, IdTipoIdentificacion: 1, Nombre: prueba, Apellido: 2, NumeroIdentificacion: 12312311, Correo: qwe@gmail.com, Creado: 12/06/2020 1:55:21, Modificado: 12/06/2020 1:55:21 ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (35, 9, N'Miguel Rodriguez ', CAST(N'2020-06-12 02:39:27.3733674' AS DateTime2), N'Editar Usuario', N'', N'Nombre: test, Apellido: test ')
INSERT [dbo].[Log] ([IdLog], [IdUsuario], [Usuario], [Fecha], [Evento], [Excepcion], [Detalle]) VALUES (36, 9, N'Miguel Rodriguez ', CAST(N'2020-06-12 02:40:22.2477083' AS DateTime2), N'Crear Usuario', N'', N'IdTipoIdentificacion: 2, Nombre: Juan, Apellido: Perez, NumeroIdentificacion: 203012345, Correo: anonimo@gmail.com ')
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[TipoIdentificacion] ON 

INSERT [dbo].[TipoIdentificacion] ([IdTipoIdentificacion], [Tipo]) VALUES (1, N'CC')
INSERT [dbo].[TipoIdentificacion] ([IdTipoIdentificacion], [Tipo]) VALUES (2, N'RC')
INSERT [dbo].[TipoIdentificacion] ([IdTipoIdentificacion], [Tipo]) VALUES (3, N'TI')
INSERT [dbo].[TipoIdentificacion] ([IdTipoIdentificacion], [Tipo]) VALUES (4, N'CE')
INSERT [dbo].[TipoIdentificacion] ([IdTipoIdentificacion], [Tipo]) VALUES (5, N'PA')
SET IDENTITY_INSERT [dbo].[TipoIdentificacion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (1, 2, N'qwee', N'qwe', N'123123', N'123', N'qwe@gmail.com', NULL, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 1, CAST(N'2020-06-12 01:27:06.6272334' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (2, 3, N'Anderson', N'Fuquene', N'1231233', N'123', N'qwee@gmail.com', NULL, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 9, CAST(N'2020-06-12 02:39:27.3606707' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (3, 1, N'tq', N'te', N'1233', N'123', N'qwe22@gmail.com', 1, CAST(N'2020-06-12 01:27:58.6563719' AS DateTime2), 5, CAST(N'2020-06-12 01:38:29.5279056' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (6, 1, N'test2', N'test2', N'1233456', N'123', N'qwe22@gmail.com', 1, CAST(N'2020-06-12 01:30:36.8959228' AS DateTime2), 1, CAST(N'2020-06-12 01:30:36.8973010' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (8, 1, N'pepito', N'Perez', N'101010', N'123', N'qwe111@gmail.com', NULL, CAST(N'2020-06-12 01:59:23.4354022' AS DateTime2), NULL, CAST(N'2020-06-12 01:59:23.4361613' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (9, 1, N'Miguel', N'Rodriguez', N'1014258234', N'123', N'miiguell005@gmail.com', NULL, CAST(N'2020-06-12 02:37:52.7796025' AS DateTime2), NULL, CAST(N'2020-06-12 02:37:52.7797315' AS DateTime2))
INSERT [dbo].[Usuario] ([IdUsuario], [IdTipoIdentificacion], [Nombre], [Apellido], [NumeroIdentificacion], [Contrasenia], [Correo], [IdCreado], [Creado], [IdModificado], [Modificado]) VALUES (10, 2, N'Juan', N'Perez', N'203012345', N'123', N'anonimo@gmail.com', 9, CAST(N'2020-06-12 02:40:22.2348470' AS DateTime2), 9, CAST(N'2020-06-12 02:40:22.2348490' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_TipoIdentificacion] FOREIGN KEY([IdTipoIdentificacion])
REFERENCES [dbo].[TipoIdentificacion] ([IdTipoIdentificacion])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_TipoIdentificacion]
GO
USE [master]
GO
ALTER DATABASE [Cinte] SET  READ_WRITE 
GO
