ALTER DATABASE ksmppd CHARACTER SET utf8 COLLATE utf8_unicode_ci;
grant all privileges on ksmppd.* to 'ksmppduser'@'localhost' identified by 'ksmppdpass';
grant all privileges on ksmppd.* to 'ksmppduser'@'%' identified by 'ksmppdpass';
