use VojnaAkademija;
GO

CREATE VIEW pogledi as
select 
Ime as 'ImeZap', Prezime as 'PrezimeZap', NazivCina as 'Cin', 
NazivRM as 'RadnoMesto', DatOd as 'PocetakAngazovanja'
from(ZAPOSLENI as z JOIN CIN as c ON z.SifraCina=c.SifraCina
JOIN ANGAZOVANJE as a on z.ZaposleniID=a.ZaposleniID
JOIN RADNO_MESTO as rm on rm.SifraRM=a.SifraRM)

go
select ImeZap, PrezimeZap, Cin, RadnoMesto, PocetakAngazovanja
from pogledi


