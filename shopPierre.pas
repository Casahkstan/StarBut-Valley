unit shopPierre;

{$mode objfpc}{$H+}

interface
uses inventoryUnit, SeedUnit,playerUnit,StarBUTValleyIHM,sysutils,GestionEcran;
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
	i,j,	//Compteurs
	multiplicateurRarete : Integer;	// Multiplie le prix d'un objet selon sa rareté
begin
	effacerEcran;
	for i:=0 to getInventoryLevel do
		for j:=0 to 4 do 
			begin
				deplacerCurseurXY(10+j*40,40+i*3);
				write(getInventory[i*5+j].Itype.name+' vous en avez '+IntToStr(getInventory[i*5+j].stack)); 
			end;
	affichageMessage(89,110,10,14,'Que veux-tu vendre ?');
	deplacerCurseurXY(95,13);
	readln(choix);
	effacerEcran;
	inv := getInventory;
	if inv[choix-1].iType.name = 'Vide' or not inv[choix-1].iType.legume then
	begin
		affichageMessage(85,113,24,26,'Impossible de vendre ceci !');
		attendrems(1000);
		ShopIHM;
	end
	else
	begin
		prix := inv[choix-1].iType.prix;
		repeat
			affichageMessage(79,119,10,14,'Combien souhaitez vous en vendre, max '+IntToStr(getNombreOccu(inv[choix-1].iType)));
			deplacerCurseurXY(82,13);
			readln(nbVente)
		until (nbVente <= getNombreOccu(inv[choix-1].iType));
		SubInventory(inv[choix-1].iType, nbVente);
		case inv[choix-1].iType.rarete of
			base: multiplicateurRarete := 1;
			silver: multiplicateurRarete := 2;
			gold: multiplicateurRarete := 3;
			iridium: multiplicateurRarete := 4;
		end;
		money := getMoney;
		money := money + (prix + 1 * multiplicateurRarete) * nbVente;
		setMoney(money);
		effacerEcran;
		affichageMessage(85,113,24,26,'Vente terminée');
		readln;
		effacerEcran;
		ShopIHM;
	end;
end;

end.