unit dateUnit;
{$codepage utf-8}


interface

type
  TJour = (Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche);
  TSaison = 0..3; //Différentes saisons

  date = record
    minute : 0..60;
    heure : 0..24;
    jour : TJour;
    numJour : Integer;
    saison : TSaison;
    annee : Integer;
  end;

function getDate() : date;

procedure setDate(val : date);

//Passe à la saison suivante
procedure saisonSuivante ();
//Passe au jour suivant
procedure jourSuivant ();
//Gère le passage des heures et des jours après avoir réalisé une action
procedure passageTemps();

//Passe à l'heure suivante;
procedure heureSuivante();


//Initialise la date
procedure initDate();

function getJourActuel():TJour;
procedure setJourActuel(valeur:TJour);

function getSaisonActuelle():TSaison;
procedure setSaisonActuelle(valeur:TSaison);

function getNumJour():Integer;
procedure setNumJour(valeur:Integer);

function getHeureActuelle() : Integer;
procedure setHeureActuelle(valeur:Integer);

//Getter/Setter qualifiant une tâche d'action 
function getIsAction():Boolean;
procedure setIsAction(valeur:Boolean);

implementation
uses weatherUnit;

var 
  currentTime : date;
  isAction : Boolean;

function getDate() : date;
begin
  getDate := currentTime;
end;

procedure setDate(val : date);
begin
  currentTime := val;
end;


// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utiliser pour modifier des variablesfunction getJourActuel():TJour;
function getJourActuel():TJour;
begin
  getJourActuel:=getDate().jour;
end;

procedure setJourActuel(valeur:TJour);
var
  dateActuelle : date;
begin
  dateActuelle := getDate();
  dateActuelle.jour := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne la saison actuelle
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getSaisonActuelle():TSaison;
begin
  getSaisonActuelle := getDate().saison;
end;

procedure setSaisonActuelle(valeur:TSaison);
var
  dateActuelle : date;
begin
  dateActuelle := getDate();
  dateActuelle.saison := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne le numéro du jour
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getNumJour():Integer;
begin
  getNumJour := getDate().numJour;
end;

procedure setNumJour(valeur:Integer);
var
  dateActuelle : date;
begin
  dateActuelle := getDate();
  dateActuelle.numJour := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne la date actuelle
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getHeureActuelle():Integer;
begin
  getHeureActuelle := getDate().heure;
end;

procedure setHeureActuelle(valeur:Integer);
var
  dateActuelle : date;
begin
  dateActuelle := getDate();
  dateActuelle.heure := valeur;
  setDate(dateActuelle);
end;


function getIsAction():Boolean;
begin
  getIsAction := isAction;
end;

procedure setIsAction(valeur:Boolean);
begin
  isAction := valeur;
end;


//On initialise la date au premier jour du printemps 2023 à 6h00
procedure initDate();
begin
  currentTime.minute := 0;
  currentTime.heure := 6;
  currentTime.jour := Lundi;
  currentTime.numJour := 1;
  currentTime.saison := 0;
  currentTime.annee := 2023;
end;

//On passe à la saison suivante grâce à succ. Néanmoins, si la saison est l'hiver, alors on la passe manuellement au printemps
procedure saisonSuivante ();
begin
  if getSaisonActuelle = 3 then
    setSaisonActuelle(0)
  else
    setSaisonActuelle(succ(getSaisonActuelle));
  
end;

//Même principe que la procedure saisonSuivante
procedure jourSuivant ();
begin
  if getJourActuel = Dimanche then
    setJourActuel(Lundi)
  else
    setJourActuel(succ(getDate().jour));
  setNumJour(getNumJour()+1);
  if (getNumJour mod 28) = 0 then
    saisonSuivante();
  chaineMeteo;
end;

//Si l'heure actuelle vaut 23, alors on repasse l'heure à 0 pour passer à l'heure suivante. Sinon, on ajoute 1.
procedure heureSuivante();
begin
  if getHeureActuelle = 23 then
  begin
    setHeureActuelle(0);
    jourSuivant();
  end
  else
    setHeureActuelle(getHeureActuelle+1);

end;

//Si une action (planter ou se déplacer) est réalisée, on ajoute une heure (?) à l'horloge.
procedure passageTemps();
begin
  if getIsAction then
    heureSuivante();

end;



end.