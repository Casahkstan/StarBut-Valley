unit shopPierre;

{$mode objfpc}{$H+}

interface
uses inventoryUnit, SeedUnit;
type
	shop = array[0..3] of itemType;
  
implementation

procedure acheter(choix : Integer);
var
	produit : itemType;
	money : Integer
begin
	produit := getSeed()[choix];
	money := getMoney;
	if money > produit.prix then
	begin
		if isPresent(produit) and isStackAvailable(produit) or isNotFull then
		begin
			money := money - produit.prix;
			AddInventory(produit, 1);
		end
	else
		writeln('Inventaire plein');
	end
else
	writeln('Pas assez d''argent');
end;

procedure vendre();
var
	inv : inventory;
	nbVente,
	money,
	prix : Integer;
	choix : Integer
begin
	writeln('Que voulez vous vendre ? (entrer le numéro de l''objet a vendre)');
	displayInventory();
	readln(choix);
	inv := getInventory;
	if inv[choix].iType.name := 'Vide' then
	begin
		writeln('Impossible de vendre ceci !');
	end
	else
	begin
		prix := inv[choix].iType.prix;
		repeat
			writeln('Combien souhaitez vous en vendre, max ', getNombreOccu(inv[choix].iType));
			writeln(nbVente)
		until (nbVente <= getNombreOccu(inv[choix].iType));
		SubInventory(inv[choix].iType, nbVente);
		money := getMoney;
		money := money + prix*nbVente;
		setMoney(money)
		writeln('Vente terminée');
	end;
end;

end.