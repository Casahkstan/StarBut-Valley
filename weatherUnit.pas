unit weatherUnit;

{$codepage utf-8}

interface

uses dateUnit;

type
  TWeather=(Soleil,Pluie,Neige,Orage);  //Différents types de météo
  TSaison = (Printemps,Ete,Automne,Hiver); //Différentes saisons

//Génère un nombre aléatoire.
function randomWeather():Integer;

//Renvoie une saison différentes en fonction de la saison
procedure saisonnalite(); 

implementation

//On génère un nombre aléatoire via Randomize qu'on renvoie 
function randomWeather():Integer;
var
  aleatoire : Integer;  //Stocke une valeur aléatoire
begin
  Randomize;
  aleatoire := random(100);
  randomWeather:=aleatoire;
end;


//On compare la valeur aléatoire précédemment calculée avec certains nombres afin de créer des chances différents pour chaque météo selon la saison.
procedure saisonnalite();
var
  currentWeather : TWeather;  //Stocke la météo actuelle, est renvoyée
  aleatoire : Integer;
begin
  aleatoire := randomWeather();
  case getSaisonActuelle of
    Printemps : case aleatoire of
      0..59 : currentWeather := Soleil;
      60..89 : currentWeather := Pluie;
      90..99 : currentWeather := Orage; 
      // 60% que la météo soit ensoleillée,30% qu'elle soit pluvieuse et 10% pour qu'elle soit orageuse au Printemps ; même principe à la suite
    end;
    Ete : case aleatoire of
      0..69 : currentWeather := Soleil;
      70..79 : currentWeather := Pluie;
      80..99 : currentWeather := Orage;
    end;
    Automne : case aleatoire of
      0..9 : currentWeather :=  Soleil;
      10..79 : currentWeather := Pluie;
      80..99 : currentWeather := Orage;
    end;
    Hiver : case aleatoire of
      0..4 : currentWeather := Soleil;
      5..29 : currentWeather := Pluie;
      30..74 : currentWeather := Neige;
      75..99 : currentWeather := Orage;
    end;
  end;
  setSaisonActuelle(currentWeather);
end;

function getNumSaison():Integer;
var
  numero : Integer
begin
  case getSaisonActuelle of
  Printemps : numero := 0;
  Ete : numero := 1;
  Automne : numero := 2;
  Hiver : numero := 3;
end;
getNumSaison := numero;

end.

