unit inventoryUnit;

interface
//  Types utilisé pour l'inventaire 
type 
  Item=record
    name:String;
    stack:Integer;
  end;

  inventory = Array of Item;

procedure AddInventory(name : String; ammount : Integer);
procedure SubInventory(e: String; ammount : Integer);
procedure SubInventory(e: String);
function getInventory() : inventory;
function isPresent(name : String) : Boolean;
function isStackFull(name : String) : Boolean;

implementation
uses playerUnit;
//Add : Ajoute un élément passé en paramètre à l'inventaire.
procedure AddInventory(name : String; ammount : Integer);
var
  inv : inventory;
  i,
  newAmmount : Integer;
  newItem : Item
begin
  inv := getInventory;
  if isPresent(e) and isStackFull(e) then
  begin
    while (inv[i].name <> name) and (inv[i].stack <> 5) do
      i := i + 1;
    if inv[i].stack + ammount < 5 then
    begin
      newAmmount := ammount - inv[i].stack;
      inv[i].stack = 5;
      AddInventory(name, newAmmount);
    end;
  end
  else
  begin  
    while i <= high(inv) and inv[i].name <> 'Vide' do
      i := i + 1;
    newItem.name := name;
    newItem.stack := ammount;
    inv[i] := newItem;
  end;
end;

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
procedure SubInventory(e: String; ammount : Integer);
begin
  
end;

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
procedure SubInventory(e: String);

// Getter : Retourne l'inventaire du joueur
//  ⚠️ Ne peut pas être utilisé pour modifier des variables
function getInventory() : inventory;  

function isPresent(name : String) : Boolean;
var
  inv : inventory;
  i : Integer;
begin
  inv := getInventory;
  while i <= high(inv) and inv[i].name <> name do
    i := i + 1;
  
  if inv[i].name = name then
    isPresent := True
  else
    isPresent := False;
end;
function isStackFull(name : String) : Boolean;
var
  inv : inventory;
  i : Integer;
  stack := Boolean;
begin
  inv := getInventory;
  while (i <= high(inv)) and stack = False do
  begin
    if inv[i].name = name then
      if inv[i].stack <> 5 then
        stack := False;
      else
        stack := True;
  end;
end.