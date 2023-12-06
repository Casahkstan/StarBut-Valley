unit weatherUnit;

{$codepage utf-8}

interface

uses dateUnit;

type
  TWeather=(Soleil,Pluie,Neige,Orage);  //Différents types de météo

//Génère un nombre aléatoire
function randomWeather():Integer;

//Change la météo actuelle selon la saison
function saisonnalite():Tweather; 

//Retourne le numéro correspondant à la saison
function getNumSaison():Integer;

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
function saisonnalite() : TWeather;
var
  currentWeather : TWeather;  //Stocke la météo actuelle, est renvoyée
  aleatoire : Integer;
begin
  aleatoire := randomWeather();
  case getSaisonActuelle of
    0 : case aleatoire of
      0..59 : currentWeather := Soleil;
      60..89 : currentWeather := Pluie;
      90..99 : currentWeather := Orage; 
      // 60% que la météo soit ensoleillée,30% qu'elle soit pluvieuse et 10% pour qu'elle soit orageuse au Printemps ; même principe à la suite
    end;
    1 : case aleatoire of
      0..69 : currentWeather := Soleil;
      70..79 : currentWeather := Pluie;
      80..99 : currentWeather := Orage;
    end;
    2 : case aleatoire of
      0..9 : currentWeather :=  Soleil;
      10..79 : currentWeather := Pluie;
      80..99 : currentWeather := Orage;
    end;
    3 : case aleatoire of
      0..4 : currentWeather := Soleil;
      5..29 : currentWeather := Pluie;
      30..74 : currentWeather := Neige;
      75..99 : currentWeather := Orage;
    end;
  end;
  saisonnalite:=currentWeather;
end;




end.