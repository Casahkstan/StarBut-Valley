unit dateUnit;
{$codepage utf-8}

interface

type
  TJour = (Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche);  // Type énuméré contenant les jours de la semaine
  TSaison = 0..3; // Type énuméré contenant les 4 valeurs de saison

  date = record
    minute : 0..60;
    heure : 0..24;  
    jour : TJour;
    numJour : Integer;
    saison : TSaison;
    annee : Integer;  
  end;  // Record de la date possédant les minutes,heures,jour...

// Getter : Retourne la date
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getDate() : date;
// Setter : Change la date du jour
procedure setDate(val : date);

// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getJourActuel():TJour;
// Setter : Change le jour actuel
procedure setJourActuel(valeur:TJour);

// Getter : Retourne la saison actuelle
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getSaisonActuelle():TSaison;
// Setter : Change la saison actuelle
procedure setSaisonActuelle(valeur:TSaison);

// Getter : Retourne le numéro du jour
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getNumJour():Integer;
// Setter : Change le numéro du jour
procedure setNumJour(valeur:Integer);

// Getter : Retourne l'heure actuelle
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getHeureActuelle() : Integer;
// Setter : Change l'heure actuelle
procedure setHeureActuelle(valeur:Integer);

// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getMinuteActuelle():Integer;

//Initialise la date
procedure initDate();

//Passe à la saison suivante
procedure saisonSuivante ();
//Passe au jour suivant
procedure jourSuivant ();

//Passe à l'heure suivante;
procedure heureSuivante();

//Passe à la météo suivante
procedure meteoSuivante();

// Retourne une chaine de caractère correspondant au nom de la saison actuelle
function getSaisonName() : String;




implementation
uses weatherUnit;

var 
  currentTime : date;   //record date, contient la date actuelle


// Getter : Retourne la date
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getDate() : date;
begin
  getDate := currentTime;
end;

// Setter : Change la date du jour
procedure setDate(val : date);
begin
  currentTime := val;
end;


// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utilisé pour modifier des variablesfunction getJourActuel():TJour;
function getJourActuel():TJour;
begin
  getJourActuel:=getDate().jour;
end;

// Setter : Change le jour actuel
procedure setJourActuel(valeur:TJour);
var
  dateActuelle : date;  //record date, permet de changer seulement le jour de la date
begin
  dateActuelle := getDate();
  dateActuelle.jour := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne la saison actuelle
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getSaisonActuelle():TSaison;
begin
  getSaisonActuelle := getDate().saison;
end;

// Setter : Change la saison actuelle
procedure setSaisonActuelle(valeur:TSaison);
var
  dateActuelle : date;  //record date, permet de changer seulement la saison de la date
begin
  dateActuelle := getDate();
  dateActuelle.saison := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne le numéro du jour
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getNumJour():Integer;
begin
  getNumJour := getDate().numJour;
end;

// Setter : Change le numéro du jour
procedure setNumJour(valeur:Integer);
var
  dateActuelle : date;  //record date, permet de changer seulement le numéro de jour de la date
begin
  dateActuelle := getDate();
  dateActuelle.numJour := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne la date actuelle
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getHeureActuelle():Integer;
begin
  getHeureActuelle := getDate().heure;
end;

// Setter : Change l'heure actuelle
procedure setHeureActuelle(valeur:Integer);
var
  dateActuelle : date;  //record date, permet de changer seulement l'heure de la date
begin
  dateActuelle := getDate();
  dateActuelle.heure := valeur;
  setDate(dateActuelle);
end;

// Getter : Retourne le jour actuel
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getMinuteActuelle():Integer;
begin
  getMinuteActuelle := getDate().minute;
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
var
  dateTemp : date;
  i : Integer;
begin
  if getSaisonActuelle = 3 then
  begin
    dateTemp := getDate;
    dateTemp.annee := dateTemp.annee + 1;
    setDate(dateTemp);
    setSaisonActuelle(0);
    for i := low(getFerme) to high(getFerme) do
      ClearEmplacement(i);
  end
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
  toutAmeliorer();
  secherTout();
  if (getNumJour mod 28) = 1 then
  begin
    saisonSuivante();
  end;
  meteoSuivante;
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

//Change la météo seulement si l'heure dépasse 6h du matin
procedure meteoSuivante();
begin
  if getHeureActuelle >= 6 then
  begin
    setCurrentWeather(getFutureWeather);
    randomWeather;
  end;
end;

// Retourne une chaine de caractère correspondant au nom de la saison actuelle
function getSaisonName() : String;
var
  saisonValue : Integer;
begin
  saisonValue := getSaisonActuelle;
  case saisonValue of
    0 : getSaisonName := 'Printemps';
    1 : getSaisonName := 'Ete';
    2 : getSaisonName := 'Automne';
    3 : getSaisonName := 'Hiver';
  end;
end;
end.