unit playerUnit;

interface
// Type pour gérer le joueur
type
  Player = record
	username : String;
	money : Integer;
	stamina : Integer;
	experience : Integer;
  end;

{
  Init: Crée le joueur en lui assignant les valeurs par défault
}
procedure initPlayer(var p : Player);

{
  Setter : Change le nom de l'utilisateur passé en paramètre
}
procedure setName(var p : Player; username : String);

{
  Setter : Change la quantité d'argent de l'utilisateur passé en paramètre
}
procedure setMoney(var p : Player; m : Integer);

{
  Setter : Change la stamina de l'utilisateur passé en paramètre
}
procedure setStamina(var p : Player; s : Integer);

{
  Setter : Change la quantité d'experience de l'utilisateur passé en paramètre
}
procedure setExp(var p : Player; e : Integer);

{
  Getter : Retourne le nom de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getName(var p : Player) : String;

{
  Getter : Retourne la money de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getMoney(var p : Player) : Integer;

{
  Getter : Retourne la stamina de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getStamina(var p : Player) : Integer;

{
  Getter : Retourne la quantité d'experience de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getExp(var p : Player) : Integer;

implementation
{
  Init: Crée le joueur en lui assignant les valeurs par défault
}
procedure initPlayer(var p : Player);
begin
  p.username := 'Non défini';
  p.stamina := 100;
  p.money := 200;
end;

{
  Setter : Change le nom de l'utilisateur passé en paramètre
}
procedure setName(var p : Player; username : String);
begin
  p.username := username;
end;

{
  Setter : Change la quantité d'argent de l'utilisateur passé en paramètre
}
procedure setMoney(var p : Player; m : Integer);
begin
  p.money := m;
end;

{
  Setter : Change la stamina de l'utilisateur passé en paramètre
}
procedure setStamina(var p : Player; s : Integer);
begin
  p.stamina := s;
end;

{
  Setter : Change la quantité d'experience de l'utilisateur passé en paramètre
}
procedure setExp(var p : Player; e : Integer);
begin
  p.experience := e;
end;

{
  Getter : Retourne le nom de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getName(var p : Player) : String;
begin
  getName := p.username;
end;

{
  Getter : Retourne la money de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getMoney(var p : Player) : Integer;
begin
  getMoney := p.money;
end;

{
  Getter : Retourne la stamina de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getStamina(var p : Player) : Integer;
begin
  getStamina := p.stamina;
end;

{
  Getter : Retourne la quantité d'experience de l'utilisateur passé en paramètre
  ⚠️ Ne peut pas être utiliser pour modifier des variables
}
function getExp(var p : Player) : Integer;
begin
  getExp := p.experience;
end;

end.
