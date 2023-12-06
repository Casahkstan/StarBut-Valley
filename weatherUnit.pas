unit weatherUnit;

{$codepage utf-8}

interface

uses dateUnit;

type
  TWeather=(Soleil,Pluie,Neige,Orage);  //Différents types de météo


function getCurrentWeather():TWeather;
procedure setCurrentWeather(valeur : TWeather);

function getFutureWeather():TWeather;
procedure setFutureWeather(valeur : TWeather);

function getAleatoire():Integer;
procedure setAleatoire(valeur:Integer);

//Génère un nombre aléatoire
procedure randomWeather();

//Change la météo actuelle selon la saison
procedure saisonnalite();

procedure chaineMeteo();

implementation

var
  futureWeather,
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

function getFutureWeather():TWeather;
begin
  getFutureWeather := futureWeather;
end;

procedure setFutureWeather(valeur : TWeather);
begin
  futureWeather := valeur;
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
      0..59 : setFutureWeather(Soleil);
      60..89 : setFutureWeather(Pluie);
      90..99 : setFutureWeather(Orage); 
      // 60% que la météo soit ensoleillée,30% qu'elle soit pluvieuse et 10% pour qu'elle soit orageuse au Printemps ; même principe à la suite
    end;
    1 : case getAleatoire of
      0..69 : setFutureWeather(Soleil);
      70..79 : setFutureWeather(Pluie);
      80..99 : setFutureWeather(Orage);
    end;
    2 : case getAleatoire of
      0..9 : setFutureWeather(Soleil);
      10..79 : setFutureWeather(Pluie);
      80..99 : setFutureWeather(Orage);
    end;
    3 : case getAleatoire of
      0..4 : setFutureWeather(Soleil);
      5..29 : setFutureWeather(Pluie);
      30..74 : setFutureWeather(Neige);
      75..99 : setFutureWeather(Orage);
    end;
  end;
end;

function chaineMeteo() : TWeather;
begin
  randomWeather;
  chaineMeteo := getFutureWeather;  
end;

end.