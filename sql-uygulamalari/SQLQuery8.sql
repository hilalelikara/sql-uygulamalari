use kooperatif


--inner join
SELECT u.UYE_ADI,u.UYE_SOYADI,u.UYE_SEHIR,a.AIDAT_AY,a.AIDAT_DURUMADI,a.AIDAT_TUTAR
from UYE u
inner join AIDAT a
on u.UYE_ID=a.AIDAT_UYE_ID


SELECT *
from
INSAAT i
INNER JOIN UYE u
on i.INSAAT_ID=u.UYE_INSAAT_ID



--LEFT JOIN
use isyeri
SELECT pr.ad,pr.soyad,pr.unvan_no,gr.proje_no,gr.gorevlendirme_no
from personel pr
left join gorevlendirme gr
on pr.personel_no=gr.personel_no

Select pr.ad,pr.soyad,c.ad,c.soyad,c.dogum_tarihi
from personel pr
left join cocuk c
on pr.personel_no=c.personel_no


select *
from personel pr
left join ilce i
on pr.dogum_yeri=i.ilce_no


--hangi projede hangi personel çalýþýyor

select p.proje_no,p.proje_ad,gr.personel_no,pp.ad,pp.soyad
from
proje p
left join gorevlendirme gr
on p.proje_no= gr.proje_no
left join personel pp
on pp.personel_no=gr.personel_no


--o unvana sahip personelin adý soyadý maaþý 

select pr.ad,pr.soyad,pr.maas,u.unvan_ad
from personel pr
left join unvan u 
on pr.unvan_no = u.unvan_no


--right join

select pr.ad,pr.soyad,pr.maas,u.unvan_ad
from personel pr
right join unvan u
on u.unvan_no=pr.unvan_no

select il.il_Ad,il.il_no,ilce.ilce_ad
from 
il 
right join ilce
on il.il_no=ilce.il_no

--personele ait çocuklar

SELECT c.ad,c.soyad,c.dogum_tarihi,pr.ad,pr.soyad
from cocuk c 
right join personel pr
on c.personel_no=pr.personel_no



--full outer join

select pr.ad,pr.soyad,gr.gorevlendirme_no,gr.proje_no
from 
personel pr
FULL JOIN gorevlendirme gr 
on pr.personel_no=gr.personel_no

select pr.ad,pr.soyad,gr.gorevlendirme_no,gr.proje_no
from 
personel pr
inner JOIN gorevlendirme gr 
on pr.personel_no=gr.personel_no


--cross join 

create database restoran

use restoran

Create table Yemekler (
YemekAdi VARCHAR (100)
)
create table Icecek(
Icecek_Adi varchar(100)
)

INSERT into Icecek  VALUES ('Portakal Suyu'),('Çay'),('Kahve')

INSERT into Yemekler VALUES ('Beyti'),('Tandýr Kebabý'),('Enginar')

SELECT *
from Yemekler 
CROSS join Icecek


--ortak sütun bulunmayan birleþtirme
 use isyeri

 --maaþý 1000 ile 3000 arasýndaki personelin çalýþtýðý projeleri listele
 SELECT  personel.ad,personel.soyad,personel.unvan_no,proje.proje_ad,personel.maas,
 proje.baslama_tarihi,proje.planlanan_bitis_tarihi
 from 
 personel
 join proje 
 on personel.maas BETWEEN 1000 and 3000


 SELECT  pr.ad,pr.soyad,u.unvan_ad,pr.calisma_saati
 from 
 personel pr 
 join unvan u
 on pr.personel_no between 1 and 3



 --1.tip subquery (where den sonra alt sorgu) en yüksek maaþlý kiþi

 use isyeri

 select p.ad,p.soyad,p.unvan_no,p.birim_no,p.maas
 from personel p
 where p.maas=(
 select max(maas) from personel
 )

 --ort maaþ üzerinde olanlar birimlerin listesi birim bazýnda
  select personel.birim_no,avg(maas) as 'ortalama'
  from personel 
  where personel.maas>
  (select avg(maas)from personel)
  Group by personel.birim_no