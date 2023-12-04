program main;
{$codepage utf8}
{$mode objfpc}{$H+}
uses
	playerUnit, inventoryUnit;

begin 
	initPlayer();
	setName('Sacha');
	AddInventory('Champignon', 4);
	AddInventory('Champignon', 4);
	SubInventory('Champignon', 3);
	displayInventory();
end.