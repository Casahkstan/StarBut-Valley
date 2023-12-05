unit dateUnit;
{$codepage utf-8}


interface

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

function getHeureActuelle():0..24;
procedure setHeureActuelle(valeur:0..24);


implementation

var 
  jourActuel : TJour;
  saisonActuelle : TSaison;
  numJour : Integer;
  heureActuelle : 0..24;

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
function getHeureActuelle():0..24;
begin
  getHeureActuelle := heureActuelle;
end;

procedure setHeureActuelle(valeur:0..24);
begin
  heureActuelle := valeur;
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
begin
  if getHeureActuelle = 23 then
  begin
    setHeureActuelle(0);
    jourSuivant();
  end; 
  else
    setHeureActuelle(getHeureActuelle+1);

end;

//Si une action (planter ou se déplacer) est réalisée, on ajoute une heure (?) à l'horloge.
procedure passageTemps();
begin
  if {action} then
    heureSuivante();

end;

procedure repos ();
begin
  if {dort} then
  begin
    setHeureActuelle(6);
    jourSuivant();
  end;
end;

 
end.