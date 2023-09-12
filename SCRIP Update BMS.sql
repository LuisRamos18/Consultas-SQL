
DECLARE @BMS INT, @FOLIO NVARCHAR(30)
SET @BMS = 19285 ----NUMERO DE INICIO---
WHILE (@BMS <=19292)---NUMERO DE FIN---
BEGIN
SET @BMS = @BMS + 1
SET @FOLIO = @BMS
update financiero.Cat_BMS set cClaveBMS=@FOLIO where iIdFolioBMS = @BMS
END

select * from financiero.Cat_BMS