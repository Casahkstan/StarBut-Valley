unit dateUnit;
{$codepage utf-8}


interface

uses weatherUnit;

type
  TJour = (Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche);
  date = record
    minute : 0..60;
    heure : 0..24;
    jour : TJour;
    numJour : Integer;
    saison : TSaison;
    annee : Integer;
  end;

//Passe à la saison suivante
procedure saisonSuivante ();
//Passe au jour suivant
procedure jourSuivant ();
//Gère le passage des heures et des jours après avoir réalisé une action
procedure passageTemps();

//Initialise la date
procedure initDate();



implementation

var 
  jourActuel : TJour;
  saisonActuelle : TSaison;
  numJour : Integer;
  currentTime : date;

// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utiliser pour modifier des variablesfunction getJourActuel():TJour;
function getJourActuel():TJour;
begin
  getJourActuel:=jourActuel;
end;

procedure setJourActuel(valeur:TJour);
begin
  jourActuel := valeur;
end;

// Getter : Retourne la saison actuelle
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getSaisonActuelle():TSaison;
begin
  getSaisonActuelle := saisonActuelle;
end;

procedure setSaisonActuelle(valeur:TSaison);
begin
  saisonActuelle := valeur;
end;

// Getter : Retourne le numéro du jour
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getNumJour():Integer;
begin
  getNumJour := numJour;
end;

procedure setNumJour(valeur:Integer);
begin
  currentTime.numJour := valeur;
end;

// Getter : Retourne la date actuelle
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getCurrentTime():date;
begin
  getCurrentTime := currentTime;
end;

procedure setCurrentTime(valeur:date);
begin
  currentTime := valeur;
end;

//On initialise la date au premier jour du printemps 2023 à 6h00
procedure initDate();
begin
  currentTime.minute := 0;
  currentTime.heure := 6;
  currentTime.jour := Lundi;
  currentTime.numJour := 1;
  currentTime.saison := Printemps;
  currentTime.annee := 2023;
end;

//On passe à la saison suivante grâce à succ. Néanmoins, si la saison est l'hiver, alors on la passe manuellement au printemps
procedure saisonSuivante ();
begin
  if getSaisonActuelle = Hiver then
    setSaisonActuelle(Printemps);
  else
    setSaisonActuelle(succ(getSaisonActuelle));
  
end;

//Même principe que la procedure saisonSuivante
procedure jourSuivant ();
begin
  if getJourActuel = Dimanche then
    setJourActuel(Lundi)
  else
    setJourActuel(succ(jourActuel));
  setNumJour(getNumJour()+1);
  if (getNumJour mod 28) = 0 then
    saisonSuivante();
end;

//Si l'heure actuelle vaut 23, alors on repasse l'heure à 0 pour passer à l'heure suivante. Sinon, on ajoute 1.
procedure heureSuivante();
var
  time : date;
begin
  time := getCurrentTime();
  if time.heure = 23 then
  begin
    time.heure := 0;
    jourSuivant();
  end; 
  else
    time.heure := time.heure + 1;
  setCurrentTime(time);

end;

//Si une action (planter ou se déplacer) est réalisée, on ajoute une heure (?) à l'horloge.
procedure passageTemps();
begin
  if {action} then
    heureSuivante();

end;

procedure repos ();
begin
  if {dort} 
end;

 
end.