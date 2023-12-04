unit playerUnit;
{$codepage utf-8}
interface
//  Types utilisé pour l'inventaire 
type 
  Item=record
    name:String;
    stack:Integer;
  end;

  liste_record = Array of Item;
// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();

// Setter : Change le nom de l'utilisateur passé en paramètre
procedure setName(username : String);

// Setter : Change la quantité d'argent de l'utilisateur passé en paramètre
procedure setMoney(m : Integer);

// Setter : Change la stamina de l'utilisateur passé en paramètre
procedure setStamina(s : Integer);

// Setter : Change la quantité d'experience de l'utilisateur passé en paramètre
procedure setExp(e : Integer);

//Add : Ajoute un élément passé en paramètre à l'inventaire. Un message d'erreur sera affiché si l'inventaire est déjà rempli
procedure AddInventaire(e : String);

//Sub : Retire un élément passé en paramètre à l'inventaire du joueur
procedure SubInventaire(e: String);
//Sub : Retire un élément passé en paramètre à l'inventaire du joueur.

// Getter : Retourne le nom de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getName() : String;

// Getter : Retourne la money de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getMoney() : Integer;

// Getter : Retourne la stamina de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getStamina() : Integer;

// Getter : Retourne la quantité d'experience de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getExp() : Integer;

// Getter : Retourne l'inventaire du joueur
//  ⚠️ Ne peut pas être utilisé pour modifier des variables
function getInventaire() : liste_record;  

implementation

//  Variable du joueur
var
  username : String;
  stamina,
  money,
  experience : Integer;
  inventaire : liste_record;

// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();
begin
  username := 'Non défini';
  stamina := 100;
  money := 200;
  experience:=0;
  SetLength(inventaire,5);
end;

// Setter : Change le nom de l'utilisateur passé en paramètre
procedure setName(username : String);
begin
  username := username;
end;

// Setter : Change la quantité d'argent de l'utilisateur passé en paramètre
procedure setMoney(m : Integer);
begin
  money := m;
end;

// Setter : Change la stamina de l'utilisateur passé en paramètre
procedure setStamina(s : Integer);
begin
  stamina := s;
end;

// Setter : Change la quantité d'experience de l'utilisateur passé en paramètre
procedure setExp(e : Integer);
begin
  experience := e;
end;

//Add : Ajoute un élément passé en paramètre à l'inventaire. Un message d'erreur sera affiché si l'inventaire est déjà rempli
procedure AddInventaire(e : String);
begin
  assert length()
end;

// Getter : Retourne le nom de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getName() : String;
begin
  getName := username;
end;

// Getter : Retourne la money de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getMoney() : Integer;
begin
  getMoney := money;
end;

// Getter : Retourne la stamina de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getStamina() : Integer;
begin
  getStamina := stamina;
end;

// Getter : Retourne la quantité d'experience de l'utilisateur passé en paramètre
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getExp() : Integer;
begin
  getExp := experience;
end;




end.
