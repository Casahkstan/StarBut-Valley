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
procedure saisonSuivante (var saisonActuelle:TSaison);
//Passe au jour suivant
procedure jourSuivant (var jourActuel:TJour,var numJour : Integer);
//Gère le passage des heures et des jours après avoir réalisé une action
procedure passageTemps(var currentTime:date);


implementation

//On initialise la date au premier jour du printemps 2023 à 6h00
procedure initDate();
begin
  date.minute := 0;
  date.heure := 6;
  date.jour := Lundi;
  date.numJour := 1;
  date.saison := Printemps;
  date.annee := 2023;
end;

//On passe à la saison suivante grâce à succ. Néanmoins, si la saison est l'hiver, alors on la passe manuellement au printemps
procedure saisonSuivante (var saisonActuelle:TSaison);
begin
  if saisonActuelle = Hiver then
    saisonActuelle := Printemps;
  else
    saisonActuelle := succ(saisonActuelle);
end;

//Même principe que la procedure saisonSuivante
procedure jourSuivant (var jourActuel:TJour,var numJour : Integer);
begin
  if jourActuel = Dimanche then
    jourActuel := Lundi
  else
    jourActuel := succ(jourActuel);
  numJour:=numJour+1;
end;

//Si une action (planter ou se déplacer) est réalisée, on ajoute une heure (?) à l'horloge.
procedure passageTemps(var currentTime:date);
begin
  if {action} then
    currentTime.heure := currentTime.heure + 1;
  //Si on dépasse les 23h, on retourne le nombre d'heures à 0 et on ajoute un jour
  if currentTime.heure > 23 then
  begin
    currentTime.heure := 0;
    jourSuivant(currentTime.jour);
  end;
end;

 
end.