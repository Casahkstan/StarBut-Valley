program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	playerUnit, inventoryUnit;

var
	champ2,
	champ : itemType;
begin 
	initPlayer();
	setName('Sacha');
	champ.name := 'Champignon';
	champ.rarete := Rarity.base;
	champ2.name := 'Champignon';
	champ2.rarete := Rarity.base;
	AddInventory(champ, 2);
	AddInventory(champ2, 4);
	SubInventory(champ, 3);
	SubInventory(champ, 2);
	displayInventory();
end.