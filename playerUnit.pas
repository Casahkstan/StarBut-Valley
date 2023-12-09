unit playerUnit;
{$codepage utf-8}
interface

// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();

// Getter : Retourne le nom du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getName() : String;

// Setter : Change le nom du joueur
procedure setName(s : String);

// Getter : Retourne la money du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getMoney() : Integer;

// Setter : Change la quantité d'argent du joueur
procedure setMoney(m : Integer);

// Getter : Retourne la stamina du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getStamina() : Integer;

// Setter : Change la stamina du joueur
procedure setStamina(s : Integer);

// Getter : Retourne la quantité d'experience du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getExpLevel() : Integer;

// Setter : Change la quantité d'experience du joueur
procedure setExp(e : Integer);

//Permet au joueur de dormir
procedure repos();

//Gère l'évanouissement du joueur
procedure evanouissement();

//Intègre le système de fatigue
procedure fatigue(point:Integer);

// Attendre : permet au joueur d'attendre 1heure
procedure Attendre();

// Ajoute e experience au joueur, met a jour le niveau
procedure addExperience(e : Integer);

implementation
uses inventoryUnit, dateUnit, StarBUTValleyIHM, math, sysutils;

//  Variable du joueur
var
  username : String;  // Chaîne de caractères, nom du joueur
  stamina,  // Entier, niveau d'endurance du joueur
  money,  // Entier, argent du joueur
  level,  // Entier, niveau du joueur (en fonction du nombre d'experience)
  experience : Integer; // Entier, quantité d'expérience du joueur

// Init: Crée le joueur en lui assignant les valeurs par défault
procedure initPlayer();
begin
  username := 'Non défini';
  stamina := 100;
  money := 200;
  experience:=0;
  level := 0;
  initInventory();
end;

// Getter : Retourne le nom du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getName() : String;
begin
  getName := username;
end;

// Setter : Change le nom du joueur
procedure setName(s : String);
begin
  username := s;
end;

// Getter : Retourne la money du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getMoney() : Integer;
begin
  getMoney := money;
end;

// Setter : Change la quantité d'argent du joueur
procedure setMoney(m : Integer);
begin
  money := m;
end;

// Getter : Retourne la stamina du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getStamina() : Integer;
begin
  getStamina := stamina;
end;

// Setter : Change la stamina du joueur
procedure setStamina(s : Integer);
begin
  stamina := s;
end;

// Getter : Retourne la quantité d'experience du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getExpLevel() : Integer;
begin
  getExpLevel := level;
end;

procedure setExpLevel(v : Integer);
begin
  level := v;
end;

// Setter : Change la quantité d'experience du joueur
procedure setExp(e : Integer);
begin
  experience := e;
end;

// Permet au joueur de dormir seulement entre 6h et 1h du matin, sinon, il s'évanouit
procedure repos();
var
  heure : Integer;
begin
  heure := getHeureActuelle;
  meteoSuivante;
  case heure of
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

// Gère l'évanouissement du joueur
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
  affichageMessage(88,110,10,14,'Vous vous etes evanouis');
  readln();
end;

//Si on fait une action, on perd 5 point d'endurance/stamina. Si on a dormi, on récupère toute son endurance, sinon on s'évanouit (on met la stamina à 10)
procedure fatigue(point : Integer);
begin
  setStamina(getStamina-point); 
  if getStamina <= 0 then
    evanouissement;
end;

// Attendre : permet au joueur d'attendre 1heure
procedure Attendre();
begin
  if (getHeureActuelle = 1) then
    evanouissement
  else
  begin
    if (getHeureActuelle + 1 > 23) then
      jourSuivant(); // Passage au jour suivant si attente à 23h
    setHeureActuelle((getHeureActuelle()+1)mod 24);   //le mod 24 permet de revenir à 0 si l'heure est à 23
  end;
end;

function getExp() : Integer;
begin
  getExp := experience;
end;

// Procedure privée qui met a jour le niveau du joueur
procedure updateLevel();
var
  exp,
  lvl : Integer;
begin
  exp := getExp;
  lvl := getExpLevel;
  if (2 * math.Log2(exp) >= lvl) and (lvl <> 10) then
  begin
    setExpLevel(lvl + 1);
    setExp(0);
    affichageMessage(88,110,10,14,'Vous etes passes niveau '+IntToStr(getExpLevel));
  end;
end;


// Ajoute e experience au joueur, met a jour le niveau
procedure addExperience(e : Integer);
var
  exp : Integer;
begin
  exp := getExp;
  exp := exp + e;
  setExp(exp);
  updateLevel();
end;

end.
