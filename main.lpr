program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	StarBUTValleyIHM, StarBUTlogic, weatherUnit, dateUnit, SeedManagmentUnit, SeedUnit, playerUnit;

var
	i : Integer;
begin 
	Initpartie();
	for i:=0 to 100 do
	begin
		writeln(getFutureWeather);
		jourSuivant;
	end;
end.