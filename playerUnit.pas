unit playerUnit;
{$codepage utf-8}
interface

uses dateUnit;
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

//Permet au joueur de dormir
procedure repos();

//Gère l'évanouissement du joueur
procedure evanouissement();

//Intègre le système de fatigue
procedure fatigue(point:Integer);

// Attendre : permet au joueur d'attendre 1heure
procedure Attendre();

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

procedure repos();
begin
  case getHeureActuelle of
    6..23 : begin
      jourSuivant();
      setHeureActuelle(6);
      setStamina(100);      
    end;
    0..1 : begin
      setHeureActuelle(6);
      setStamina(100);      
    end;
    2..5 : 
    begin
      evanouissement;
    end;
  end;
end;

procedure evanouissement();
begin
  case getHeureActuelle of
    0..5 : 
      setHeureActuelle(6);
    6..23 : begin
      jourSuivant;
      setHeureActuelle(6); // Si on s'évanouit alors qu'il est entre 0 et 5h, on ne change pas le jour, sinon, on passe au suivant et se réveille à 6h
    end; 
  end;
end;

//Si on fait une action, on perd 5 point d'endurance/stamina. Si on a dormi, on récupère toute son endurance, sinon on s'évanouit (on met la stamina à 10)
procedure fatigue(point : Integer);
begin
  setStamina(getStamina-point);
  heureSuivante;
  if getStamina <= 0 then
    evanouissement;
end;

// Attendre : permet au joueur d'attendre 1heure
procedure Attendre();
begin
  if (getHeureActuelle <1) or (getHeureActuelle>6) then 
    setJourActuel(getJourActuel() + (getHeureActuelle+1) div 24); // Passage au jour suivant si attente à 23h
    setHeureActuelle((getHeureActuelle()+1)mod 24);   //le mod 24 permet de revenir à 0 si l'heure est à 23 
end;
end.
