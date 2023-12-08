unit inventoryUnit;


interface
uses playerUnit, dateUnit, math,sysutils,GestionEcran;
// Types utilisé pour l'inventaire 
type
  Rarity = (base, silver, gold, iridium); // 4 niveaux de rareté pour une graine


  itemType = record
    name : String;
    rarete : Rarity;
    saison : Integer;
    prix : Integer;
    maturite : Integer; // Chaque type d'item a 5 caractéristiques, un nom, une rareté...
  end;

  Item = record
    iType : itemType;
    stack:Integer;  // Chaque item a 6 caractéristiques (5 du itemType + stack)
  end;

  inventory = Array of Item;  // Inventaire, tableau d'items

// Init: Crée l'inventaire en lui assignant les valeurs par défault
procedure initInventory();

// Setter : Change l'inventaire
procedure setInventory(inv : inventory);

// Getter : Retourne l'inventaire du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getInventory() : inventory;

// Getter : Retourne le niveau de l'inventaire du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getInventoryLevel() : Integer;

// Add : Ajoute 'ammount' élément passé en paramètre à l'inventaire. 
// ⚠️ Ne regarde pas si l'invetaire est plein
procedure AddInventory(iT : itemType; ammount : Integer);

// Sub : Retire un élément passé en paramètre à l'inventaire du joueur
// ⚠️ Ne regarde pas si l'invetaire est vide
procedure SubInventory(iT : itemType; ammount : Integer);

// Affiche l'inventaire ligne par ligne
procedure displayInventory();

// Augmente d'un niveau l'inventaire du joueur
procedure upgradeInventory();
      
// Retourne False si l'inventaire contient un stack non plein de l'item passé en paramètre, True sinon
function isStackAvailable(iT : itemType) : Boolean;

// Retourne True si l'item passé en paramètre est présent, false sinon
function isPresent(iT : itemType) : Boolean;

// Retourne True si l'inventaire n'est pas plein, false sinon
function isNotFull() : Boolean;

// Retourne le nombre de fois ou iT apprait dans l'inventaire (stack comptés)
function getNombreOccu(iT : itemType) : Integer;

implementation

var
  inventaire : inventory; // Inventaire du joueur
  level : Integer;  // Entier, niveau du joueur

// Init: Crée l'inventaire en lui assignant les valeurs par défault
procedure initInventory();
var
  iType : itemType;
  itemVide : Item;    // Item par défault dans l'inventaire
  i : Integer;        // Compteur
begin
  SetLength(inventaire,5);
  
  iType.name := 'Vide';
  iType.rarete := Rarity.base;
  iType.saison := -1;
  iType.prix := 0;
  iType.maturite := 0;
  itemVide.iType := iType;
  itemVide.stack := 0;
  for i := low(inventaire) to high(inventaire) do
    inventaire[i] := itemVide;
end;

// Setter : Change l'inventaire
procedure setInventory(inv : inventory);
begin
  inventaire := inv;
end;

// Getter : Retourne l'inventaire du joueur
//  ⚠️ Ne peut pas être utilisé pour modifier des variables
function getInventory() : inventory;
begin
  getInventory := inventaire;
end;

// Getter : Retourne le niveau de l'inventaire du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getInventoryLevel() : Integer;
begin
  getInventoryLevel := level;
end;

//Add : Ajoute un élément passé en paramètre à l'inventaire.
procedure AddInventory(iT : itemType; ammount : Integer);
var
  inv : inventory;      // Inventaire du joueur
  i,                    // Compteur
  newAmmount : Integer; // Nouvelle valeur pour le nouveau stack a ajouter
  newItem : Item;       // Nouvel item a ajouter dans l'inventaire (seulement si l'item n'est pas l'inventaire ou que le stack n'est pas plein)
  estPresent : Boolean; // Passe a vrai quand l'item est trouvé dans l'inventaire
begin
  inv := getInventory;
  i := low(inv);
  // SI L'OBJET EST DEJA DANS L'INVENTAIRE ET QU'UN DES STACKS N'EST PAS PLEIN
  if isPresent(iT) and isStackAvailable(iT) then
  begin
    estPresent := False;
    // Récupère l'indice de l'item
    while (i < high(inv)) and not estPresent do
    begin
      if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
        estPresent := True;
      i := i + 1;
    end;
    // Regarde si le slot sera rempli
    if inv[i-1].stack + ammount > 5 then
    begin
      newAmmount := (ammount + inv[i-1].stack) - 5;
      inv[i-1].stack := 5;
      AddInventory(iT, newAmmount);
    end
    else
    begin
      inv[i-1].stack := inv[i-1].stack + ammount;
    end;
  end
  // SINON
  else
  begin  
    while (i < high(inv)) and (inv[i].iType.name <> 'Vide') do
      i := i + 1;
    if ammount <= 5 then
    begin
      newItem.iType := iT;
      newItem.stack := ammount;
      inv[i] := newItem;
    end
    // CAS OU AMMOUNT EST SUPERIEUR A 5
    else
    begin
      newItem.iType := iT;
      newItem.stack := 5;
      inv[i] := newItem;
      AddInventory(iT, ammount-5);
    end;
  end;
  setInventory(inv);
end;

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
procedure SubInventory(iT : itemType; ammount : Integer);
var
  inv : inventory;      // Inventaire du joueur
  itemVide : Item;      // Item par default dans une case de l'inventaire pas utilisée
  newAmmount,           // Nombre d'item a stack avec un nouveau stack
  i : Integer;          // Compteur
  newItem,
  itType : itemType;     // Type de l'item par défault
begin
  inv := getInventory;
  if isPresent(iT) then
  begin
    i := low(inv);
    while (ammount <> 0) and (i < high(inv)) do
    begin
      if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
      begin
        itType.name := 'Vide';
        itType.rarete := Rarity.base;
        itType.prix := 0;
        itType.maturite := 0;
        itType.saison := -1;
        itemVide.iType := itType;
        itemVide.stack := 0;
        if (ammount >= inv[i].stack) then
        begin
          ammount := ammount - inv[i].stack;
          inv[i] := itemVide;
        end
        else
        begin
          newAmmount := inv[i].stack - ammount;
          newItem := inv[i].iType;
          inv[i] := itemVide;
          AddInventory(newItem, newAmmount);
          ammount := 0;
        end;
      end;
      i := i + 1;
    end;
    // Si Inventaire finis en supprimoins de 'ammount' items avec le nom 'name'
    if ammount <> 0 then
      write('Je ne peux pas en enlever autant')
  end;
  setInventory(inv);
end;

// Affiche l'inventaire ligne par ligne
procedure displayInventory();
var
  inv : inventory;  // Inventaire du joueur
  i : Integer;  // Entier, permet de parcourir l'inventaire
begin
	inv := getInventory;
  writeln('Voici l''inventaire de ', getName);
	for i := low(inv) to high(inv) do
		writeln(inv[i].iType.name, ' (', inv[i].iType.rarete, ') : ', inv[i].stack);
end;

// Retourne True si l'inventaire est au niveau maximum, false sinon
function isMaxed() : Boolean;
begin
  if getInventoryLevel = 3 then
    isMaxed := True
  else
    isMaxed := False;
end;


// Augmente d'un niveau l'inventaire du joueur et met des slots vide dans les nouveaux compartiments
procedure upgradeInventory();
var
  inv : inventory;  // Inventaire du joueur
  itemVide : Item;  // Item, sert de slot vide
  iT : itemType; // itemType, possède la plupart des caractéristiques d'un slot vide 
  i : Integer;  // Entier, parcourt l'inventaire
begin
  if not isMaxed then
  begin
    if getMoney > Round(100 * math.power(1.4, getInventoryLevel+1)) then
    begin
      setMoney(getMoney - Round(100*math.power(1.4, getInventoryLevel)));
      inv := getInventory();
      level := level + 1;
      SetLength(inv, length(inventaire)+5);

      iT.name := 'Vide';
      iT.rarete := Rarity.base;
      itemVide.iType := iT;
      itemVide.stack := 0;

      for i := high(inv)-5 to high(inv) do
        inv[i] := itemVide;

      setInventory(inv);
    end
    else
    begin
      effacerEcran; 
      affichageMessage(88,110,10,14,'Pas assez d''argent');
      readln;
      effacerEcran;
      ShopIHM;
    end;
  end
  else
    effacerEcran; 
      affichageMessage(88,110,10,14,'Sac max');
      readln;
      effacerEcran;
      ShopIHM;
end;

// Retourne False si l'inventaire contient un stack non plein de l'item passé en paramètre, True sinon
function isStackAvailable(iT : itemType) : Boolean;
var
  inv : inventory;      // Inventaire du joueur
  i : Integer;          // Compteur
  stackDispo : Boolean; // Valeur si un stack est dispo 
begin
  inv := getInventory;
  i := low(inv);
  stackDispo := False;
  while (i <= high(inv)) and (stackDispo = False) do
  begin
    if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) and (inv[i].stack <> 5) then
      stackDispo := True;
    i := i + 1;
  end;

  isStackAvailable := stackDispo;
end;

// Retourne True si l'item passé en paramètre est présent, false sinon
function isPresent(iT : itemType) : Boolean;
var
  inv : inventory;      // Inventaire du joueur
  i : Integer;          // Compteur
  estPresent : Boolean; // Valeur retournée
begin
  inv := getInventory;
  i := low(inv);
  estPresent := False;
  while (i < high(inv)) and not estPresent do
  begin
    if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
      estPresent := True;
    i := i + 1;
  end;
  isPresent := estPresent;
end;


// Retourne True si l'inventaire n'est pas plein, false sinon
function isNotFull() : Boolean;
var
  isFull : Boolean;   // Booléen, renvoyé
  i : Integer;    // Entier, permet de parcourir l'inventaire
  inv : inventory;  // Inventaire du joueur
begin
  inv := getInventory;
  isFull := True;
  i := low(inv);
  while (i < high(inv)) and isFull do
    begin
      if inv[i].iType.name = 'Vide' then
        isFull := False;
      i := i + 1;
    end;
  isNotFull := not isFull;
end;

// Retourne le nombre de fois ou iT apprait dans l'inventaire (stack comptés)
function getNombreOccu(iT : itemType) : Integer;
var
  i : Integer;  // Entier, parcourt l'inventaire
  inv : inventory;  // Inventaire du joueur
begin
  inv := getInventory;
  getNombreOccu := 0;
  for i := low(inv) to high(inv) do
    begin
      if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
      begin
        getNombreOccu := getNombreOccu + 1;
      end;
    end;
end;


end.