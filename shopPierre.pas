unit shopPierre;

{$mode objfpc}{$H+}

interface
uses inventoryUnit, SeedUnit,playerUnit;
type
	shop = array[0..3] of itemType;	// Boutique de Pierre
  
// Permet d'acheter des objets à Pierre
procedure acheter(choix : Integer);

// Permet de vendre des objets à Pierre
procedure vendre();

implementation

// Permet d'acheter des objets à Pierre
procedure acheter(choix : Integer);
var
	produit : shop;		// Produits proposés
	money : Integer;	// Argent du joueur
begin
	produit := getSeed();
	money := getMoney();
	if money > produit[choix].prix then
	begin
		if isPresent(produit[choix]) and isStackAvailable(produit[choix]) or isNotFull then
		begin
			money := money - produit[choix].prix;
			AddInventory(produit[choix], 1);
			setMoney(money);
		end
	else
		writeln('Inventaire plein');
	end
else
	writeln('Pas assez d''argent');
end;

// Permet de vendre des objets à Pierre
procedure vendre();
var
	inv : inventory;		// Inventaire du joueur
	nbVente,	// Nombre de produits vendus
	money,	// Argent du joueur
	prix,	// Prix d'une graine
	choix,	// Choix du joueur
	multiplicateurRarete : Integer;	// Multiplie le prix d'un objet selon sa rareté
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
		case inv[choix].iType.rarete of
			base: multiplicateurRarete := 1;
			silver: multiplicateurRarete := 2;
			gold: multiplicateurRarete := 3;
			iridium: multiplicateurRarete := 4;
		end;
		money := getMoney;
		money := money + (prix + 1 * multiplicateurRarete) * nbVente;
		setMoney(money);
		writeln('Vente terminée');
	end;
end;

end.