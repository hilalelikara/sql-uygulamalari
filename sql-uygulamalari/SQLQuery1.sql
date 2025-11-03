CREATE DATABASE testDB

use testDB

CREATE table Musteriler (
Musteri_id int PRIMARY key not null ,
adi nVARCHAR(50) not NULL,
sadi nVARCHAR(60) not NULL,
yas int
)


CREATE table Musteriler1 (
Musteri_id int PRIMARY key not null ,
adi nVARCHAR(50) not NULL,
sadi nVARCHAR(60) not NULL,
yas int CONSTRAINT yas_notnull NOT NULL
)
Alter TABLE Musteriler1 Alter COLUMN yas int NULL
 

 CREATE table Urunler(
 UrunId INT PRIMARY KEY,
 UrunAdi NVARCHAR(100) CONSTRAINT Urun_Unique UNIQUE (UrunID)
 )


 ALTER TABLE Urunler drop CONSTRAINT Urun_Unique