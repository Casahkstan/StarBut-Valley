unit shopPierre;

{$mode objfpc}{$H+}

interface
uses inventoryUnit, SeedUnit,playerUnit;
type
	shop = array[0..3] of itemType;
  
procedure acheter(choix : Integer);
procedure vendre();

implementation
var
	magasin : shop;

procedure acheter(choix : Integer);
var
	produit : shop;
	money : Integer;
begin
	produit := getSeed();
	money := getMoney();
	if money > produit[choix].prix then
	begin
		if isPresent(produit[choix]) and isStackAvailable(produit[choix]) or isNotFull then
		begin
			money := money - produit[choix].prix;
			AddInventory(produit[choix], 1);
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
	choix : Integer;
begin
	writeln('Que voulez vous vendre ? (entrer le numéro de l''objet a vendre)');
	displayInventory();
	readln(choix);
	inv := getInventory;
	if inv[choix].iType.name = 'Vide' then
	begin
		writeln('Impossible de vendre ceci !');
	end
	else
	begin
		prix := inv[choix].iType.prix;
		repeat
			writeln('Combien souhaitez vous en vendre, max ', getNombreOccu(inv[choix].iType));
			readln(nbVente)
		until (nbVente <= getNombreOccu(inv[choix].iType));
		SubInventory(inv[choix].iType, nbVente);
		money := getMoney;
		money := money + prix*nbVente;
		setMoney(money);
		writeln('Vente terminée');
	end;
end;

end.