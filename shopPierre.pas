unit shopPierre;

{$mode objfpc}{$H+}

interface
uses inventoryUnit, SeedUnit;
type
	shop = array[0..3] of itemType;

function getShop() : shop;
  
implementation
  
function getShop() : shop;
var
	i : itemType;
	grainesDispo : array[0..3] of itemType;
begin
	grainesDispo := getSeed();
	for i in grainesDispo do
		writeln(i.name, ' ', i.rarete, ' ', i.prix);
end;
end.