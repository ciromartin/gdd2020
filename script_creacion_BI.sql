USE [GD2C2020]
GO

/******************ELIMINAR DIM-HECHOS ANTES DE CREARLAS******************/

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_TIEMPO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_TIEMPO]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_CLIENTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_CLIENTE]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_SUCURSAL', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_SUCURSAL]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_TIPO_TRANSMISION', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_TIPO_TRANSMISION]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_TIPO_CAJA', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_TIPO_CAJA]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_TIPO_MOTOR', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_TIPO_MOTOR]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_TIPO_AUTO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_TIPO_AUTO]

GO 

IF OBJECT_ID('WHITE_WALKERS.BI_DIM_FABRICANTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[BI_DIM_FABRICANTE]

GO 


/**************************************************/

/********************CREAR TABLAS TEMPORALES (SOLO PARA LA MIGRACION BI)********************/

/*************************************************************/

/********************CREAR TABLAS FINALES********************/

CREATE TABLE [WHITE_WALKERS].[BI_DIM_TIEMPO] (
  [FECHA_ID] [decimal](18, 0) PRIMARY KEY IDENTITY(1,1),
  [MES_CODIGO]  [decimal](18, 0) NULL,
  [MES_DESC] [nvarchar](255) NULL,
  [ANIO] [decimal](18, 0) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_CLIENTE] (
  [CLIENTE_ID] [decimal](18, 0) PRIMARY KEY IDENTITY(1,1),
  [CATEGORIA]  [nvarchar](255) NULL,
  [CANTIDAD] [decimal](18, 0) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_SUCURSAL] (
  [ID_SUCURSAL]  [decimal](18, 0) PRIMARY KEY,
  [SUCURSAL_DIRECCION] [nvarchar](255) NULL,
  [SUCURSAL_CIUDAD] [nvarchar](255) NULL
)


GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_TIPO_TRANSMISION] (
	[TIPO_TRANSMISION_CODIGO] [decimal](18, 0)  PRIMARY KEY,
	[TIPO_TRANSMISION_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_TIPO_CAJA] (
	[TIPO_CAJA_CODIGO] [decimal](18, 0) PRIMARY KEY,
	[TIPO_CAJA_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_TIPO_MOTOR] (
	[TIPO_MOTOR_CODIGO] [decimal](18, 0) PRIMARY KEY
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_TIPO_AUTO] (
	[TIPO_AUTO_CODIGO] [decimal](18, 0)  PRIMARY KEY,
	[TIPO_AUTO_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[BI_DIM_FABRICANTE] (
	[ID_FABRICANTE] [decimal](18, 0)  PRIMARY KEY IDENTITY(1,1),
	[FABRICANTE_NOMBRE] [nvarchar](255) NULL,
)

GO

/*************************************************************/

/********************INSERTAR DATOS TABLAS********************/

DECLARE @STAR_DATE AS [datetime2]
DECLARE @END_DATE AS [datetime2]
DECLARE @CURRENT_DATE AS [datetime2]

SELECT TOP 1 @STAR_DATE = COMPRA_FECHA FROM WHITE_WALKERS.COMPRA ORDER BY COMPRA_FECHA ASC
SET @END_DATE = GETDATE()
SET @CURRENT_DATE = @STAR_DATE

WHILE (@CURRENT_DATE < @END_DATE)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [WHITE_WALKERS].[BI_DIM_TIEMPO] WHERE [MES_CODIGO] = MONTH(@CURRENT_DATE) AND [ANIO] = YEAR(@CURRENT_DATE))
    BEGIN
        INSERT INTO [WHITE_WALKERS].[BI_DIM_TIEMPO]
		([MES_CODIGO]
		,[MES_DESC]
		,[ANIO])
        SELECT 
		 MONTH(@CURRENT_DATE)
		,UPPER(FORMAT(@CURRENT_DATE, 'MMMM', 'es-es')) AS 'es-es'
		,YEAR(@CURRENT_DATE)
    END

    SET @CURRENT_DATE = DATEADD(MONTH, 1, @CURRENT_DATE); 
END

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_CLIENTE]
           ([CATEGORIA]
           ,[CANTIDAD])
SELECT     
            '18 A 30'
           ,COUNT(1)
FROM [WHITE_WALKERS].[CLIENTE] 
WHERE FLOOR(DATEDIFF(DAY, CLIENTE_FECHA_NAC, GETDATE()) / 365.25) BETWEEN 18 AND 30
UNION
SELECT     
            '31 A 50'
           ,COUNT(1)
FROM [WHITE_WALKERS].[CLIENTE] 
WHERE FLOOR(DATEDIFF(DAY, CLIENTE_FECHA_NAC, GETDATE()) / 365.25) BETWEEN 31 AND 50
UNION
SELECT     
            '> 50'
           ,COUNT(1)
FROM [WHITE_WALKERS].[CLIENTE] 
WHERE FLOOR(DATEDIFF(DAY, CLIENTE_FECHA_NAC, GETDATE()) / 365.25) > 50

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_SUCURSAL]
           ([ID_SUCURSAL]
		   ,[SUCURSAL_DIRECCION]
           ,[SUCURSAL_CIUDAD])
SELECT     
            [ID_SUCURSAL]
		   ,[SUCURSAL_DIRECCION]
           ,[SUCURSAL_CIUDAD]
FROM [WHITE_WALKERS].[SUCURSAL] 

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_TIPO_TRANSMISION]
           ([TIPO_TRANSMISION_CODIGO]
           ,[TIPO_TRANSMISION_DESC])
SELECT DISTINCT  
            TIPO_TRANSMISION_CODIGO
           ,TIPO_TRANSMISION_DESC
FROM [WHITE_WALKERS].[TIPO_TRANSMISION] 

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_TIPO_CAJA]
           ([TIPO_CAJA_CODIGO]
           ,[TIPO_CAJA_DESC])
SELECT DISTINCT 
            TIPO_CAJA_CODIGO
           ,TIPO_CAJA_DESC
FROM [WHITE_WALKERS].[TIPO_CAJA]

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_TIPO_MOTOR]
           ([TIPO_MOTOR_CODIGO])
SELECT DISTINCT 
           TIPO_MOTOR_CODIGO
FROM [WHITE_WALKERS].[TIPO_MOTOR]

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_TIPO_AUTO]
           ([TIPO_AUTO_CODIGO]
           ,[TIPO_AUTO_DESC])
SELECT DISTINCT 
            TIPO_AUTO_CODIGO
           ,TIPO_AUTO_DESC
FROM [WHITE_WALKERS].[TIPO_AUTO]

GO

INSERT INTO [WHITE_WALKERS].[BI_DIM_FABRICANTE]
           ([FABRICANTE_NOMBRE])
SELECT DISTINCT 
           FABRICANTE_NOMBRE
FROM [WHITE_WALKERS].[FABRICANTE] 
ORDER BY FABRICANTE_NOMBRE ASC

GO

/*************************************************************/