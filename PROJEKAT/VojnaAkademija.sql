use master;
Go
IF EXISTS (SELECT name FROM master.dbo.sysdatabases
WHERE name = N'VojnaAkademija')
DROP DATABASE VojnaAkademija
Go

CREATE DATABASE VojnaAkademija;
go

use VojnaAkademija;
Go

CREATE TABLE CIN
(
	SifraCina int not null,
	NazivCina nvarchar (30) not null,
	PRIMARY KEY (SifraCina)
);

CREATE TABLE ADRESA
(
	NazivAdrese nvarchar (50) not null,
	Broj int null,
	Grad nvarchar (30) null,
	PRIMARY KEY (NazivAdrese)
);

CREATE TABLE AUTOR
(
	SifraAutora int not null,
	ImePrezimeAutora nvarchar (30) not null,
	PRIMARY KEY (SifraAutora)
);

CREATE TABLE SOBA
(
	SobaID int not null,
	Sprat int not null,
	BrojKreveta int not null,
	PRIMARY KEY (SobaID)
);

CREATE TABLE PREDMET
(
	SifraPredmeta int not null,
	NazivPredmeta nvarchar (50) not null,
	ESPB int not null,
	Semestar int not null,
	StatusPredmeta nvarchar (15) not null,
	PRIMARY KEY (SifraPredmeta)
);

CREATE TABLE STUDIJSKI_PROGRAM
(
	SmerID int not null,
	NazivSmera nvarchar (50) not null,
	Godina int not null,
	PRIMARY KEY (SmerID)
);

CREATE TABLE LOKACIJA
(
	SifraLokacije int not null,
	NazivLokacije nvarchar (30) not null,
	NazivAdrese nvarchar (50) not null,
	SifraPredmeta int not null,
	PRIMARY KEY (SifraLokacije),
	FOREIGN KEY (NazivAdrese) REFERENCES ADRESA (NazivAdrese),
	FOREIGN KEY (SifraPredmeta) REFERENCES PREDMET (SifraPredmeta)
);

CREATE TABLE LITERATURA
(
	LiteraturaID int not null,
	NazivLiterature nvarchar (50) not null,
	DatumIzdanja date not null,
	SifraPredmeta int not null,
	SifraAutora int not null,
	PRIMARY KEY (LiteraturaID),
	FOREIGN KEY (SifraPredmeta) REFERENCES PREDMET (SifraPredmeta),
	FOREIGN KEY (SifraAutora) REFERENCES AUTOR (SifraAutora)
);

CREATE TABLE KLASA 
(
	KlasaID int not null,
	BrStudenata int not null,
	SmerID int not null,
	PRIMARY KEY (KlasaID),
	FOREIGN KEY (SmerID) REFERENCES STUDIJSKI_PROGRAM (SmerID)
);

CREATE TABLE RADNO_MESTO
(
	SifraRM int not null,
	NazivRM nvarchar (50) not null,
	PRIMARY KEY (SifraRM)
);

CREATE TABLE ZAPOSLENI
(
	ZaposleniID int not null,
	Ime nvarchar (20) not null,
	Prezime nvarchar (20) not null,
	JMBG numeric (18,2) not null,
	Plata money null,
	Premija money null,
	DatumRodjenja date not null,
	SifraNadredjenog int null,
	SifraCina int null,
	PRIMARY KEY (ZaposleniID),
	FOREIGN KEY (SifraCina) REFERENCES CIN (SifraCina)
);

CREATE TABLE ANGAZOVANJE
(
	DatOd date not null,
	Datdo date null,
	SifraRM int not null,
	ZaposleniID int not null,
	FOREIGN KEY (SifraRM) REFERENCES RADNO_MESTO (SifraRM),
	FOREIGN KEY (ZaposleniID) REFERENCES ZAPOSLENI (ZaposleniID)
);

CREATE TABLE OPREMA 
(
	SifraOpreme int not null,
	VrstaOpreme nvarchar (10) not null,
	PRIMARY KEY (SifraOpreme)
);

CREATE TABLE KADETI
(
	SifraKadeta int not null,
	ImeKadeta nvarchar (15) not null,
	PrezimeKadeta nvarchar (20) not null,
	Pol nvarchar (10) not null,
	GodinaStudija int not null,
	Prosek float null,
	Rodjendan date not null,
	KlasaID int not null,
	PRIMARY KEY (SifraKadeta),
	FOREIGN KEY (KlasaID) REFERENCES KLASA (KlasaID)
);

CREATE TABLE UNIFORMA
(
	SifraUniforme int not null,
	Velicina nvarchar (5) not null,
	PRIMARY KEY (SifraUniforme)
);

CREATE TABLE ODGOVORNOST
(
	OdgovornostOd date not null,
	OdgovornostDo date null,
	ZaposleniID int not null,
	SifraOpreme int not null,
	FOREIGN KEY (ZaposleniID) REFERENCES ZAPOSLENI (ZaposleniID),
	FOREIGN KEY (SifraOpreme) REFERENCES OPREMA (SifraOpreme)
);

CREATE TABLE ISPIT
(
	TerminPolaganja date not  null,
	NacinPolaganja nvarchar (15) not null,
	SifraPredmeta int not null,
	SifraKadeta int null,
	FOREIGN KEY (SifraPredmeta) REFERENCES PREDMET (SifraPredmeta),
	FOREIGN KEY (SifraKadeta) REFERENCES KADETI (SifraKadeta)
);

CREATE TABLE BORAVAK
(
	DatumUseljenja date null,
	SobaID int not null,
	SifraKadeta int not null,
	FOREIGN KEY (SobaID) REFERENCES SOBA (SobaID),
	FOREIGN KEY (SifraKadeta) REFERENCES KADETI (SifraKadeta)
);

CREATE TABLE ZADUZENJE
(
	DatumZaduzenja date null,
	SifraKadeta int not null,
	SifraUniforme int not null,
	FOREIGN KEY (SifraKadeta) REFERENCES KADETI (SifraKadeta),
	FOREIGN KEY (SifraUniforme) REFERENCES UNIFORMA (SifraUniforme)
);

CREATE TABLE INDEKS
(
	BrojIndeksa int not null,
	BrPolozenihIspita int null,
	SifraKadeta int not null,
	PRIMARY KEY (BrojIndeksa),
	FOREIGN KEY (SifraKadeta) REFERENCES KADETI (SifraKadeta)
);

CREATE TABLE ORUZJE
(
	SifraOpreme int not null,
	VrstaOruzja nvarchar (30) not null,
	ModelOruzja int not null,
	PRIMARY KEY (SifraOpreme),
	FOREIGN KEY (SifraOpreme) REFERENCES OPREMA (SifraOpreme)
);

CREATE TABLE MOTORNA_VOZILA 
(
	SifraOpreme int not null,
	VrstaVozila nvarchar (30) not null,
	ModelVozila int not null,
	PRIMARY KEY (SifraOpreme),
	FOREIGN KEY (SifraOpreme) REFERENCES OPREMA (SifraOpreme)
);

Go

INSERT INTO CIN VALUES ('100','General');
INSERT INTO CIN VALUES ('101','Pukovnik');
INSERT INTO CIN VALUES ('102','Potpukovnik');
INSERT INTO CIN VALUES ('103','Major');
INSERT INTO CIN VALUES ('104','Kapetan');
INSERT INTO CIN VALUES ('105','Porucnik');
INSERT INTO CIN VALUES ('106','Potporucnik');
INSERT INTO CIN VALUES ('107','Zastavnik');

INSERT INTO ADRESA VALUES ('Generala Pavla Jurisica Sturma','33','Beograd');

INSERT INTO AUTOR VALUES ('51','Jovan Petrovic');
INSERT INTO AUTOR VALUES ('52','Milovan Cosic');
INSERT INTO AUTOR VALUES ('53','Zdravko Matic');
INSERT INTO AUTOR VALUES ('54','Mileta Vojnovic');
INSERT INTO AUTOR VALUES ('55','Aleksandar Petrusic');
INSERT INTO AUTOR VALUES ('56','Zoran Zivkovic');
INSERT INTO AUTOR VALUES ('57','Jelisaveta Stojanovic');
INSERT INTO AUTOR VALUES ('58','Branimir Jovanovic');
INSERT INTO AUTOR VALUES ('59','Katarina Paunovic');
INSERT INTO AUTOR VALUES ('60','Radoslav Ilic');

INSERT INTO SOBA VALUES ('15','2','3');
INSERT INTO SOBA VALUES ('18','2','4');
INSERT INTO SOBA VALUES ('21','3','3');
INSERT INTO SOBA VALUES ('24','3','4');
INSERT INTO SOBA VALUES ('28','3','3');
INSERT INTO SOBA VALUES ('32','4','4');

INSERT INTO PREDMET VALUES ('201','Matematika','6','1','Obavezni');
INSERT INTO PREDMET VALUES ('202','Fizika','5','1','Obavezni');
INSERT INTO PREDMET VALUES ('203','Vojna Istorija','4','2','Obavezni');
INSERT INTO PREDMET VALUES ('204','Vojna topografija','4','2','Obavezni');
INSERT INTO PREDMET VALUES ('205','Vojna etika','3','3','Obavezni');
INSERT INTO PREDMET VALUES ('206', 'Naoruzanje PVO','4','3','Izborni');
INSERT INTO PREDMET VALUES ('207','Teorija gadjanja ARJ za PVD','5','4','Izborni'); 
INSERT INTO PREDMET VALUES ('208','Raketna tehnika','5','4','Izborni');
INSERT INTO PREDMET VALUES ('209','Osnovi komandovanja i rukovodjenja','6','6','Obavezni');
INSERT INTO PREDMET VALUES ('210','Vojna psihologija','3','5','Obavezni');

INSERT INTO STUDIJSKI_PROGRAM VALUES ('1','Menadzment u odbrani','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('2','Protivvazduhoplovna odbrana','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('3','Vojnomasinsko inzenjerstvo','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('4','Vojnoelektronsko inzenjerstvo','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('5','ABH odbrana','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('6','Logistika odbrane','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('7','Vojnogeodetsko inzenjerstvo','4');
INSERT INTO STUDIJSKI_PROGRAM VALUES ('8','Vojno vazduhoplovstvo','4');

INSERT INTO LOKACIJA VALUES ('11','Vojna akademija','Generala Pavla Jurisica Sturma','201');
INSERT INTO LOKACIJA VALUES ('12','Vojna akademija','Generala Pavla Jurisica Sturma','202');
INSERT INTO LOKACIJA VALUES ('13','Vojna akademija','Generala Pavla Jurisica Sturma','203');
INSERT INTO LOKACIJA VALUES ('14','Vojna akademija','Generala Pavla Jurisica Sturma','204');
INSERT INTO LOKACIJA VALUES ('15','Vojna akademija','Generala Pavla Jurisica Sturma','205');
INSERT INTO LOKACIJA VALUES ('16','Vojna akademija','Generala Pavla Jurisica Sturma','206');
INSERT INTO LOKACIJA VALUES ('17','Vojna akademija','Generala Pavla Jurisica Sturma','207');
INSERT INTO LOKACIJA VALUES ('18','Vojna akademija','Generala Pavla Jurisica Sturma','208');
INSERT INTO LOKACIJA VALUES ('19','Vojna akademija','Generala Pavla Jurisica Sturma','209');
INSERT INTO LOKACIJA VALUES ('20','Vojna akademija','Generala Pavla Jurisica Sturma','210');

INSERT INTO LITERATURA VALUES ('151','Matematika za prvu godinu','12.6.2009','201','51');
INSERT INTO LITERATURA VALUES ('152','Fizika za prvu godinu','9.12.2008','202','52');
INSERT INTO LITERATURA VALUES ('153','Vojna istorija udzbenik','3.7.2004','203','53');
INSERT INTO LITERATURA VALUES ('154','Vojna topografija udzbenik','5.11.2004','204','54');
INSERT INTO LITERATURA VALUES ('155','Vojna etika udzbenik','1.3.2005','205','55');
INSERT INTO LITERATURA VALUES ('156','Naoruzanje','12.4.2011','206','56');
INSERT INTO LITERATURA VALUES ('157','Teorija gadjanja','4.9.2011','207','57');
INSERT INTO LITERATURA VALUES ('158','Osnovi projektovanja raketa','9.12.2008','208','58');
INSERT INTO LITERATURA VALUES ('159','Rukovodjenje i komandovanje','10.7.2006','209','59');
INSERT INTO LITERATURA VALUES ('160','Vojna psihologija udzbenik','2.10.2003','210','60');

INSERT INTO KLASA VALUES ('137','500','1');
INSERT INTO KLASA VALUES ('138','400','2');
INSERT INTO KLASA VALUES ('139','500','3');
INSERT INTO KLASA VALUES ('140','400','4');
INSERT INTO KLASA VALUES ('141','400','5');
INSERT INTO KLASA VALUES ('142','500','6');
INSERT INTO KLASA VALUES ('143','500','7');
INSERT INTO KLASA VALUES ('144','350','8');


INSERT INTO RADNO_MESTO VALUES('301', 'Nacelnik');
INSERT INTO RADNO_MESTO VALUES('302', 'Nacelnik katedre');
INSERT INTO RADNO_MESTO VALUES('303', 'Profesor vojne topografije i geografije');
INSERT INTO RADNO_MESTO VALUES('304', 'Profesor matematike');
INSERT INTO RADNO_MESTO VALUES('305', 'Profesor fizickog');
INSERT INTO RADNO_MESTO VALUES('306', 'Profesor fizike');
INSERT INTO RADNO_MESTO VALUES('307', 'Dekant');
INSERT INTO RADNO_MESTO VALUES('308', 'Profesor za snabdevadevanje i odrzavanje');
INSERT INTO RADNO_MESTO VALUES('309', 'Profesor za saobracaj i transpot');
INSERT INTO RADNO_MESTO VALUES('310', 'Profesor opste logistike');
INSERT INTO RADNO_MESTO VALUES('311', 'Profesor za logistiku operacija');
INSERT INTO RADNO_MESTO VALUES('312', 'Menadzer logistike');

INSERT INTO ZAPOSLENI VALUES ('001','Bojan','Zrnic','0607970767029','100000.00',null,'6.7.1970',null,'100');
INSERT INTO ZAPOSLENI VALUES ('002','Nenad','Dimitrijevic','0409974768246','70000.00',null,'4.9.1974',null,'101');
INSERT INTO ZAPOSLENI VALUES ('003','Darko','Lukic','1806978567123','60000.00','5000.00','6.18.1978','001','103');
INSERT INTO ZAPOSLENI VALUES ('004','Nenad','Galjak','1206970467035','60000.00','4000.00','12.6.1970','001','103');
INSERT INTO ZAPOSLENI VALUES ('005','Zoran','Maksimovic','0310971264019','58000.00',null,'3.10.1971','001','105');
INSERT INTO ZAPOSLENI VALUES ('006','Ivana','Saric','1202975565068','58000.00',null,'2.12.1970','001','105');
INSERT INTO ZAPOSLENI VALUES ('007','Gordan','Majstorovic','0912977958127','57000.00','3000','9.12.1977','001','105');
INSERT INTO ZAPOSLENI VALUES ('008','Slavica','Nikcevic','0507980767029','57000.00',null,'7.5.1980','001','105');
INSERT INTO ZAPOSLENI VALUES ('009','Dragan','Trifkovic','0811972578027','70000.00',null,'11.8.1972','001','101');
INSERT INTO ZAPOSLENI VALUES ('010','Vlada','Sokolovic','1307974768144','56000.00','2500','7.13.1974','002','102');
INSERT INTO ZAPOSLENI VALUES ('011','Ilija','Milivojevic','0912975967038','56000.00','3000','12.9.1975','002','107');
INSERT INTO ZAPOSLENI VALUES ('012','Srdjan','Ljubojevic','0211971573026','57000.00','4000','11.2.1971','002','102');
INSERT INTO ZAPOSLENI VALUES ('013','Dragan','Pamucar','1705978627039','58000.00',null,'5.17.1978','002','102');
INSERT INTO ZAPOSLENI VALUES ('014','Milan','Mihajlovic','07097979767024','57000.00',null,'9.7.1979','002','103');
INSERT INTO ZAPOSLENI VALUES ('015','Igor','Epler','0312973565027','56000.00',null,'12.3.1973','002','102');
INSERT INTO ZAPOSLENI VALUES ('016','Milan','Mladenovic','2112975464025','59000.00','300','12.21.1975','002','102');

INSERT INTO ANGAZOVANJE VALUES ('1.21.2011',null,'301','001');
INSERT INTO ANGAZOVANJE VALUES ('7.16.2009',null,'302','002');
INSERT INTO ANGAZOVANJE VALUES ('2.3.2010','4.21.2015','303','003');
INSERT INTO ANGAZOVANJE VALUES ('5.21.2015',null,'303','004');
INSERT INTO ANGAZOVANJE VALUES ('12.4.2009','1.3.2014','304','005');
INSERT INTO ANGAZOVANJE VALUES ('1.17.2014',null,'304','006');
INSERT INTO ANGAZOVANJE VALUES ('10.2.2012',null,'305','007');
INSERT INTO ANGAZOVANJE VALUES ('4.23.2007',null,'306','008');
INSERT INTO ANGAZOVANJE VALUES ('6.16.2013',null,'307','009');
INSERT INTO ANGAZOVANJE VALUES ('5.23.2008','9.5.2014','308','010');
INSERT INTO ANGAZOVANJE VALUES ('10.1.2014',null,'308','011');
INSERT INTO ANGAZOVANJE VALUES ('2.1.2007','3.20.2012','309','012');
INSERT INTO ANGAZOVANJE VALUES ('4.12.2012',null,'309','013');
INSERT INTO ANGAZOVANJE VALUES ('7.23.2010',null,'310','014');
INSERT INTO ANGAZOVANJE VALUES ('10.4.2011',null,'311','015');
INSERT INTO ANGAZOVANJE VALUES ('1.25.2014',null,'312','016');

INSERT INTO OPREMA VALUES ('91','Oruzje');
INSERT INTO OPREMA VALUES ('92','Vozilo');
INSERT INTO OPREMA VALUES ('93','Vozilo');
INSERT INTO OPREMA VALUES ('94','Oruzje');
INSERT INTO OPREMA VALUES ('95','Vozilo');
INSERT INTO OPREMA VALUES ('96','Oruzje');
INSERT INTO OPREMA VALUES ('97','Vozilo');
INSERT INTO OPREMA VALUES ('98','Oruzje');

INSERT INTO KADETI VALUES ('501','Aleksandar','Peric','Muski','3','9.81','4.20.1997','142');
INSERT INTO KADETI VALUES ('502','Jovica','Nikolic','Muski','2','8.75','5.6.1998','143');
INSERT INTO KADETI VALUES ('503','Nevena','Ognjanovic','Zenski','3','9.33','12.10.1997','142');
INSERT INTO KADETI VALUES ('504','Petar','Jovanovic','Muski','1',null,'7.23.1999','144');
INSERT INTO KADETI VALUES ('505','Nikola','Simonovic','Muski','4','9.56','5.18.1996','141');
INSERT INTO KADETI VALUES ('506','Milena','Milenkovic','Zenski','2','8.75','4.1.1998','143');
INSERT INTO KADETI VALUES ('507','Stefana','Brkic','Zenski','3','9.81','11.13.1997','142');
INSERT INTO KADETI VALUES ('508','Jovana','Milijas','Zenski','4','8.15','3.24.1996','141');
INSERT INTO KADETI VALUES ('509','Nemanja','Stojadinovic','Muski','1',null,'9.7.1999','144');
INSERT INTO KADETI VALUES ('510','Mitar','Stevic','Muski','2','7.92','1.15.1998','143');

INSERT INTO UNIFORMA VALUES ('181','M');
INSERT INTO UNIFORMA VALUES ('182','L');
INSERT INTO UNIFORMA VALUES ('183','S');
INSERT INTO UNIFORMA VALUES ('184','L');
INSERT INTO UNIFORMA VALUES ('185','M');
INSERT INTO UNIFORMA VALUES ('186','S');
INSERT INTO UNIFORMA VALUES ('187','S');
INSERT INTO UNIFORMA VALUES ('188','S');
INSERT INTO UNIFORMA VALUES ('189','M');
INSERT INTO UNIFORMA VALUES ('190','L');

INSERT INTO ODGOVORNOST VALUES ('10.1.2015',null,'004','91');
INSERT INTO ODGOVORNOST VALUES ('2.1.2013',null,'013','92');
INSERT INTO ODGOVORNOST VALUES ('2.1.2013',null,'013','93');
INSERT INTO ODGOVORNOST VALUES ('10.1.2015',null,'004','94');
INSERT INTO ODGOVORNOST VALUES ('2.1.2013',null,'013','95');
INSERT INTO ODGOVORNOST VALUES ('10.1.2015',null,'004','96');
INSERT INTO ODGOVORNOST VALUES ('2.1.2013',null,'013','97');
INSERT INTO ODGOVORNOST VALUES ('10.1.2015',null,'004','98');

INSERT INTO ISPIT VALUES ('1.23.2019','Pismeno','201','504');
INSERT INTO ISPIT VALUES ('1.17.2019','Pismeno','202','509');
INSERT INTO ISPIT VALUES ('6.19.2019','Usmeno','203','504');
INSERT INTO ISPIT VALUES ('1.26.2019','Usmeno','205','502');
INSERT INTO ISPIT VALUES ('1.20.2019','Pismeno','206','506');
INSERT INTO ISPIT VALUES ('6.15.2019','Pismeno','208','510');
INSERT INTO ISPIT VALUES ('6.22.2019','Usmeno','209','507');
INSERT INTO ISPIT VALUES ('1.14.2019','Usmeno','210','501');

INSERT INTO BORAVAK VALUES ('10.1.2018','15','504');
INSERT INTO BORAVAK VALUES ('10.1.2017','18','502');
INSERT INTO BORAVAK VALUES ('10.1.2017','21','506');
INSERT INTO BORAVAK VALUES ('10.1.2016','24','503');
INSERT INTO BORAVAK VALUES ('10.1.2016','28','501');
INSERT INTO BORAVAK VALUES ('10.1.2015','32','505');

INSERT INTO ZADUZENJE VALUES ('10.3.2016','501','181');
INSERT INTO ZADUZENJE VALUES ('10.3.2017','502','182');
INSERT INTO ZADUZENJE VALUES ('10.3.2016','503','183');
INSERT INTO ZADUZENJE VALUES ('10.3.2018','504','184');
INSERT INTO ZADUZENJE VALUES ('10.3.2015','505','185');
INSERT INTO ZADUZENJE VALUES ('10.3.2017','506','186');
INSERT INTO ZADUZENJE VALUES ('10.3.2016','507','187');
INSERT INTO ZADUZENJE VALUES ('10.3.2015','508','188');
INSERT INTO ZADUZENJE VALUES ('10.3.2018','509','189');
INSERT INTO ZADUZENJE VALUES ('10.3.2017','510','190');

INSERT INTO INDEKS VALUES ('13116','24','501');
INSERT INTO INDEKS VALUES ('4517','16','502');
INSERT INTO INDEKS VALUES ('10716','22','503');
INSERT INTO INDEKS VALUES ('7718','4','504');
INSERT INTO INDEKS VALUES ('8415','32','505');
INSERT INTO INDEKS VALUES ('6117','18','506');
INSERT INTO INDEKS VALUES ('9316','25','507');
INSERT INTO INDEKS VALUES ('7615','33','508');
INSERT INTO INDEKS VALUES ('10218','2','509');
INSERT INTO INDEKS VALUES ('9017','17','510');

INSERT INTO ORUZJE VALUES ('91','KalasnjikovAK','41');
INSERT INTO ORUZJE VALUES ('94','PistoljGPDA','9');
INSERT INTO ORUZJE VALUES ('96','SnajperVSR','10');
INSERT INTO ORUZJE VALUES ('98','MitraljezM','84');

INSERT INTO MOTORNA_VOZILA VALUES ('92','AvionLastaB','54');
INSERT INTO MOTORNA_VOZILA VALUES ('93','AvionUTV','75');
INSERT INTO MOTORNA_VOZILA VALUES ('95','TenkM','84');
INSERT INTO MOTORNA_VOZILA VALUES ('97','DzipZastavaAR','55');

go 

create view pogled_zaposleni 
as
select 
z.ZaposleniID, z.Ime as 'Ime', z.Prezime as 'Prezime', c.NazivCina as 'Cin', rm.NazivRM as 'RadnoMesto',
z.Plata as 'Plata', a.DatOd as 'PocetakAngazovanja'
from ZAPOSLENI as z join CIN as c on z.SifraCina=c.SifraCina
join ANGAZOVANJE as a on a.ZaposleniID=z.ZaposleniID
join RADNO_MESTO as rm on rm.SifraRM=a.SifraRM;

go

create view pogled_kadeti
as
select
k.SifraKadeta, i.BrojIndeksa as 'BrIndeksa', k.ImeKadeta as 'Ime', k.PrezimeKadeta as 'Prezime',
kl.KlasaID as 'Klasa', sp.NazivSmera as 'Smer', k.GodinaStudija as 'Godina', k.Prosek as 'Prosek'
from KADETI as k join INDEKS as i on k.SifraKadeta=i.SifraKadeta 
join KLASA as kl on kl.KlasaID=k.KlasaID
join STUDIJSKI_PROGRAM as sp on sp.SmerID=kl.SmerID


go

create function dbo.udfPodPukovnik (@SifCina as int)
returns table
as 
return
(select z.ZaposleniID, z.Ime as Ime, z.Prezime as Prezime, c.NazivCina as Cin, rm.NazivRM as RadnoMesto,
a.DatOd as Angazovanje, z.Plata as Plata
from ZAPOSLENI as z join CIN as c on z.SifraCina=c.SifraCina
join ANGAZOVANJE as a on z.ZaposleniID=a.ZaposleniID
join RADNO_MESTO as rm on a.SifraRM=rm.SifraRM
where MONTH(a.DatOd) in (1,5,10) and c.SifraCina=@SifCina);

go
create function dbo.udfOdlicanProsekCetvrtaGodina (@BrojKlase as int)
returns table
as
return
(select k.ImeKadeta as Ime, k.PrezimeKadeta as Prezime, i.BrojIndeksa as Indeks, 
sp.NazivSmera as Smer, kl.KlasaID as Klasa, k.Prosek as Prosek
from KADETI as k join INDEKS as i on k.SifraKadeta=i.SifraKadeta
join KLASA as kl on k.KlasaID=kl.KlasaID
join STUDIJSKI_PROGRAM as sp on kl.SmerID=sp.SmerID
where k.Prosek > 9 and kl.KlasaID=@BrojKlase);


go
create procedure dbo.uspPovecajPlatuPotpukovnicima
@procenatPovecanja as numeric(6,2), @sifCina as int
as declare @tipgreske as varchar(30) = ''
set xact_abort on;
begin try
	begin transaction
		if @procenatPovecanja < 0 OR @procenatPovecanja > 100
		begin
		set @tipgreske = 'Uneti procenat mora biti izmedju 0 i 100, '
		+ ' a unet je > ' + CAST(@procenatPovecanja as varchar(10));
		select 1/0;
		end;
		set @tipgreske = 'UPDATE procenat plate u tabeli Zaposleni ';

		UPDATE ZAPOSLENI
		set plata = plata + (plata * (@procenatPovecanja / 100))
		where ZaposleniID in (select ZaposleniID from dbo.udfPodPukovnik(@sifCina))
		commit transaction;
end try

begin catch
	print 'DOSLO JE DO GRESKE!';
	print @tipgreske;
	print 'Transakcija se nije vratila u predjasnje stanje';
	select @tipgreske as 'Naziv greske', @procenatPovecanja as 'Procenat povecanja',
	@sifCina as 'Sifra cina';

	rollback transaction;
end catch;

go
create procedure dbo.UbaciRadnika
@ime varchar(20), @prezime varchar(20), @jmbg numeric(18,0), @datumRodjenja date, @SifraCina int
as
declare @sifraZap int, @greska varchar(20)
begin try
begin transaction 
if @SifraCina not in ('102', '103', '104', '105', '106', '107')
begin
set @greska = 'Cin mora biti Potpukovnik, Major, Kapetan, Porucnik, Potporucnik ili Zastavnik'
select 1/0;
end;
set @greska = 'TEST'
select @sifraZap = MAX(z.ZaposleniID)+1
from ZAPOSLENI as z;
insert ZAPOSLENI (ZaposleniID, Ime, Prezime, JMBG, DatumRodjenja, SifraCina)
values (@sifraZap, @ime, @prezime, @jmbg, @datumRodjenja, @SifraCina);
select * 
from ZAPOSLENI
where @sifraZap = ZaposleniID

commit transaction
end try
begin catch
	print 'GRESKA!'
	print @greska
	rollback transaction
end catch;

go

create procedure dbo.udfUbaciStudenta 
@ime varchar (20), @prezime varchar (20), @pol varchar (5), @Godina int, @DatumRodjenja date, @klasa int
as 
declare @SifKadeta int, @Greskaa varchar (20)
begin try
begin transaction
if @klasa not in ('137','138','139','140','141','142','143','144')
begin
set @Greskaa='Ponovi proces!'
select 1/0;
end;
set @Greskaa='Proba'
select @SifKadeta=MAX(k.SifraKadeta)+1
from KADETI as k;
insert into KADETI (SifraKadeta, ImeKadeta, PrezimeKadeta, Pol, GodinaStudija, Rodjendan, KlasaID)
values (@SifKadeta, @ime, @prezime, @pol, @Godina, @DatumRodjenja, @klasa);
select *
from KADETI
where @SifKadeta=SifraKadeta

commit transaction 
end try
begin catch
print 'Greska'
print @Greskaa
rollback transaction
end catch;

go
create procedure dbo.uspPolozeniIspiti
@polozeno int, @sifraKad as int
as declare @tipgreske as varchar(30) = ''
set xact_abort on;
begin try
	begin transaction
		if @polozeno < 0 OR @polozeno > 10
		begin
		set @tipgreske = 'broj polozenih ispita mora biti izmedju 0 i 10, '
		+ ' a unet je > ' + CAST(@polozeno as int);
		select 1/0;
		end;
		set @tipgreske = 'UPDATE broj polozenih ispita u tabeli Indeks ';

		UPDATE INDEKS
		set BrPolozenihIspita=BrPolozenihIspita+@polozeno
		commit transaction;
end try

begin catch
	print 'DOSLO JE DO GRESKE!';
	print @tipgreske;
	print 'Transakcija se nije vratila u predjasnje stanje';
	select @tipgreske as 'Naziv greske', @polozeno as 'Polozeno',
	@sifraKad as 'Sifra kadeta';

	rollback transaction;
end catch;

go

SELECT SifraKadeta, BrojIndeksa, BrPolozenihIspita from INDEKS ('502');
exec dbo.uspPolozeniIspiti @polozeno = '3', @sifraKad = '502';


	

	









	

