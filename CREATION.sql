﻿IF DB_ID('GAMES_SALES_PLATFORM') IS NOT NULL
	BEGIN
		ALTER DATABASE [GAMES_SALES_PLATFORM] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE master
		DROP DATABASE GAMES_SALES_PLATFORM
	END
GO

CREATE DATABASE GAMES_SALES_PLATFORM
	ON PRIMARY	(
					NAME = 'GAMES_SALES_PLATFORM_DB',
					FILENAME = 'C:\database\GAMES_SALES_PLATFORM.mdf',
					SIZE = 5MB,
					MAXSIZE = 100MB,
					FILEGROWTH = 5MB
				)
	LOG ON		(
					NAME = 'GAMES_SALES_PLATFORM_DB_LOG',
					FILENAME = 'C:\database\GAMES_SALES_PLATFORM.ldf',
					SIZE = 2MB,
					MAXSIZE = 50MB,
					FILEGROWTH = 1MB
				)
GO

USE GAMES_SALES_PLATFORM
CREATE TABLE KULLANICI
(
	KULLANICI_ID INT NOT NULL IDENTITY PRIMARY KEY ,
	ADI VARCHAR(30),
	EMAIL VARCHAR(50),
	SIFRE VARCHAR(50),
	FOTOGRAF VARCHAR(50),
	BAKIYE INT
);

CREATE TABLE YAYIMCI
(
	YAYIMCI_ID INT NOT NULL IDENTITY PRIMARY KEY,
	EMAIL VARCHAR(50),
	ADI VARCHAR(30),
	KURULUS_TARIHI DATE,
	WEBSITE VARCHAR(50),
	FOTOGRAF VARCHAR(50)
);

CREATE TABLE YAPIMCI
(
	YAPIMCI_ID INT NOT NULL IDENTITY PRIMARY KEY,
	EMAIL VARCHAR(50),
	ADI VARCHAR(30),
	KURULUS_TARIHI DATE,
	WEBSITE VARCHAR(50),
	FOTOGRAF VARCHAR(50)
);

CREATE TABLE BUNDLE
(
	BUNDLE_ID INT NOT NULL IDENTITY PRIMARY KEY,
	ADI VARCHAR(30),
	FIYAT SMALLMONEY
);

CREATE TABLE OYUN
(
	OYUN_ID INT NOT NULL IDENTITY PRIMARY KEY,
	ADI VARCHAR(50),
	BUNDLE_ID INT FOREIGN KEY REFERENCES BUNDLE(BUNDLE_ID) DEFAULT NULL,
	YAPIMCI_ID INT FOREIGN KEY REFERENCES YAPIMCI(YAPIMCI_ID),
	YAYIMCI_ID INT FOREIGN KEY REFERENCES YAYIMCI(YAYIMCI_ID),
	FIYAT SMALLMONEY,
	FOTOGRAF VARCHAR(50)
	
);

CREATE TABLE ANAHTAR
(
	ANAHTAR_ID INT NOT NULL IDENTITY PRIMARY KEY,
	KULLANICI_ID INT FOREIGN KEY REFERENCES KULLANICI(KULLANICI_ID),
	OYUN_ID INT FOREIGN KEY REFERENCES OYUN(OYUN_ID)
);

CREATE TABLE ODEMETURU
(
	ODEME_ID INT NOT NULL IDENTITY PRIMARY KEY,
	ADI VARCHAR(30),
);

CREATE TABLE TAHSILAT
(
	TAHSILAT_ID INT NOT NULL IDENTITY PRIMARY KEY,

	/* OPSIYONEL */
	KULLANICI_ADI VARCHAR(30),
	SON_KULLANMA_TARIHI DATE DEFAULT NULL,
	GUVENLIK_KODU INT DEFAULT NULL,
	KART_NO NUMERIC DEFAULT NULL,
	/* OPSIYONEL */
	ODEME_ID INT FOREIGN KEY REFERENCES ODEMETURU(ODEME_ID)
);

 CREATE TABLE FATURA
(
	FATURA_NO INT NOT NULL IDENTITY PRIMARY KEY,
	TUTAR SMALLMONEY,
	TARIH DATE,
	KULLANICI_ID INT FOREIGN KEY REFERENCES KULLANICI(KULLANICI_ID)
);

CREATE TABLE BASARIMLAR
(
	BASARIM_ID INT NOT NULL IDENTITY PRIMARY KEY,
	ADI VARCHAR(30),
	OYUN_ID INT FOREIGN KEY REFERENCES OYUN(OYUN_ID)
);

CREATE TABLE KAZANIR
(
	KULLANICI_ID INT FOREIGN KEY REFERENCES KULLANICI(KULLANICI_ID),
	BASARIM_ID INT FOREIGN KEY REFERENCES BASARIMLAR(BASARIM_ID),
	TARIH DATE,
	PRIMARY KEY(KULLANICI_ID, BASARIM_ID)
);

CREATE TABLE YORUMYAPAR
(
	YORUM_ID INT NOT NULL,
	METIN VARCHAR(100),
	BEGEN INT,
	BEGENMEME INT,
	KULLANICI_ID INT FOREIGN KEY REFERENCES KULLANICI(KULLANICI_ID),
	OYUN_ID INT FOREIGN KEY REFERENCES OYUN(OYUN_ID),
	TARIH DATE,
	TUR BIT ,
	PRIMARY KEY(YORUM_ID, KULLANICI_ID, OYUN_ID)
);

CREATE TABLE ODULLER
(
	ODUL_ID INT NOT NULL IDENTITY PRIMARY KEY,
	ADI VARCHAR(30),
	TARIH DATE,
	OYUN_ID INT FOREIGN KEY REFERENCES OYUN(OYUN_ID)
);

CREATE TABLE KATEGORILER
(
	KATEGORI_ID INT NOT NULL IDENTITY PRIMARY KEY,
	TUR VARCHAR(30)
);

CREATE TABLE ICERIR
(
	OYUN_ID INT FOREIGN KEY REFERENCES OYUN(OYUN_ID),
	KATEGORI_ID INT FOREIGN KEY REFERENCES KATEGORILER(KATEGORI_ID),
	PRIMARY KEY(OYUN_ID, KATEGORI_ID)
);