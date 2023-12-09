program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	inventoryUnit, playerUnit;
var
	champ : itemType;
	i : Integer;
begin 
	initPlayer;
	champ.name := 'Champignon';
	champ.rarete := base;
	champ.saison := 0;
	champ.prix := 2;
	champ.maturite := 3;
	champ.legume := true;
	for i:=0 to 8 do
	begin
		AddInventory(champ, 1);
		displayInventory;
	end;
end.