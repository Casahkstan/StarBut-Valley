program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	playerUnit, inventoryUnit, dateUnit;

var
	champ : itemType;
begin 
	initPlayer();
	setName('Sacha');
	champ.name := 'Champignon';
	champ.rarete := Rarity.base;
	champ.saison := 3;
	AddInventory(champ, 2);
	AddInventory(champ, 2);
	displayInventory();
	readln;
end.