CREATE USER dashboard IDENTIFIED BY 'p~bUYk@-fJ>4e7;{s}x@';
FLUSH PRIVILEGES;

GRANT SELECT 
	ON weatherdailydelay
	TO dashboard;
GRANT SELECT 
	ON weatherdailydelay_rainfallinranges
	TO dashboard;
GRANT SELECT 
	ON weatherdailydelay_snowfallinranges
	TO dashboard;