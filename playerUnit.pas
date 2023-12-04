unit playerUnit;
{$codepage utf-8}
interface
// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();

// Setter : Change le nom du joueur
procedure setName(s : String);

// Setter : Change la quantité d'argent du joueur
procedure setMoney(m : Integer);

// Setter : Change la stamina du joueur
procedure setStamina(s : Integer);

// Setter : Change la quantité d'experience du joueur
procedure setExp(e : Integer);

// Getter : Retourne le nom du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getName() : String;

// Getter : Retourne la money du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getMoney() : Integer;

// Getter : Retourne la stamina du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getStamina() : Integer;

// Getter : Retourne la quantité d'experience du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getExp() : Integer;

implementation
uses inventoryUnit;

//  Variable du joueur
var
  username : String;
  stamina,
  money,
  experience : Integer;

// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();
begin
  username := 'Non défini';
  stamina := 100;
  money := 200;
  experience:=0;
  initInventory();
end;

// Setter : Change le nom du joueur
procedure setName(s : String);
begin
  username := s;
end;

// Setter : Change la quantité d'argent du joueur
procedure setMoney(m : Integer);
begin
  money := m;
end;

// Setter : Change la stamina du joueur
procedure setStamina(s : Integer);
begin
  stamina := s;
end;

// Setter : Change la quantité d'experience du joueur
procedure setExp(e : Integer);
begin
  experience := e;
end;

// Getter : Retourne le nom du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getName() : String;
begin
  getName := username;
end;

// Getter : Retourne la money du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getMoney() : Integer;
begin
  getMoney := money;
end;

// Getter : Retourne la stamina du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getStamina() : Integer;
begin
  getStamina := stamina;
end;

// Getter : Retourne la quantité d'experience du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getExp() : Integer;
begin
  getExp := experience;
end;




end.
