unit inventoryUnit;


interface
uses playerUnit, dateUnit;
// Types utilisé pour l'inventaire 
type
  Rarity = (base, silver, gold, iridium);


  itemType = record
    name : String;
    rarete : Rarity;
    saison : TSaison;
  end;

  Item = record
    iType : itemType;
    stack:Integer;
  end;

  inventory = Array of Item;

// Init: Crée l'inventaire en lui assignant les valeurs par défault
procedure initInventory();

// Add : Ajoute 'ammount' élément passé en paramètre à l'inventaire. 
// ⚠️ Ne regarde pas si l'invetaire est plein
procedure AddInventory(iT : itemType; ammount : Integer);

// Sub : Retire un élément passé en paramètre à l'inventaire du joueur
// ⚠️ Ne regarde pas si l'invetaire est vide
procedure SubInventory(iT : itemType; ammount : Integer);

// Setter : Change l'inventaire
procedure setInventory(inv : inventory);

// Getter : Retourne l'inventaire du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getInventory() : inventory;

// Affiche l'inventaire ligne par ligne
procedure displayInventory();

// Augmente d'un niveau l'inventaire du joueur
procedure upgradeInventory();

// Getter : Retourne le niveau de l'inventaire du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getInventoryLevel() : Integer;

implementation

var
  inventaire : inventory;
  level : Integer;

procedure initInventory();
var
  iType : itemType;
  itemVide : Item;    // Item par défault dans l'inventaire
  i : Integer;        // Compteur
begin
  SetLength(inventaire,5);
  
  iType.name := 'Vide';
  iType.rarete := Rarity.base;
  itemVide.iType := iType;
  itemVide.stack := 0;
  for i := low(inventaire) to high(inventaire) do
    inventaire[i] := itemVide;
end;

// Retourne True si l'item passé en paramètre est présent, false sinon
function isPresent(iT : itemType) : Boolean;
var
  inv : inventory;      // Inventaire du joueur
  i : Integer;          // Compteur
begin
  inv := getInventory;
  i := low(inv);
  while (i < high(inv)) and (inv[i].iType.name <> iT.name) and (inv[i].iType.rarete <> iT.rarete) do
    i := i + 1;
  
  if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
    isPresent := True
  else
    isPresent := False;
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

function isMaxed() : Boolean;
begin
  if getInventoryLevel = 3 then
    isMaxed := True
  else
    isMaxed := False;
end;

//Add : Ajoute un élément passé en paramètre à l'inventaire.
procedure AddInventory(iT : itemType; ammount : Integer);
var
  inv : inventory;      // Inventaire du joueur
  i,                    // Compteur
  newAmmount : Integer; // Nouvelle valeur pour le nouveau stack a ajouter
  newItem : Item;       // Nouvel item a ajouter dans l'inventaire (seulement si l'item n'est pas l'inventaire ou que le stack n'est pas plein)
begin
  inv := getInventory;
  i := low(inv);
  // SI L'OBJET EST DEJA DANS L'INVENTAIRE ET QU'UN DES STACKS N'EST PAS PLEIN
  if isPresent(iT) and isStackAvailable(iT) then
  begin
    // Récupère l'indice de l'item
    while (inv[i].iType.name <> iT.name) and (inv[i].iType.rarete <> iT.rarete) and (inv[i].stack <> 5) do
      i := i + 1;
    // Regarde si le slot sera rempli
    if inv[i].stack + ammount > 5 then
    begin
      newAmmount := (ammount + inv[i].stack) - 5;
      inv[i].stack := 5;
      AddInventory(iT, newAmmount);
    end
    else
    begin
      inv[i].stack := ammount + inv[i].stack;
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
  iType : itemType;     // Type de l'item par défault
begin
  inv := getInventory;
  if isPresent(iT) then
  begin
    i := low(inv);
    while (ammount <> 0) and (i < high(inv)) do
    begin
      writeln(inv[i].iType.name);
      if (inv[i].iType.name = iT.name) and (inv[i].iType.rarete = iT.rarete) then
      begin
        iType.name := 'Vide';
        iType.rarete := Rarity.base;
        itemVide.iType := iType;
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

// Affiche l'inventaire ligne par ligne
procedure displayInventory();
var
  inv : inventory;
  i : Integer;
begin
	inv := getInventory;
  writeln('Voici l''inventaire de ', getName);
	for i := low(inv) to high(inv) do
		writeln(inv[i].iType.name, ' (', inv[i].iType.rarete, ') : ', inv[i].stack);
end;

// Augmente d'un niveau l'inventaire du joueur et met des slots vide dans les nouveaux compartiments
procedure upgradeInventory();
var
  inv : inventory;
  itemVide : Item;
  iT : itemType;
  i : Integer;
begin
  if not isMaxed then
  begin
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
  end;
end;

// Getter : Retourne le niveau de l'inventaire du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getInventoryLevel() : Integer;
begin
  getInventoryLevel := level;
end;
end.