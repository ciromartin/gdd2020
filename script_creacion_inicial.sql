USE [GD2C2020]
GO

/******************ELIMINAR TABLAS ANTES DE CREARLAS******************/

IF OBJECT_ID('WHITE_WALKERS.COMPRA_AUTO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[COMPRA_AUTO]

IF OBJECT_ID('WHITE_WALKERS.COMPRA_AUTO_PARTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[COMPRA_AUTO_PARTE]

IF OBJECT_ID('WHITE_WALKERS.FACTURA_AUTO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[FACTURA_AUTO]

IF OBJECT_ID('WHITE_WALKERS.FACTURA_AUTO_PARTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[FACTURA_AUTO_PARTE]

IF OBJECT_ID('WHITE_WALKERS.AUTO_PARTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[AUTO_PARTE]

IF OBJECT_ID('WHITE_WALKERS.AUTO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[AUTO]

IF OBJECT_ID('WHITE_WALKERS.MODELO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[MODELO]

IF OBJECT_ID('WHITE_WALKERS.TIPO_TRANSMISION', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[TIPO_TRANSMISION]

IF OBJECT_ID('WHITE_WALKERS.TIPO_CAJA', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[TIPO_CAJA]

IF OBJECT_ID('WHITE_WALKERS.TIPO_MOTOR', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[TIPO_MOTOR]

IF OBJECT_ID('WHITE_WALKERS.TIPO_AUTO', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[TIPO_AUTO]

IF OBJECT_ID('WHITE_WALKERS.FABRICANTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[FABRICANTE]

IF OBJECT_ID('WHITE_WALKERS.COMPRA', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[COMPRA]

IF OBJECT_ID('WHITE_WALKERS.FACTURA', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[FACTURA]

IF OBJECT_ID('WHITE_WALKERS.CLIENTE', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[CLIENTE]

IF OBJECT_ID('WHITE_WALKERS.SUCURSAL', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[SUCURSAL]

IF OBJECT_ID('WHITE_WALKERS.CATEGORIA', 'U') IS NOT NULL 
  DROP TABLE [WHITE_WALKERS].[CATEGORIA]

IF OBJECT_ID('tempdb..#FAC_CLIENTE') IS NOT NULL
    DROP TABLE #FAC_CLIENTE

IF OBJECT_ID('tempdb..#FAC_SUCURSAL') IS NOT NULL
    DROP TABLE #FAC_SUCURSAL

IF OBJECT_ID('tempdb..#COM_CLIENTE') IS NOT NULL
    DROP TABLE #COM_CLIENTE

IF OBJECT_ID('tempdb..#COM_SUCURSAL') IS NOT NULL
    DROP TABLE #COM_SUCURSAL

GO 

/**************************************************/

/*******************CREAR SCHEMA*******************/

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'WHITE_WALKERS')
BEGIN
    DROP SCHEMA [WHITE_WALKERS]	
END

GO

CREATE SCHEMA [WHITE_WALKERS]

GO

/****************************************************/

/********************CREAR TABLAS TEMPORALES (SOLO PARA LA MIGRACION INICIAL)********************/


CREATE TABLE #FAC_CLIENTE (
	[FACTURA_NRO] [decimal](18, 0)  NOT NULL,
	[ID_CLIENTE]  [decimal](18, 0)  NOT NULL,
	PRIMARY KEY ([FACTURA_NRO], [ID_CLIENTE])
)

CREATE TABLE #FAC_SUCURSAL (
	[FACTURA_NRO] [decimal](18, 0)  NOT NULL,
	[ID_SUCURSAL]  [decimal](18, 0)  NOT NULL,
	PRIMARY KEY ([FACTURA_NRO], [ID_SUCURSAL])
)

CREATE TABLE #COM_CLIENTE (
	[COMPRA_NRO] [decimal](18, 0)  NOT NULL,
	[ID_CLIENTE]  [decimal](18, 0)  NOT NULL,
	PRIMARY KEY ([COMPRA_NRO], [ID_CLIENTE])
)

CREATE TABLE #COM_SUCURSAL (
	[COMPRA_NRO] [decimal](18, 0)  NOT NULL,
	[ID_SUCURSAL]  [decimal](18, 0)  NOT NULL,
	PRIMARY KEY ([COMPRA_NRO], [ID_SUCURSAL])
)

/*************************************************************/

/********************CREAR TABLAS FINALES********************/

CREATE TABLE [WHITE_WALKERS].[CLIENTE] (
  [ID_CLIENTE] [decimal](18, 0) PRIMARY KEY IDENTITY(1,1),
  [CLIENTE_APELLIDO] [nvarchar](255) NULL,
  [CLIENTE_NOMBRE] [nvarchar](255) NULL,
  [CLIENTE_DIRECCION] [nvarchar](255) NULL,
  [CLIENTE_DNI] [decimal](18, 0) NULL,
  [CLIENTE_FECHA_NAC] [datetime2](3) NULL,
  [CLIENTE_MAIL] [nvarchar](255) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[SUCURSAL] (
  [ID_SUCURSAL]  [decimal](18, 0) PRIMARY KEY IDENTITY(1,1),
  [SUCURSAL_DIRECCION] [nvarchar](255) NULL,
  [SUCURSAL_MAIL] [nvarchar](255) NULL,
  [SUCURSAL_TELEFONO] [decimal](18, 0) NULL,
  [SUCURSAL_CIUDAD] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[TIPO_TRANSMISION] (
	[TIPO_TRANSMISION_CODIGO] [decimal](18, 0)  PRIMARY KEY,
	[TIPO_TRANSMISION_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[TIPO_CAJA] (
	[TIPO_CAJA_CODIGO] [decimal](18, 0) PRIMARY KEY,
	[TIPO_CAJA_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[TIPO_MOTOR] (
	[TIPO_MOTOR_CODIGO] [decimal](18, 0) PRIMARY KEY
)

GO

CREATE TABLE [WHITE_WALKERS].[TIPO_AUTO] (
	[TIPO_AUTO_CODIGO] [decimal](18, 0)  PRIMARY KEY,
	[TIPO_AUTO_DESC] [nvarchar](255) NULL
)

GO

CREATE TABLE [WHITE_WALKERS].[FABRICANTE] (
	[ID_FABRICANTE] [decimal](18, 0)  PRIMARY KEY IDENTITY(1,1),
	[FABRICANTE_NOMBRE] [nvarchar](255) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[MODELO] (
	[MODELO_CODIGO] [decimal](18, 0) PRIMARY KEY,
	[MODELO_NOMBRE] [nvarchar](255) NULL,
	[MODELO_POTENCIA] [decimal](18, 0) NULL,
	[ID_FABRICANTE] [decimal](18, 0)  FOREIGN KEY REFERENCES [WHITE_WALKERS].[FABRICANTE]([ID_FABRICANTE]),
	[TIPO_TRANSMISION_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[TIPO_TRANSMISION]([TIPO_TRANSMISION_CODIGO]),
	[TIPO_CAJA_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[TIPO_CAJA]([TIPO_CAJA_CODIGO]),
	[TIPO_MOTOR_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[TIPO_MOTOR]([TIPO_MOTOR_CODIGO]),
	[TIPO_AUTO_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[TIPO_AUTO]([TIPO_AUTO_CODIGO]),
)

GO

CREATE TABLE [WHITE_WALKERS].[AUTO] (
	[ID_AUTO] [decimal](18, 0) PRIMARY KEY IDENTITY(1,1),
	[AUTO_NRO_CHASIS] [nvarchar](50) NULL,
	[AUTO_NRO_MOTOR] [nvarchar](50) NULL,
	[AUTO_PATENTE] [nvarchar](50) NULL,
	[AUTO_FECHA_ALTA] [datetime2](3) NULL,
	[AUTO_CANT_KMS] [decimal](18, 0) NULL,
	[MODELO_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[MODELO]([MODELO_CODIGO])

)

GO

CREATE TABLE [WHITE_WALKERS].[AUTO_PARTE] (
	[AUTO_PARTE_CODIGO] [decimal](18, 0) PRIMARY KEY,
	[AUTO_PARTE_DESCRIPCION] [nvarchar](255) NULL,
	[MODELO_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[MODELO]([MODELO_CODIGO]),
	[ID_CATEGORIA]  [decimal](18, 0) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[CATEGORIA] (
	[ID_CATEGORIA] [decimal](18, 0)  PRIMARY KEY IDENTITY(1,1),
	[CATEGORIA_DESC] [nvarchar](255) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[COMPRA] (
	[COMPRA_NRO] [decimal](18, 0)  PRIMARY KEY,
	[ID_SUCURSAL]  [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[SUCURSAL]([ID_SUCURSAL]),
	[ID_CLIENTE] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[CLIENTE]([ID_CLIENTE]),
	[COMPRA_FECHA] [datetime2](3) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[COMPRA_AUTO] (
	[COMPRA_NRO] [decimal](18, 0) NOT NULL,
	[ID_AUTO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[AUTO]([ID_AUTO]),
	[COMPRA_PRECIO] [decimal](18, 2) NULL,
	PRIMARY KEY([COMPRA_NRO],[ID_AUTO])
)

GO

CREATE TABLE [WHITE_WALKERS].[COMPRA_AUTO_PARTE] (
	[COMPRA_NRO] [decimal](18, 0) NOT NULL,
	[AUTO_PARTE_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[AUTO_PARTE]([AUTO_PARTE_CODIGO]),
	[COMPRA_PRECIO] [decimal](18, 2) NULL,
	[COMPRA_CANT] [decimal](18, 0) NULL,
	PRIMARY KEY([COMPRA_NRO],[AUTO_PARTE_CODIGO])
)

GO

CREATE TABLE [WHITE_WALKERS].[FACTURA] (
	[FACTURA_NRO] [decimal](18, 0)  PRIMARY KEY,		
	[ID_SUCURSAL]  [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[SUCURSAL]([ID_SUCURSAL]),
	[ID_CLIENTE] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[CLIENTE]([ID_CLIENTE]),
	[FACTURA_FECHA] [datetime2](3) NULL,
)

GO

CREATE TABLE [WHITE_WALKERS].[FACTURA_AUTO] (
	[FACTURA_NRO] [decimal](18, 0) NOT NULL,
	[ID_AUTO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[AUTO]([ID_AUTO]),
	[PRECIO_FACTURADO] [decimal](18, 2) NULL,
	PRIMARY KEY([FACTURA_NRO],[ID_AUTO])
)

GO

CREATE TABLE [WHITE_WALKERS].[FACTURA_AUTO_PARTE] (
	[FACTURA_NRO] [decimal](18, 0) NOT NULL,
	[AUTO_PARTE_CODIGO] [decimal](18, 0) FOREIGN KEY REFERENCES [WHITE_WALKERS].[AUTO_PARTE]([AUTO_PARTE_CODIGO]),
	[PRECIO_FACTURADO] [decimal](18, 2) NULL,
	[CANT_FACTURADA] [decimal](18, 0) NULL,
	PRIMARY KEY([FACTURA_NRO],[AUTO_PARTE_CODIGO])
)

GO

/*************************************************************/

/********************INSERTAR DATOS TABLAS********************/

INSERT INTO [WHITE_WALKERS].[CLIENTE]
           ([CLIENTE_APELLIDO]
           ,[CLIENTE_NOMBRE]
           ,[CLIENTE_DIRECCION]
           ,[CLIENTE_DNI]
           ,[CLIENTE_FECHA_NAC]
           ,[CLIENTE_MAIL])
SELECT DISTINCT 
            CLIENTE_APELLIDO
           ,CLIENTE_NOMBRE
           ,CLIENTE_DIRECCION
           ,CLIENTE_DNI
           ,CLIENTE_FECHA_NAC
           ,CLIENTE_MAIL  
FROM [gd_esquema].[Maestra] 
WHERE CLIENTE_DNI IS NOT NULL
UNION 
SELECT DISTINCT 
            FAC_CLIENTE_APELLIDO
           ,FAC_CLIENTE_NOMBRE
           ,FAC_CLIENTE_DIRECCION
           ,FAC_CLIENTE_DNI
           ,FAC_CLIENTE_FECHA_NAC
           ,FAC_CLIENTE_MAIL  
FROM [gd_esquema].[Maestra] 
WHERE FAC_CLIENTE_DNI IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[SUCURSAL]
           ([SUCURSAL_DIRECCION]
           ,[SUCURSAL_MAIL]
           ,[SUCURSAL_TELEFONO]
           ,[SUCURSAL_CIUDAD])
SELECT DISTINCT    
            SUCURSAL_DIRECCION
           ,SUCURSAL_MAIL
           ,SUCURSAL_TELEFONO
           ,SUCURSAL_CIUDAD
FROM [gd_esquema].[Maestra] 
WHERE SUCURSAL_DIRECCION IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[TIPO_TRANSMISION]
           ([TIPO_TRANSMISION_CODIGO]
           ,[TIPO_TRANSMISION_DESC])
SELECT DISTINCT  
            TIPO_TRANSMISION_CODIGO
           ,TIPO_TRANSMISION_DESC
FROM [gd_esquema].[Maestra] 
WHERE TIPO_TRANSMISION_CODIGO IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[TIPO_CAJA]
           ([TIPO_CAJA_CODIGO]
           ,[TIPO_CAJA_DESC])
SELECT DISTINCT 
            TIPO_CAJA_CODIGO
           ,TIPO_CAJA_DESC
FROM [gd_esquema].[Maestra] 
WHERE TIPO_CAJA_CODIGO IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[TIPO_MOTOR]
           ([TIPO_MOTOR_CODIGO])
SELECT DISTINCT 
           TIPO_MOTOR_CODIGO
FROM [gd_esquema].[Maestra] 
WHERE TIPO_MOTOR_CODIGO IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[TIPO_AUTO]
           ([TIPO_AUTO_CODIGO]
           ,[TIPO_AUTO_DESC])
SELECT DISTINCT 
            TIPO_AUTO_CODIGO
           ,TIPO_AUTO_DESC
FROM [gd_esquema].[Maestra] 
WHERE TIPO_AUTO_CODIGO IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[FABRICANTE]
           ([FABRICANTE_NOMBRE])
SELECT DISTINCT 
           FABRICANTE_NOMBRE
FROM [gd_esquema].[Maestra] 
WHERE FABRICANTE_NOMBRE IS NOT NULL
ORDER BY FABRICANTE_NOMBRE ASC

GO

INSERT INTO [WHITE_WALKERS].[MODELO]
           ([MODELO_CODIGO]
           ,[MODELO_NOMBRE]
           ,[MODELO_POTENCIA]
		   ,[ID_FABRICANTE]		   
	       ,[TIPO_TRANSMISION_CODIGO]
	       ,[TIPO_CAJA_CODIGO]
	       ,[TIPO_MOTOR_CODIGO]
	       ,[TIPO_AUTO_CODIGO])
SELECT DISTINCT 
            M.MODELO_CODIGO
           ,M.MODELO_NOMBRE
           ,M.MODELO_POTENCIA
		   ,F.ID_FABRICANTE		   
		   ,M.TIPO_TRANSMISION_CODIGO
		   ,M.TIPO_CAJA_CODIGO
		   ,M.TIPO_MOTOR_CODIGO
		   ,M.TIPO_AUTO_CODIGO
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[FABRICANTE] F
	ON M.[FABRICANTE_NOMBRE] = F.[FABRICANTE_NOMBRE]
WHERE MODELO_CODIGO IS NOT NULL
	AND M.TIPO_TRANSMISION_CODIGO IS NOT NULL
	AND M.TIPO_CAJA_CODIGO IS NOT NULL
	AND M.TIPO_MOTOR_CODIGO IS NOT NULL
	AND M.TIPO_AUTO_CODIGO IS NOT NULL
ORDER BY F.ID_FABRICANTE ASC, MODELO_NOMBRE ASC

GO

INSERT INTO [WHITE_WALKERS].[AUTO]
           ([AUTO_NRO_CHASIS]
           ,[AUTO_NRO_MOTOR]
           ,[AUTO_PATENTE]
           ,[AUTO_FECHA_ALTA]
           ,[AUTO_CANT_KMS]
		   ,[MODELO_CODIGO])
SELECT DISTINCT 
            AUTO_NRO_CHASIS
           ,AUTO_NRO_MOTOR
           ,AUTO_PATENTE
           ,AUTO_FECHA_ALTA
           ,AUTO_CANT_KMS
		   ,MODELO_CODIGO
FROM [gd_esquema].[Maestra]
WHERE AUTO_PATENTE IS NOT NULL

GO

INSERT INTO [WHITE_WALKERS].[CATEGORIA]
           ([CATEGORIA_DESC])
VALUES
            ('Faros')
		   ,('Vidrios')
		   ,('Chapa')
		   ,('Paragolpes')
		   ,('Cerrajeria')
		   ,('Accesorios de linea')
		   ,('Iluminacion')
		   ,('Accesorios')
		   ,('Molduras')
		   ,('Radiadores')
		   ,('Tapiceria')
		   ,('Tanques')
		   ,('Aros de Faro')
		   ,('Encendido')
		   ,('Mecanica')
		   ,('Instrumental')
		   ,('Pinturas')
		   ,('Instrumental')
		   ,('Acrilicos')
		   ,('Adhesivos')
		   ,('Antenas')
		   ,('Volantes')
		   ,('Fundas')
		   ,('Alfombras')
		   ,('Equipamiento')
		   ,('Farol')
		   ,('Espejos')

GO

INSERT INTO [WHITE_WALKERS].[AUTO_PARTE]
           ([AUTO_PARTE_CODIGO]
           ,[AUTO_PARTE_DESCRIPCION]
		   ,[MODELO_CODIGO]
		   ,[ID_CATEGORIA])
SELECT DISTINCT 
            AUTO_PARTE_CODIGO
           ,AUTO_PARTE_DESCRIPCION
		   ,MODELO_CODIGO
		   ,CASE WHEN (SELECT TOP 1 ID_CATEGORIA FROM [WHITE_WALKERS].[CATEGORIA] WHERE CONVERT(INT,RIGHT(CONVERT(VARCHAR, 100 + [gd_esquema].[Maestra].AUTO_PARTE_CODIGO), 2)) = ID_CATEGORIA ) IS NOT NULL
					THEN (SELECT TOP 1 ID_CATEGORIA FROM [WHITE_WALKERS].[CATEGORIA] WHERE CONVERT(INT,RIGHT(CONVERT(VARCHAR, 100 + [gd_esquema].[Maestra].AUTO_PARTE_CODIGO), 2)) = ID_CATEGORIA )
					ELSE 8 
			END
FROM [gd_esquema].[Maestra] 
WHERE AUTO_PARTE_CODIGO IS NOT NULL

GO

INSERT INTO #FAC_CLIENTE (FACTURA_NRO, ID_CLIENTE)
SELECT DISTINCT M.FACTURA_NRO,C.ID_CLIENTE 
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[CLIENTE] C
	 ON M.FAC_CLIENTE_APELLIDO = C.CLIENTE_APELLIDO	
	 AND M.FAC_CLIENTE_NOMBRE = C.CLIENTE_NOMBRE
	 AND M.FAC_CLIENTE_DIRECCION = C.CLIENTE_DIRECCION
	 AND M.FAC_CLIENTE_DNI = C.CLIENTE_DNI
	 AND M.FAC_CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
	 AND M.FAC_CLIENTE_MAIL = C.CLIENTE_MAIL
	 AND M.FACTURA_NRO IS NOT NULL
	 AND M.FAC_CLIENTE_DNI IS NOT NULL

INSERT INTO #FAC_SUCURSAL (FACTURA_NRO, ID_SUCURSAL)
SELECT DISTINCT M.FACTURA_NRO,S.ID_SUCURSAL
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[SUCURSAL] S
	 ON M.FAC_SUCURSAL_CIUDAD = S.SUCURSAL_CIUDAD
	 AND M.FAC_SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION
	 AND M.FAC_SUCURSAL_MAIL = S.SUCURSAL_MAIL
	 AND M.FAC_SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
	 AND M.FACTURA_NRO IS NOT NULL
	 AND M.FAC_SUCURSAL_MAIL IS NOT NULL

INSERT INTO [WHITE_WALKERS].[FACTURA]
           ([FACTURA_NRO]
           ,[ID_CLIENTE]
           ,[ID_SUCURSAL]
           ,[FACTURA_FECHA])
SELECT DISTINCT 
            M.FACTURA_NRO
           ,FC.ID_CLIENTE
           ,FS.ID_SUCURSAL
           ,M.FACTURA_FECHA
FROM [gd_esquema].[Maestra] M
LEFT JOIN #FAC_CLIENTE FC
	ON M.FACTURA_NRO = FC.FACTURA_NRO
LEFT JOIN #FAC_SUCURSAL FS
	ON M.FACTURA_NRO = FS.FACTURA_NRO
WHERE M.FACTURA_NRO IS NOT NULL
ORDER BY M.FACTURA_NRO ASC

GO

INSERT INTO [WHITE_WALKERS].[FACTURA_AUTO]
           ([FACTURA_NRO]
           ,[ID_AUTO]
           ,[PRECIO_FACTURADO])
SELECT DISTINCT 
            M.FACTURA_NRO
           ,A.ID_AUTO
           ,M.PRECIO_FACTURADO
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[AUTO] A
	ON M.[AUTO_NRO_CHASIS] = A.[AUTO_NRO_CHASIS]
      AND M.[AUTO_NRO_MOTOR] = A.[AUTO_NRO_MOTOR]
      AND M.[AUTO_PATENTE] = A.[AUTO_PATENTE]
      AND M.[AUTO_FECHA_ALTA] = A.[AUTO_FECHA_ALTA]
WHERE M.FACTURA_NRO IS NOT NULL
ORDER BY M.FACTURA_NRO ASC

GO

INSERT INTO [WHITE_WALKERS].[FACTURA_AUTO_PARTE]
           ([FACTURA_NRO]
           ,[AUTO_PARTE_CODIGO]
           ,[PRECIO_FACTURADO]
           ,[CANT_FACTURADA])
SELECT DISTINCT 
            FACTURA_NRO
           ,AUTO_PARTE_CODIGO
           ,PRECIO_FACTURADO
           ,SUM(CANT_FACTURADA) CANT_FACTURADA
FROM [gd_esquema].[Maestra] 
WHERE FACTURA_NRO IS NOT NULL
	AND AUTO_PARTE_CODIGO IS NOT NULL
GROUP BY FACTURA_NRO, AUTO_PARTE_CODIGO, PRECIO_FACTURADO
ORDER BY FACTURA_NRO ASC, AUTO_PARTE_CODIGO ASC

GO

INSERT INTO #COM_CLIENTE (COMPRA_NRO, ID_CLIENTE)
SELECT DISTINCT M.COMPRA_NRO,C.ID_CLIENTE 
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[CLIENTE] C
	 ON M.CLIENTE_APELLIDO = C.CLIENTE_APELLIDO	
	 AND M.CLIENTE_NOMBRE = C.CLIENTE_NOMBRE
	 AND M.CLIENTE_DIRECCION = C.CLIENTE_DIRECCION
	 AND M.CLIENTE_DNI = C.CLIENTE_DNI
	 AND M.CLIENTE_FECHA_NAC = C.CLIENTE_FECHA_NAC
	 AND M.CLIENTE_MAIL = C.CLIENTE_MAIL
	 AND M.COMPRA_NRO IS NOT NULL
	 AND M.CLIENTE_DNI IS NOT NULL

INSERT INTO #COM_SUCURSAL (COMPRA_NRO, ID_SUCURSAL)
SELECT DISTINCT M.COMPRA_NRO,S.ID_SUCURSAL
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[SUCURSAL] S
	 ON M.SUCURSAL_CIUDAD = S.SUCURSAL_CIUDAD
	 AND M.SUCURSAL_DIRECCION = S.SUCURSAL_DIRECCION
	 AND M.SUCURSAL_MAIL = S.SUCURSAL_MAIL
	 AND M.SUCURSAL_TELEFONO = S.SUCURSAL_TELEFONO
	 AND M.COMPRA_NRO IS NOT NULL
	 AND M.SUCURSAL_MAIL IS NOT NULL

INSERT INTO [WHITE_WALKERS].[COMPRA]
           ([COMPRA_NRO]
           ,[ID_CLIENTE]
           ,[ID_SUCURSAL]
           ,[COMPRA_FECHA])
SELECT DISTINCT 
            M.COMPRA_NRO
           ,CC.ID_CLIENTE
           ,CS.ID_SUCURSAL
           ,M.COMPRA_FECHA
FROM [gd_esquema].[Maestra] M
LEFT JOIN #COM_CLIENTE CC
	ON M.COMPRA_NRO = CC.COMPRA_NRO
LEFT JOIN #COM_SUCURSAL CS
	ON M.COMPRA_NRO = CS.COMPRA_NRO
WHERE M.COMPRA_NRO IS NOT NULL
ORDER BY M.COMPRA_NRO ASC

GO

INSERT INTO [WHITE_WALKERS].[COMPRA_AUTO]
           ([COMPRA_NRO]
           ,[ID_AUTO]
           ,[COMPRA_PRECIO])
SELECT DISTINCT 
            M.COMPRA_NRO
           ,A.ID_AUTO
           ,M.COMPRA_PRECIO
FROM [gd_esquema].[Maestra] M
INNER JOIN [WHITE_WALKERS].[AUTO] A
	ON M.[AUTO_NRO_CHASIS] = A.[AUTO_NRO_CHASIS]
      AND M.[AUTO_NRO_MOTOR] = A.[AUTO_NRO_MOTOR]
      AND M.[AUTO_PATENTE] = A.[AUTO_PATENTE]
      AND M.[AUTO_FECHA_ALTA] = A.[AUTO_FECHA_ALTA]
ORDER BY M.COMPRA_NRO ASC, A.ID_AUTO ASC

GO

INSERT INTO [WHITE_WALKERS].[COMPRA_AUTO_PARTE]
           ([COMPRA_NRO]
           ,[AUTO_PARTE_CODIGO]
           ,[COMPRA_PRECIO]
		   ,[COMPRA_CANT])
SELECT  
            COMPRA_NRO
           ,AUTO_PARTE_CODIGO
           ,COMPRA_PRECIO
           ,SUM(COMPRA_CANT) COMPRA_CANT
FROM [gd_esquema].[Maestra] M
WHERE M.COMPRA_NRO IS NOT NULL
	AND M.AUTO_PARTE_CODIGO IS NOT NULL
GROUP BY COMPRA_NRO, AUTO_PARTE_CODIGO, COMPRA_PRECIO
ORDER BY COMPRA_NRO ASC, AUTO_PARTE_CODIGO ASC

GO





/*************************************************************/