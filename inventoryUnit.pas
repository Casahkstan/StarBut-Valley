unit inventoryUnit;

interface
// Types utilisé pour l'inventaire 
type 
  Rarity = (base, silver, gold, iridium);

  Item = record
    name : String;
    rarete : Rarity;
    stack:Integer;
  end;

  inventory = Array of Item;

// Init: Crée l'inventaire en lui assignant les valeurs par défault
procedure initInventory();

// Add : Ajoute un élément passé en paramètre à l'inventaire. 
// ⚠️ Ne regarde pas si l'invetaire est plein
procedure AddInventory(name : String; ammount : Integer);

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
// ⚠️ Ne regarde pas si l'invetaire est vide
procedure SubInventory(name: String; ammount : Integer);

// Getter : Retourne l'inventaire du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getInventory() : inventory;

// Affiche l'inventaire ligne par ligne
procedure displayInventory();

implementation
uses playerUnit;

var
  inv : inventory;

procedure initInventory();
var
  itemVide : Item;    // Item par défault dans l'inventaire
  i : Integer;        // Compteur
begin
  SetLength(inv,5);
  
  itemVide.name := 'Vide';
  itemVide.stack := 0;
  itemVide.rarete := Rarity.base;
  for i := low(inv) to high(inv) do
    inv[i] := itemVide;
end;

// Retourne True si l'item passé en paramètre est présent, false sinon
function isPresent(name : String) : Boolean;
var
  inv : inventory;      // Inventaire du joueur
  i : Integer;          // Compteur
begin
  inv := getInventory;
  i := low(inv);
  while (i < high(inv)) and (inv[i].name <> name) do
    i := i + 1;
  
  if inv[i].name = name then
    isPresent := True
  else
    isPresent := False;
end;

// Retourne False si l'inventaire contient un stack non plein de l'item passé en paramètre, True sinon
function isStackNotFull(name : String) : Boolean;
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
    if (inv[i].name = name) and (inv[i].stack <> 5) then
      stackDispo := True;
    i := i + 1;
  end;

  isStackNotFull := stackDispo;
end;

//Add : Ajoute un élément passé en paramètre à l'inventaire.
procedure AddInventory(name : String; ammount : Integer);
var
  inv : inventory;      // Inventaire du joueur
  i,                    // Compteur
  newAmmount : Integer; // Nouvelle valeur pour le nouveau stack a ajouter
  newItem : Item;       // Nouvel item a ajouter dans l'inventaire (seulement si l'item n'est pas l'inventaire ou que le stack n'est pas plein)
begin
  inv := getInventory;
  i := low(inv);
  // SI L'OBJET EST DEJA DANS L'INVENTAIRE ET QU'UN DES STACKS N'EST PAS PLEIN
  if isPresent(name) and isStackNotFull(name) then
  begin
    while (inv[i].name <> name) and (inv[i].stack <> 5) do
      i := i + 1;
    if inv[i].stack + ammount > 5 then
    begin
      newAmmount := ammount - inv[i].stack;
      inv[i].stack := 5;
      AddInventory(name, newAmmount);
    end
    else
      inv[i].stack := ammount + inv[i].stack;
  end
  // SINON
  else
  begin  
    while (i < high(inv)) and (inv[i].name <> 'Vide') do
      i := i + 1;
    if ammount <= 5 then
    begin
      newItem.name := name;
      newItem.stack := ammount;
      inv[i] := newItem;
    end
    // CAS OU AMMOUNT EST SUPERIEUR A 5
    else
    begin
      newItem.name := name;
      newItem.stack := 5;
      inv[i] := newItem;
      AddInventory(name, ammount-5);
    end;
  end;
end;

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
procedure SubInventory(name: String; ammount : Integer);
var
  inv : inventory;      // Inventaire du joueur
  itemVide : Item;      // Item par default dans une case de l'inventaire pas utilisée
  i : Integer;          // Compteur
begin
  inv := getInventory;
  if isPresent(name) then
  begin
    i := low(inv);
    while (ammount <> 0) and (i < high(inv)) do
    begin
      if (inv[i].name = name) then
      begin
        if (ammount >= inv[i].stack) then
        begin
          writeln(ammount);
          itemVide.name := 'Vide';
          itemVide.stack := 0;
          ammount := ammount - inv[i].stack;
          inv[i] := itemVide;
        end
        else
        begin
          writeln(ammount);
          inv[i].stack := inv[i].stack - ammount;
          ammount := 0;
        end;
      end;
      i := i + 1;
    end;
    // Si Inventaire finis en supprimoins de 'ammount' items avec le nom 'name'
    if ammount <> 0 then
      write('Je ne peux pas en enlever autant')
  end;
end;

// Getter : Retourne l'inventaire du joueur
//  ⚠️ Ne peut pas être utilisé pour modifier des variables
function getInventory() : inventory;
begin
  getInventory := inv;
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
		writeln(inv[i].name, ' (', inv[i].stack, ')');
end;
end.