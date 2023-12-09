program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	SeedManagmentUnit, SeedUnit, playerUnit, inventoryUnit, dateUnit;

var
	champ : itemType;
begin 
	initGarden;
	initPlayer;
	champ.legume := False;
	champ.maturite := 5;
	champ.name := 'Champignon';
	champ.prix := 5;
	champ.rarete := base;
	champ.saison := 0;
	AddSeed(1, champ);
	saisonSuivante;
	writeln(getFerme[1].elem.name);
end.