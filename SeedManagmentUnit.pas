unit SeedManagmentUnit;
{$codepage utf-8}
interface

uses inventoryUnit,dateUnit,playerUnit,weatherUnit;
type 

    slot = record 
        elem:itemType;
        joursRestant:Integer;
        arrose:Boolean; 
        joursPlante:Integer;
        joursMature:Integer;
    end;

    emplacement=Array[1..30] of slot;

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();

// Getter : Retourne toute la ferme du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getFerme() : emplacement;

// Setter : Change la valeur de la ferme a la variable passée en paramètre
procedure setFerme(f : emplacement);

// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre
procedure AddSeed(numEmplacement : Integer; seed : itemType);

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arrosé
procedure arrose(numEmplacement:Integer);

procedure arroseTout();

// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();

// Ramasse : permet de ramasser un légumes mûr
procedure Ramasse(numEmplacement:Integer);

// Getter : Retourne le nom de la ferme du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getNomFerme() : String;

// Setter : Change le nom de la ferme a la variable passée en paramètre
procedure setNomFerme(s : String);

// joursPluvieux : arrose automatiquement les légumes quand il pleut
procedure joursPluvieux();

implementation
var
    ferme:emplacement;
    nomFerme : String;

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();
var
    i:Integer;
    fermeTemp : emplacement;
begin
    fermeTemp := getFerme;
    for i:=low(fermeTemp) to high(fermeTemp) do
        begin
            fermeTemp[i].elem.name:='Emplacement vide';
            fermeTemp[i].elem.rarete:=base;
            fermeTemp[i].elem.saison:=-1;
            fermeTemp[i].elem.prix:=-1;
            fermeTemp[i].joursRestant:=-1;
            fermeTemp[i].arrose:=false;
            fermeTemp[i].joursPlante:=-1;
            fermeTemp[i].joursMature:=-1;
        end;
    setFerme(fermeTemp);
end;
// Getter : Retourne toute la ferme du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getFerme() : emplacement;
begin
    getFerme:=ferme;
end;

// Getter : Retourne le nom de la ferme du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getNomFerme() : String;
begin
  getNomFerme := nomFerme;
end;

// Setter : Change le nom de la ferme a la variable passée en paramètre
procedure setNomFerme(s : String);
begin
  nomFerme := s;
end;

procedure setFerme(f : emplacement);
begin
  ferme := f;
end;

// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;
var
  fermeTemp : emplacement;
begin
    fermeTemp := getFerme;
    if fermeTemp[num].elem.name<>'Emplacement vide' then
        EstVide:=true
    else
        EstVide:=false;
end;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre
procedure AddSeed(numEmplacement : Integer; seed : itemType);
var
  fermeTemp : emplacement;
begin
    if not EstVide(numEmplacement) then 
        writeln('L''emplacement est déja pris vous ne pouvez pas l''utilisé')
    else
        begin
            fermeTemp := getFerme();
            fermeTemp[numEmplacement].elem.name := seed.name;
            fermeTemp[numEmplacement].elem.rarete := seed.rarete;
            fermeTemp[numEmplacement].elem.saison := seed.saison;
            fermeTemp[numEmplacement].elem.prix := seed.prix;
            fermeTemp[numEmplacement].elem.maturite := seed.maturite;
            fermeTemp[numEmplacement].joursRestant := seed.maturite;
            fermeTemp[numEmplacement].arrose := false;
            fermeTemp[numEmplacement].joursPlante := getNumJour();
            fermeTemp[numEmplacement].joursMature := getFerme()[numEmplacement].joursPlante+fermeTemp[numEmplacement].elem.maturite;
            setFerme(fermeTemp);
        end;
end;

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arrosé
procedure arrose(numEmplacement:Integer);
var
  fermeTemp : emplacement;
begin
    fermeTemp := getFerme;
    if fermeTemp[numEmplacement].arrose=false then
    begin
        fermeTemp[numEmplacement].arrose:=true;
        fatigue(1);
    end
    else
        writeln('Votre plante est deja arrosé');
    setFerme(fermeTemp);
end;

procedure arroseTout();
var
  i : Integer;
begin
  for i:=low(getFerme) to high(getFerme) do
    arrose(i);
end;


// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();
var 
    i:Integer;
    fermeTemp : emplacement;
begin
    fermeTemp := getFerme;
    for i:=low(fermeTemp) to high(fermeTemp) do 
    begin
        if (fermeTemp[i].joursMature>=getNumJour()) and (fermeTemp[i].arrose = true) then
            fermeTemp[i].joursRestant:=fermeTemp[i].joursRestant+1;
    end;
    setFerme(fermeTemp);
end;

//donne la rareté d'un objet en fonction de l'expérience d'un joueur
function DonneRarete() : Rarity;
var
    chanceBase,
    chanceArgent,
    chanceOr,
    numChance : Integer;
    probRarete:Rarity;
begin
    Randomize;
    numChance:=random(101);
    chanceBase:=78-(3*getExp());
    chanceArgent:=14+getExp();
    chanceOr:=8+getExp();
    if (numChance >= 0) and (numChance <= chanceBase) then
      probRarete := Rarity.base
    else
    begin
      if (numChance >= chanceBase+1) and (numChance < chanceBase+chanceArgent) then
        probRarete := Rarity.silver
      else
        if (numChance >= chanceBase+chanceArgent+1) and (numChance < chanceBase+chanceArgent+chanceOr) then
          probRarete := Rarity.gold
        else
          probRarete := Rarity.iridium;
    end; 
    DonneRarete:=probRarete;
end;
// ClearEmplacement : Permet de vider un emplacement passé en paramètre
procedure ClearEmplacement(numEmplacement:Integer);
var
  fermeTemp : emplacement;
begin
    fermeTemp := getFerme;
    if not EstVide(numEmplacement) then 
        begin
            fermeTemp[numEmplacement].elem.name:='Emplacement vide';
            fermeTemp[numEmplacement].elem.rarete:=base;
            fermeTemp[numEmplacement].elem.saison:=-1;
            fermeTemp[numEmplacement].elem.prix:=-1;
            fermeTemp[numEmplacement].joursRestant:=-1;
            fermeTemp[numEmplacement].arrose:=false;
            fermeTemp[numEmplacement].joursPlante:=-1;
            fermeTemp[numEmplacement].joursMature:=-1; 
        end;
    setFerme(fermeTemp);
end;
// Ramasse : permet de ramasser un légumes mûr
procedure Ramasse(numEmplacement:Integer);
var 
    retour:itemType;
    fermeTemp : emplacement;
begin
  fermeTemp := getFerme;
    if (not EstVide(numEmplacement)) and (fermeTemp[numEmplacement].joursRestant=0) and (isPresent(fermeTemp[numEmplacement].elem) or isStackAvailable(fermeTemp[numEmplacement].elem)) then 
        begin
            retour:=fermeTemp[numEmplacement].elem;
            retour.rarete:=DonneRarete();
            ClearEmplacement(numEmplacement);
        end
    else
    begin
        writeln('Vous ne pouvez pas ramassé.');
        writeln('Veuillez attendre ou planter une graine');
    end;
  AddInventory(retour, 1);
end;

procedure joursPluvieux();
var
  fermeTemp : emplacement;
  i : Integer;
  currentWeather : TWeather;
begin
  fermeTemp := getFerme();
  currentWeather := getCurrentWeather();
  if (currentWeather = TWeather.Pluie) or (currentWeather = TWeather.Orage) then
  begin
    for i:=low(getFerme) to high(getFerme) do
      fermeTemp[i].arrose := True;
  end;
  setFerme(fermeTemp);
end;

procedure secher(num : Integer);
var 
  fermeTemp:emplacement;
begin
  fermeTemp := getFerme;
  fermeTemp[num].arrose := false;
  setFerme(fermeTemp);
end;

procedure secherTout();
var
  fermeTemp : emplacement;
  i : Integer;
begin
  fermeTemp := getFerme;
  for i := low(fermeTemp) to high(fermeTemp) do
    secher(i);
  setFerme(fermeTemp);
end;
end.