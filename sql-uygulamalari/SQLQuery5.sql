--LTRIM ve RTRIMM kullanýmý 

select '      HÝLAL ELÝKARA', LTRIM('      HÝLAL ELÝKARA')

select 'HÝLAL ELÝKARA       ',    RTRIM('HÝLAL ELÝKARA          ')

use isyeri 
SELECT  ad, len(ad) as'isim karakter uzunluðu',soyad,len(soyad) as'soyad karakter uzunluðu' 
from personel

SELECT REPLACE ('Galatasaray þampiyon olacak Galatasaray Galatasaray','Galatasaray','Fenerbahçe')



SELECT abs(5)
select abs(-1.34)


SELECT POWER (3,4)
select sqrt(121)

select sqrt(85)

SELECT round (2.5,0)
SELECT round(3.47,1)
select round(5.43,1)

select FLOOR (2.5)
select floor(6.56)


SELECT CEILING (11.45)


SELECT SUM (maas) from personel



--dönüþüm fonksiyonlarý
SELECT CAST ('Mehmet Akif Ersoy Üniversitesi' as nvarchar (9))
Select CONVERT(int,5.786)

--birim numarasý 3 olan personellerin toplam maaþýný listeleyiniz
use isyeri
SELECT sum(maas) from personel where birim_no=3

--soyadý farklý olan kaç personel vardýr

SELECT count(distinct soyad)
from personel


--group by!!!
--amaç: bir sütuna göre verileri gruplandýrmak
/*
select kolon kodlarý
from tablo veya tablolarýn adlarý
where koþul
group by kolon adlarý
having koþul
order by
*/

--ilçe tablosunda her ilin kaç ilçesi olduðunu listeleyelim

SELECT il_no,COUNT(ilce_no)
from ilce GROUP by il_no


SELECT cinsiyet,COUNT(cinsiyet)
from personel
GROUP by cinsiyet


--birimlerde çalýþan personel sayýlarý ve her birime ödenen toplam maaþý listeleyiniz.

SELECT birim_no,Count* as 'birim bazýndaki personel sayýsý',sum(maas) as 'toplam maaþ'
from personel
GROUP by birim_no



--having nedir?

--amaç: gruplanmýþ sonuçlara þart koymak
--yani where gibi çalýþýlýr ama gruplar üzerinde þart uygulanýr


--maaþý 3000 tl den fazla olan personeller arasýndan her departmanýn toplam maaþýný listeleyiniz ve sadece toplam maaþý 1500 den fazla olan departmanlarý getiriniz

SELECT birim_no ,sum(maas)
from personel 
where maas>3000
GROUP by birim_no
HAVING sum(maas)>15000




--maaþ toplamý 25000 üzerinde olan birimleri ve personel sayýlarýný listeleyiniz.

SELECT birim_no,COUNT(*)
from personel
GROUP by birim_no
HAVING sum(maas)>25000


--unvana göre toplam prim miktarýný listeleyen sorgu

SELECT unvan_no,sum(prim)
from personel
GROUP by unvan_no


--birimlerin ortalama çalýþma saatlerini listeleyiniz
SELECT birim_no,avg(calisma_saati)
from personel
GROUP by birim_no


--cinsiyete göre toplam maaþ,toplam prim ve ortalama çalýþma süresi
--büyükten küçüðe listeleyiniz

SELECT cinsiyet , sum(maas),sum(prim),avg(calisma_saati)
from personel  GROUP by cinsiyet
ORDER by cinsiyet desc


-- maaþý 3000 den fazla olan personelin birimlere göre sayýlarýný büyükten küçüðe listeleyiniz.
Select birim_no,COUNT(*) as [Personel Sayisi]
from personel
Where maas>3000
GROUP  by birim_no
ORDER by [Personel Sayisi] desc --personel sayisi yazmadan count* yazýnca da olur.


---1,2,3 numaralý projelerde görevlendirilen personel sayýsýný büyükten küçüðe listeleyiniz.
SELECT proje_no, COUNT(*)
from gorevlendirme
where proje_no in (1,2,3)
GROUP by proje_no
ORDER bt COUNT (*) desc


--birden fazla tablo üzerinden sorgulama

-- birim numarasý 3 olan personelin adý soyadý ve maaþýný listeleyiniz

SELECT pr.ad,pr.soyad,pr.maas,.br.birim_no
from 
personel as pr , birim as br 
where pr.birim_no=br.birim_no and br.birim_no=3



--hangi personel hangi birimde çalýþýyor listeleyiniz(2 tablodan çekiniz)
SELECT pr.ad,pr.soyad,br.birim_ad
from personel as pr,birim as br
WHERE pr.birim_no=br.birim_no


--birim adý kalýte olan  personelin ad soyad birim adýný listeleyin
SELECT pr.ad,pr.soyad,br.birim_ad
from personel as pr,birim as br
WHERE  pr.birim_no=br.birim_no and br.birim_ad='KALITE'



--Buca da doðan personelin adý soyadý listeleyiniz

SELECT pr.ad,pr.soyad,i.ilce_ad,il.il_ad
from
personel pr, ilce i,il 
where pr.dogum_yeri=i.ilce_no
and i.ilce_ad='BUCA'
and i.il_no=il.il_no


--çankaya ilçesinde doðan kadýn personelleri listeleyiniz

SELECT pr.ad,pr.soyad,i.ilce_ad,il.il_ad,pr.cinsiyet
from
personel pr, ilce i,il 
where pr.dogum_yeri=i.ilce_no
and i.ilce_ad='Cankaya'
and pr.cinsiyet='K'





--unvaný mühendis olan personeller
SELECT pr.ad,pr.soyad,u.unvan_ad
FROM personel as pr,unvan as u
WHERE pr.unvan_no =u.unvan_no
and u.unvan_ad='MÝHENDÝS'


--izmirde doðanlarýn listesi
SELECT pr.ad,pr.soyad,i.ilce_ad
from
personel as pr,ilce as i ,il
where pr.dogum_yeri=i.ilce_no
and il.il_no=i.il_no
and il.il_Ad='izmir'
   

--her ilçenin adýyla birlikte baðlý olduðu ilin adýný listele
SELECT i.ilce_ad, il.il_ad
      
FROM ilce as i,il
where i.il_no=il.il_no




--2015 yýlýndan önce doðan çocuklarýn adlarýný ve ebeveyn(personel) adýný listele
SELECT c.ad ,c.soyad,c.dogum_tarihi,pr.ad,pr.soyad
    
FROM cocuk c, personel pr
WHERE c.personel_no = pr.personel_no
  AND c.dogum_tarihi < '2015'




-- adý ömer buzdaðý olan personelin çocuklarýnýn adlarýný listele
SELECT c.ad AS cocuk_ad
FROM cocuk c,personel pr
Where c.personel_no=p.personel_no
and p.ad='Ömer'and p.soyad='buzdagý'


--sadece çocuk sahibi olan personelleri listele
SELECT c.ad as cocuk_Ad,c.soyad,p.ad,p.soyad,
from cocuk c,personel p
where c.personel_no=p.personel_no