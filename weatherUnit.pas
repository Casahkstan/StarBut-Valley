unit weatherUnit;

{$codepage utf-8}

interface

uses dateUnit;

type
  TWeather=(Soleil,Pluie,Neige,Orage);  //Différents types de météo

// Getter : Retourne la météo actuelle
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getCurrentWeather():TWeather;
// Setter : Change la météo actuelle
procedure setCurrentWeather(valeur : TWeather);

// Getter : Retourne la météo du lendemain
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getFutureWeather():TWeather;
// Setter : Change la météo du lendemain
procedure setFutureWeather(valeur : TWeather);

// Getter : Retourne la valeur aléatoire
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getAleatoire():Integer;
// Setter : Change la valeur aléatoire
procedure setAleatoire(valeur:Integer);

//Génère un nombre aléatoire
procedure randomWeather();

//Change la météo actuelle selon la saison
procedure saisonnalite();

// Choisis la météo de demain
procedure chaineMeteo();

implementation

var
  futureWeather,  // Météo du lendemain
  currentWeather : TWeather;  // Météo courante
  aleatoire : Integer;  // Nombre aléatoire

// Getter : Retourne la météo actuelle
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getCurrentWeather():TWeather;
begin
  getCurrentWeather := currentWeather;
end;

// Setter : Change la météo actuelle
procedure setCurrentWeather(valeur : TWeather);
begin
  currentWeather := valeur;
  
end;

// Getter : Retourne la météo du lendemain
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getFutureWeather():TWeather;
begin
  getFutureWeather := futureWeather;
end;

// Setter : Change la météo du lendemain
procedure setFutureWeather(valeur : TWeather);
begin
  futureWeather := valeur;
end;

// Getter : Retourne la valeur aléatoire
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getAleatoire():Integer;
begin
  getAleatoire := aleatoire;
end;

// Setter : Change la valeur aléatoire
procedure setAleatoire(valeur:Integer);
begin
  aleatoire := valeur;
end;

//On génère un nombre aléatoire via Randomize qu'on renvoie 
procedure randomWeather();
begin
  Randomize;
  setAleatoire(random(100));
  saisonnalite;
end;


//On compare la valeur aléatoire précédemment calculée avec certains nombres afin de créer des chances différents pour chaque météo selon la saison.
procedure saisonnalite();
begin
  case getSaisonActuelle of
    0 : case getAleatoire of
      0..49 : setFutureWeather(Soleil);
      50..89 : setFutureWeather(Pluie);
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

// Choisis la météo de demain
procedure chaineMeteo();
begin
  randomWeather;
end;

end.