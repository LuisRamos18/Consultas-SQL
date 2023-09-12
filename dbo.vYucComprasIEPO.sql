
SET LANGUAGE Spanish
SELECT TOP (100) PERCENT T0.[iIdPeriodo] AS Periodo, DATENAME(MONTH ,T0.[dtAlta]) AS Mes,T0.[cIdUnidadAdministrativa] AS CECO, SUBSTRING(T0.[cIdUnidadAdministrativa],1, 2) AS Ramo, T7.[cDescripcionCorta] AS Nombre_Ramo,
SUBSTRING(T0.[cIdUnidadAdministrativa],4, 1) AS Direccion, T8.[cDescripcionCorta] AS Nombre_Direccion,SUBSTRING(T0.[cIdUnidadAdministrativa],6, 2) AS Departamento,
T9.[cDescripcionCorta] AS Nombre_Departamento, T0.[iIdProveedor] AS ID_Proveedor,T6.[cnombrecompleto] AS Proveedor,  T6.[crfc] AS RFC,T10.[iIdPoa] AS UBP,T10.[cCuenta] AS Objeto_Gasto,
SUBSTRING(T0.[cIdFF],6,4) AS Fuente_Financiamiento,T0.[iIdOrden] AS Orden_OC,
SUBSTRING(T10.[cCuenta],11,4) AS Generica, SUBSTRING(T10.[cCuenta],16,4) AS Especifica,
(SELECT TOP 1 (T11.[ccodigopostal] )FROM Pro.OrdenCompra inner join Padron.direccion T11 on T6.[iidfoliopadron] =T11.[iidfoliopadron]) AS Codigo_Postal,
CASE WHEN (SELECT TOP 1 (T11.[ccodigopostal] )FROM Pro.OrdenCompra inner join Padron.direccion T11 on T6.[iidfoliopadron] =T11.[iidfoliopadron]) LIKE '97___' THEN 'Yucateca' ELSE '' END AS Empresa,
T4.[cDescripcion] AS Descripcion, T14.[cNombre] AS Proceso,T2.[dSubtotal] AS SubTotal, T2.[dTotal] AS Total
from   Pro.OrdenCompra T0
inner join dbo.DetallesSolicitud T1 on T0.[iIdSolicitud]=T1.[iIdSolicitud] and T0.[iIdPeriodo] = T1.[iIdPeriodo] and T0.[iIdDetalleSolicitud] = T1.[iIdDetalleSolicitud]
left join Compras.DetalleDetalleOrden T2 on T0.[iIdPeriodo] = T2.[iIdPeriodo] and T0.[iIdOrden] = T2.[iIdOrden]
inner join Pro.DetRequisicion T3 on T2.[iIdRequisicion] = T3.[iIdRequisicion] and T2.[iIdDetRequisicion] = T3.[iIdDetRequisicion] and T2.[iIdPeriodo] = T3.[iIdPeriodo]
inner join Financiero.Cat_BMS T4 on T3.[iIdFolioBMS] = T4.[iIdFolioBMS]
inner join Financiero.Proveedor T5 on T0.[iIdProveedor] = T5.[iIdProveedor]
inner join Padron.padron T6 on T5.[iIdPadron] = T6.[iidfoliopadron]
inner join dbo.Cat_UnidadesAdministrativas T7 on T0.[iIdPeriodo] = T7.[iIdPeriodo] and T7.[cIdUnidadAdministrativa] = SUBSTRING(T0.[cIdUnidadAdministrativa],1, 2)
inner join dbo.Cat_UnidadesAdministrativas T8 on T0.[iIdPeriodo] = T8.[iIdPeriodo] and T8.[cIdUnidadAdministrativa] = SUBSTRING(T0.[cIdUnidadAdministrativa],1, 4)
inner join dbo.Cat_UnidadesAdministrativas T9 on T0.[iIdPeriodo] = T9.[iIdPeriodo] and T9.[cIdUnidadAdministrativa] = SUBSTRING(T0.[cIdUnidadAdministrativa],1, 7)
inner join tblCuentaCompleta T10 on T10.[iIdPeriodo] = T0.[iIdPeriodo] and T10.[iIdCuenta] = T3.[iIdCuenta]
left join Compras.DetalleOrden T13 on T0.[iIdPeriodo] = T13.[iIdPeriodo] and T0.[iIdOrden] = T13.[iIdOrden] and T2.[iIdDetalleOrden] = T13.[iIdDetalleOrden]
left join Financiero.Cat_ProcesoCompra T14 on T13.[iIdProcesoCompra] = T14.[iIdProcesoCompra]
WHERE T1.[iIdEtapa] = 27 and T6.[lactivo]=1
ORDER BY T0.[iIdPeriodo], T0.[iIdOrden], T2.[iIdDetalleOrden]
