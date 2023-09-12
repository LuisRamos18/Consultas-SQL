
SELECT T2.[cNombre] AS Tipo, T3.[cCuentaCompleta] AS Clave_Presupuestal, T0.[iIdRequisicion] AS Requisicion, T1.[iIdDetRequisicion] AS ID_Detalle_Requi,
(SELECT SUM(T1.[dTotal]) FROM Pro.DetRequisicion T1 WHERE T0.iIdRequisicion = T1.iIdRequisicion and T0.iIdPeriodo = T1.iIdPeriodo) AS Total_Requi,
T1.[dTotal] AS Importe_ID_Requi, T5.[cNombre] AS Estatus_Requi, T6.[iIdOrden] AS OC, T8.[iIdDetalleOrden] AS Det_OC,
T7.[iIdProveedor] AS ID_Proveedor, T17.[cDescripcionLarga] AS UA, T7.[cIdFF] AS Fuente,
(SELECT SUM(T8.[dTotal]) FROM Compras.DetalleOrden T8 WHERE T7.iIdOrden = T8.iIdOrden and T0.iIdPeriodo = T8.iIdPeriodo) AS Total_Orden,
T8.[dTotal] AS Importe_ID_OC, T7.[iNumeroEvento] AS N_Evento,
T8.[dCantidad] AS Cantidad_Total_Solictada,T12.[dCantidad] AS Cantidad_Surtida, (T8.[dCantidad]-T8.[dCantidadRecibida]) AS Total_Pendiente,
(T12.[dCantidad] * T1.[dPrecioReferencia]* T8.[dIva]) AS Importe_Surtido,
(T8.[dCantidad]-T8.[dCantidadRecibida])*(T1.[dPrecioReferencia] * T8.[dIva]) AS Importe_Pendiente,
T11.[cNombre] AS Estatus_OC,
T13.[iIdCxP] AS CXP, T16.[cIdEstatus] AS ID_Estatus,
T16.[cNombre] AS Estatus, CASE WHEN T13.[iIdCxP] >= 1 THEN CONCAT(T14.[cIdTipoRecurso],' ',T26.[cNombre]) ELSE NULL END  AS Tipo_Financiamiento, CONVERT(nvarchar(30),T14.[dtAlta],3) AS Fecha_Alta,T14.[cIdUnidadAdministrativa] AS UA,
T14.[dImporte] AS Importe_CXP,
CASE WHEN T14.[iIdTipoBeneficiario] = 1 THEN 'Proveedor'
WHEN T14.[iIdTipoBeneficiario] = 2 THEN 'Empleado'
ELSE NULL END AS Tipo_Bene, T14.[iBeneficiario] AS ID_Ben, T19.[cnombrecompleto] AS Proveedor,
T14.[cConcepto] AS Concepto_CXP,CONVERT(nvarchar(30),T21.[dtProbablePago],3) AS Fecha_Probable_Pago,
CASE WHEN T13.[iIdCxP] >= 1 THEN CONCAT(SUBSTRING(T3.[cCuentaCompleta],1,19),' ',T25.cNombre)
ELSE NULL END AS Partida_Especifica,
T22.[cNombre] AS Pago,T21.[cReferenciaBancaria] AS Referencia_Pago, T23.[cNombre] AS Etapa_Pago,
CONVERT(nvarchar(30),T21.[dtEmisionPago],3) AS Fecha_Emision, T24.[cNombreBanco] AS Banco, T13.[cFolioFactura] AS Factura
FROM Pro.Requisiciones T0
left join Pro.DetRequisicion T1 on T0.[iIdPeriodo] = T1.[iIdPeriodo] and T0.[iIdRequisicion] = T1.[iIdRequisicion]
inner join Compras.cat_TipoRequisicion T2 on T0.[iIdTipoRequisicion] = T2.[iIdTipoRequisicion]
left join tblCuentaCompleta T3 on T0.[iIdPeriodo] = T3.[iIdPeriodo] and T1.[iIdCuenta] = T3.[iIdCuenta]
inner join dbo.DetallesSolicitud T4 on T0.[iIdPeriodo] = T4.[iIdPeriodo] and T0.[iIdSolicitud] = T4.[iIdSolicitud] and T0.[iIdDetalleSolicitud] = T4.[iIdDetalleSolicitud] 
left join dbo.Cat_Etapas T5 on T4.[iIdEtapa] = T5.[iIdEtapa] and T4.[iIdProceso] = T5.[iIdProceso]
left join Compras.DetalleDetalleOrden T6 on T0.[iIdPeriodo] = T6.[iIdPeriodo] and T0.[iIdRequisicion] = T6.[iIdRequisicion] and T1.[iIdDetRequisicion] =  T6.[iIdDetRequisicion]
left join Pro.OrdenCompra T7 on T0.[iIdPeriodo] = T7.[iIdPeriodo] and T6.[iIdOrden] = T7.[iIdOrden]
left join Compras.DetalleOrden T8 on T0.[iIdPeriodo] = T8.[iIdPeriodo] and T7.[iIdOrden] = T8.[iIdOrden] and T6.[iIdDetalleOrden] = T8.[iIdDetalleOrden]
left join Compras.OrdenRecepcion T9 on T0.[iIdPeriodo] = T0.[iIdPeriodo] and T7.[iIdOrden] = T9.[iIdOrden]
left join dbo.DetallesSolicitud T10 on T7.[iIdPeriodo] = T10.[iIdPeriodo] and T7.[iIdSolicitud] = T10.[iIdSolicitud] and T7.[iIdDetalleSolicitud] = T10.[iIdDetalleSolicitud] 
left join dbo.Cat_Etapas T11 on T10.[iIdEtapa] = T11.[iIdEtapa] and T10.[iIdProceso] = T11.[iIdProceso]
left join Compras.OrdenRecepcion T12 on T0.[iIdPeriodo] = T12.[iIdPeriodo] and T7.[iIdOrden] = T12.[iIdOrden] and T8.[iIdDetalleOrden] = T12.[iIdDetalleOrden]
left join Compras.RecepcionOrdenGrupo T13 on T0.[iIdPeriodo] = T13.[iIdPeriodo] and T12.[iIdOrden] = T13.[iIdOrden] and T12.[iIdRecepcionOrdenGrupo] = T13.[iIdRecepcionOrdenGrupo]
left join Pro.CuentasxPagar T14 on T0.[iIdPeriodo] = T14.[iIdPeriodo] and T13.[iIdCxP] = T14.[iIdCuentasxPagar]
left join dbo.DetallesSolicitud T15 on T14.[iIdPeriodo] = T15.[iIdPeriodo] and T14.[iIdSolicitud] = T15.[iIdSolicitud] and T14.[iIdDetalleSolicitud] = T15.[iIdDetalleSolicitud] and T14.[cIdSistema] = T15.[cIdSistema] 
left join dbo.Cat_Etapas T16 on T15.[iIdEtapa] = T16.[iIdEtapa] and T15.[iIdProceso] = T16.[iIdProceso]
left join [dbo].[Cat_UnidadesAdministrativas] T17 on T0.[iIdPeriodo] = T17.[iIdPeriodo] and T7.[cIdUnidadAdministrativa] = T17.[cIdUnidadAdministrativa]
left join [Financiero].[Proveedor] T18 on T14.[iBeneficiario] = T18.[iIdProveedor]
left join [Padron].[padron] T19 on T18.[iIdPadron] = T19.[iidfoliopadron]
left join Egresos.DetallePago T21 on T0.[iIdPeriodo] = T21.[iIdPeriodo] and T14.[iIdCuentasxPagar] = T21.[iIdCuentasxPagar]
left join Financiero.Cat_TipoPago T22 on T21.[iIdTipoPago] = T22.[iIdTipoPago]
left join dbo.Cat_Etapas T23 on T21.[iIdEtapa] = T23.[iIdEtapa] and T21.[iIdProceso] = T23.[iIdProceso]
left join Financiero.Cat_Bancos T24 on T21.[iIdBanco] = T24.[iIdBanco]
left join [Financiero].[Cat_SubFamilia] T25 on SUBSTRING(T3.[cCuentaCompleta],16,4) = CONVERT(nvarchar(10),T25.[iIdSubFamilia])
left join [Financiero].[FuenteFinanciamiento] T26 on T0.[iIdPeriodo] = T26.[iIdPeriodo] and T14.[cIdTipoRecurso] = T26.[cIdFuenteFinanciamiento]
WHERE T0.[iIdPeriodo] = 2022
GROUP BY T0.iIdPeriodo,T2.[cNombre],T1.[iIdCuenta], T3.[cCuentaCompleta],T0.[iIdRequisicion],T1.[iIdDetRequisicion],
T1.[dTotal],T4.[iIdEtapa],T5.[cNombre],T6.[iIdOrden],T8.[iIdDetalleOrden],T7.[iIdProveedor],T7.[cIdFF],
T8.[dTotal], T7.[iNumeroEvento],T8.[dCantidadRecibida],T8.[dCantidad], T10.[iIdEtapa],T11.[cNombre],
T12.[dCantidad],T13.[iIdCxP],T15.[iIdEtapa],T16.[cNombre],T14.[cIdTipoRecurso],T26.[cNombre],T14.[dtAlta], T14.[cIdUnidadAdministrativa],T14.[iIdTipoBeneficiario],
T17.[cDescripcionLarga],T1.[dPrecioReferencia],T1.[dPorcentajeIVA],T14.[dImporte],T14.[iBeneficiario],T19.[cnombrecompleto],T14.[cConcepto],T22.[cNombre],
T23.[cNombre],T21.[dtProbablePago],T21.[dtEmisionPago],T24.[cNombreBanco], T13.[cFolioFactura],T21.[cReferenciaBancaria],T16.[cIdEstatus],T25.cNombre,T8.[dIva],T7.iIdOrden
ORDER BY T0.[iIdRequisicion],T1.[iIdDetRequisicion],T6.[iIdOrden],T8.[iIdDetalleOrden],T7.[iNumeroEvento],T10.[iIdEtapa],T12.[dCantidad]