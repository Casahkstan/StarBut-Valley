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



implementation

var
  currentWeather : TWeather;
  aleatoire : Integer;

function getCurrentWeather():TWeather;
begin
  getCurrentWeather := currentWeather;
end;

procedure setCurrentWeather(valeur : TWeather);
begin
  currentWeather := valeur;
  
end;

function getAleatoire():Integer;
begin
  getAleatoire := aleatoire;
end;

procedure setAleatoire(valeur:Integer);
begin
  aleatoire := valeur;
end;

//On génère un nombre aléatoire via Randomize qu'on renvoie 
procedure randomWeather();
begin
  Randomize;
  setAleatoire(random(100));

end;


//On compare la valeur aléatoire précédemment calculée avec certains nombres afin de créer des chances différents pour chaque météo selon la saison.
procedure saisonnalite();
begin
  case getSaisonActuelle of
    0 : case getAleatoire of
      0..59 : setCurrentWeather(Soleil);
      60..89 : setCurrentWeather(Pluie);
      90..99 : setCurrentWeather(Orage); 
      // 60% que la météo soit ensoleillée,30% qu'elle soit pluvieuse et 10% pour qu'elle soit orageuse au Printemps ; même principe à la suite
    end;
    1 : case getAleatoire of
      0..69 : setCurrentWeather(Soleil);
      70..79 : setCurrentWeather(Pluie);
      80..99 : setCurrentWeather(Orage);
    end;
    2 : case getAleatoire of
      0..9 : setCurrentWeather(Soleil);
      10..79 : setCurrentWeather(Pluie);
      80..99 : setCurrentWeather(Orage);
    end;
    3 : case getAleatoire of
      0..4 : setCurrentWeather(Soleil);
      5..29 : setCurrentWeather(Pluie);
      30..74 : setCurrentWeather(Neige);
      75..99 : setCurrentWeather(Orage);
    end;
  end;
end;

function chaineMeteo():TWeather;
var
  futureWeather : TWeather;
begin
  randomWeather;
  futureWeather := saisonnalite;
  chaineMeteo := futureWeather; 

  
end;

