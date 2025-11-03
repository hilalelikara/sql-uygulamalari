use isyeri

--after trigger kullanýmý--

--Örnek1:
-- Yeni bir proje eklendiðinde log tablosuna kayýt düþsün

create table proje_log(

log_id int PRIMARY key Identity (1,1),
proje_no int,
proje_ad varchar(50),
eklenme_tarihi DATETIME DEFAULT GETDATE()
)

--trigger

Create TRIGGER trg_ProjeEklemeLog
on proje

after insert 

as 
begin

insert into proje_log(proje_no,proje_ad)

select proje_no,proje_ad from inserted

end



--çalýþtýrmak için

insert into proje(proje_ad,baslama_tarihi,planlanan_bitis_tarihi)
values('Srdrleblr Enerji','2025-05-01','2027-01-01')



--Örnek 2:


--after trigger ilçe eklendiðinde þehir bilgisiyle beraber logla


create table ilce_log(

log_id int IDENTITY (1,1) PRIMARY key,
ilce_Ad varchar(50),
il_Ad varchar(80),
eklenme_tarihi DATETIME DEFAULT GETDATE())


--trigger
create trigger trg_IlceEklemeLog
on ilce

after insert 

as
begin

	INSERT into ilce_log(ilce_ad,il_ad)

	select ilce_ad,il_ad from inserted i
	
	inner join il on il.il_no=i.il_no

end


--çalýþtýrmak için

insert into ilce(ilce_ad,il_no) values ('Altýndað','06')




--Örnek 3:

--yeni bir çocuk eklendiðinde personel tabosundaki çalýþma saatini güncelleyen tetikleyici

CREATE trigger trg_update_calisma_saati_add_cocuk 
on cocuk

after insert

as
begin

Update p
set p.calisma_saati=p.calisma_saati-2
from
personel p

--sanal tablodan çekme kýsmý
inner join inserted i
on i.personel_no=p.personel_no

end


--çalýþtýrmak için

insert into cocuk(ad,soyad,cinsiyet,dogum_tarihi,dogu_yeri,personel_no)
values ('Aylin','Çakýr','K','2025-05-01',5,19)



--instead of trigger


--örnek 4:
--birim silinmesin onun yerine pasif_ ön eki gelsin

create trigger trg_BirimInsteadOfDelete
on birim

Instead of delete 
as
begin

update b
set b.birim_ad='Pasif_'+b.birim_ad
from birim b
inner join deleted d
on d.birim_no=b.birim_no
end

--çalýþtýrmak için
delete from birim where birim_ad='KALITE'


--Örnek 5:

--instead of unvan

create trigger trg_UnvanBuyukHarfEkle
on unvan

instead of insert 

as begin

insert into unvan(unvan_ad)
select upper(unvan_ad) from inserted

end


--çalýþtýrmak için 
insert into unvan(unvan_ad) values ('ast.teð.')


--Örnek 6:
--instead of delete
--þehir silinmesin sadece adýnýn sonuna _silindi eklensin

Create trigger trg_ÝlInsteadOfDelete

on il

Instead of DELETE 

as begin

Update il
set il.il_ad=il.il_ad+'_silindi'
from deleted d
where d.il_no=il.il_no
end


--çalýþtýrmak için 

delete from il where il_ad='Istanbul'


--örnek 7:

create table personel_log(
personel_no int PRIMARY key not null,
ad nvarchar(50),
soyad nvarchar(100),
cinsiyet char(1),
dogum_tarihi DATE,
dogum_yeri int ,
baslama_tarihi DATE,
birim_no int ,
unvan_no int ,
calisma_saati int,
maas money,
prim money
)

--trigger kýsmý

create trigger delete_personel
on personel
instead of delete 
as
begin

insert into personel_log(personel_no,ad,soyad,cinsiyet,dogum_tarihi,dogum_yeri,baslama_tarihi,birim_no,unvan_no,calisma_saati,maas,prim)

select*from deleted 

delete from gorevlendirme
where personel_no=(select personel_no from deleted)


delete from cocuk
where personel_no =(select personel_no from deleted)

delete from personel 
where personel_no =(select personel_no from deleted)

end

--çalýþtýrmak için

delete from personel where personel_no=19 


