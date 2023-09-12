---DECLARAMOS VARIABLES DE LA ENTRADA DE ALMAC�N---

DECLARE @PERIODO INT = 2022;---INGRESAS EL PERIODO---
DECLARE  @ENTRADA INT = 8556; ---INGRESAS LA ENTRADA DADA POR EL USUARIO---

---CREAMOS TABLA TEMPORAL---
CREATE TABLE #TEMP (
TIPO NVARCHAR(30),
FOLIO INT,
OC INT,
ORIGEN INT,
BMS INT,
ETAPA NVARCHAR(40))

---INSERTAMOS EN TABLA TEMPORAL LOS DATOS DE LOS BMS DE LA ENTRADA----
INSERT INTO #TEMP
select 'ENTRADA' AS Tipo, T0.iIdMovimiento AS Folio, T0.iIdOrden AS Folio_OC, T0.iIdRequisicion AS Origen, T0.iIdFolioBMS AS BMS, 
T3.cNombre AS Etapa
from Almacen.tblRel_MovimientoBMS T0 
INNER JOIN [Almacen].[DetalleMovimiento] T1 on T0.iIdPeriodo = T1.iIdPeriodo and T0.iIdFolioBMS = T1.iIdFolioBMS and T0.iIdMovimiento = T1.iIdMovimiento and T0.iIdAlmacen = T1.iIdAlmacen
INNER JOIN dbo.DetallesSolicitud T2 on T0.iIdPeriodo = T2.iIdPeriodo and T1.[iIdSolicitud] = T2.[iIdSolicitud] and T1.[iIdDetalleSolicitud] = T2.[iIdDetalleSolicitud]
INNER JOIN dbo.Cat_Etapas T3 on T2.iIdEtapa = T3.iIdEtapa
where T0.iIdPeriodo=2022 and T0.iIdMovimiento = @ENTRADA 
and T0.lTipoMovimiento=1  and T2.iIdEtapa != 147 

---DECLARAMOS VALORES PARA SALIDAS DEL ALMACEN RELACIONADOS A LOS BMS DE LA ENTRADA---
DECLARE @PERIODO2 INT = 2022; ---PERIODO---
DECLARE @ORDEN INT = (SELECT TOP 1 OC FROM #TEMP); ---ORDEN DE COMPRA DE ENTRADA PARA BUSCAR SALIDAS RELACIONADAS--
DECLARE @BMSMIN INT = (SELECT TOP 1 BMS FROM #TEMP ORDER BY BMS ASC); ---PRIMER REGISTRO BMS---
DECLARE @BMSMAX INT = (SELECT TOP 1 BMS FROM #TEMP ORDER BY BMS DESC);---ULTIMO REGISTRO BMS---

select distinct 'SALIDA' AS Tipo, T0.iIdMovimiento AS Folio, T0.iIdOrden AS Folio_OC, T0.iIdRequisicion AS Origen, T0.iIdFolioBMS AS BMS, 
T3.cNombre AS Etapa
from Almacen.tblRel_MovimientoBMS T0 
INNER JOIN [Almacen].[DetalleMovimiento] T1 on T0.iIdPeriodo = T1.iIdPeriodo and T0.iIdFolioBMS = T1.iIdFolioBMS and T0.iIdMovimiento = T1.iIdMovimiento and T0.iIdAlmacen = T1.iIdAlmacen
INNER JOIN dbo.DetallesSolicitud T2 on T0.iIdPeriodo = T2.iIdPeriodo and T1.[iIdSolicitud] = T2.[iIdSolicitud] and T1.[iIdDetalleSolicitud] = T2.[iIdDetalleSolicitud]
INNER JOIN dbo.Cat_Etapas T3 on T2.iIdEtapa = T3.iIdEtapa
where T0.iIdOrden=@ORDEN and T0.iIdPeriodo=@PERIODO2 and T0.iIdFolioBMS IN(SELECT BMS FROM #TEMP where BMS BETWEEN @BMSMIN AND @BMSMAX)
and T0.lTipoMovimiento=0  and T2.iIdEtapa != 147 GROUP BY T0.iIdMovimiento,T0.iIdOrden,T0.iIdRequisicion,T0.iIdFolioBMS,T3.cNombre