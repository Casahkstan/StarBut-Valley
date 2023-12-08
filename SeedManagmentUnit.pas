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
        joursMature:Integer;  // Chaque slot de ferme possède ces caractéristiques
    end;

    emplacement=Array[1..30] of slot; // Tableau de slots individuels

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();

// Getter : Retourne toute la ferme du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getFerme() : emplacement;

// Setter : Change la valeur de la ferme a la variable passée en paramètre
procedure setFerme(f : emplacement);

// Getter : Retourne le nom de la ferme du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getNomFerme() : String;

// Setter : Change le nom de la ferme a la variable passée en paramètre
procedure setNomFerme(s : String);

// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre
procedure AddSeed(numEmplacement : Integer; seed : itemType);

// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();

// Ramasse : permet de ramasser un légumes mûr
procedure Ramasse(numEmplacement:Integer);

// DonneRarete : donne la rareté d'un objet en fonction de l'expérience d'un joueur
function DonneRarete() : Rarity;

// ClearEmplacement : Permet de vider un emplacement passé en paramètre
procedure ClearEmplacement(numEmplacement:Integer);

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arroser
procedure arrose(numEmplacement:Integer);

// arroseTout : Permet d'arroser toutes les plantes de la ferme en une fois
procedure arroseTout();

// joursPluvieux : arrose automatiquement les légumes quand il pleut
procedure joursPluvieux();

// secher : Change l'état arrosé du slot num de la ferme à faux
procedure secher(num : Integer);

//  secherTout : Parcourt la ferme et sèche tous ses emplacements
procedure secherTout();

procedure toutAmeliorer();

implementation
var
    ferme:emplacement;  // Ferme du jeu
    nomFerme : String;  // Nom de la ferme

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();
var
    i:Integer;  // Entier, parcourt les slots de la ferme
    fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
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
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getFerme() : emplacement;
begin
    getFerme:=ferme;
end;

// Setter : Change la ferme
procedure setFerme(f : emplacement);
begin
  ferme := f;
end;

// Getter : Retourne le nom de la ferme du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getNomFerme() : String;
begin
  getNomFerme := nomFerme;
end;

// Setter : Change le nom de la ferme a la variable passée en paramètre
procedure setNomFerme(s : String);
begin
  nomFerme := s;
end;

// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;
var
  fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
begin
    fermeTemp := getFerme;
    if fermeTemp[num].elem.name='Emplacement vide' then
        EstVide:=true
    else
        EstVide:=false;
end;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre, seulement si l'emplacement est vide
procedure AddSeed(numEmplacement : Integer; seed : itemType);
var
  fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
begin
    if EstVide(numEmplacement) and (seed.name <> 'Vide') then 
        begin
            SubInventory(seed, 1);
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

procedure ameliorer(n : Integer);
var
  fermeTemp : emplacement;
begin
  fermeTemp := getFerme;  
  if (fermeTemp[n].arrose = true) and (fermeTemp[n].elem.name <> 'Emplacement vide') and (fermeTemp[n].joursRestant <> 0) then
    fermeTemp[n].joursRestant := fermeTemp[n].joursRestant - 1;
  setFerme(fermeTemp);
end;

procedure toutAmeliorer();
var
  i : Integer;
begin
  for i:= low(getFerme) to high(getFerme) do
    ameliorer(i);
end;

// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();
var 
    i:Integer;  // Entier, parcourt les slots de la ferme
    fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme 
begin
    fermeTemp := getFerme;
    for i:=low(fermeTemp) to high(fermeTemp) do 
    begin
        if (fermeTemp[i].joursMature>=getNumJour()) and (fermeTemp[i].arrose = true) then
            fermeTemp[i].joursRestant:=fermeTemp[i].joursRestant+1;
    end;
    setFerme(fermeTemp);
end;

// Ramasse : permet de ramasser un légumes mûr
procedure Ramasse(numEmplacement:Integer);
var 
    retour:itemType;  // itemType, légume ramassé ajouté à l'inventaire
    fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
begin
  fermeTemp := getFerme;
    if (not EstVide(numEmplacement)) and (fermeTemp[numEmplacement].joursRestant=0) and (isPresent(fermeTemp[numEmplacement].elem) or isStackAvailable(fermeTemp[numEmplacement].elem)) then 
        begin
            retour:=fermeTemp[numEmplacement].elem;
            retour.rarete:=DonneRarete();
            retour.legume := True;
            ClearEmplacement(numEmplacement);
        end;
  AddInventory(retour, 1);
end;

// DonneRarete : donne la rareté d'un objet en fonction de l'expérience d'un joueur
function DonneRarete() : Rarity;
var
    chanceBase,
    chanceArgent,
    chanceOr, // Entiers, stockent les probabilités de rareté  
    numChance : Integer;  // Entier, sert à simuler un tirage aléatoire
    probRarete:Rarity;  // Rareté, renvoyé, la rareté d'une graine suivant le niveau du joueur 
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
  fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
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

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arrosé, si elle ne l'est pas déjà
procedure arrose(numEmplacement:Integer);
var
  fermeTemp : emplacement;  // Ferme temporaire, permet de modifier une à une les valeurs de la ferme
begin
    fermeTemp := getFerme;
    if (fermeTemp[numEmplacement].arrose=false)and(not EstVide(numEmplacement)) then
    begin
        fermeTemp[numEmplacement].arrose:=true;
        fatigue(1);
    end;
    setFerme(fermeTemp);
end;

// arroseTout : Permet d'arroser toutes les plantes de la ferme en une fois
procedure arroseTout();
var
  i : Integer;  // Entier, parcourt les slots de la ferme
begin
  for i:=low(getFerme) to high(getFerme) do
    arrose(i);
end;

// joursPluvieux : arrose automatiquement les emplacements s'il pleut
procedure joursPluvieux();
var
  currentWeather : TWeather;  // stocke la météo courante
begin
  currentWeather := getCurrentWeather();
  if (currentWeather = TWeather.Pluie) or (currentWeather = TWeather.Orage) then
  arroseTout;
end;

// secher : Change l'état arrosé du slot num de la ferme à faux
procedure secher(num : Integer);
var 
  fermeTemp:emplacement;  // Ferme temporaire, permet de modifier une valeur de la ferme
begin
  fermeTemp := getFerme;
  fermeTemp[num].arrose := false;
  setFerme(fermeTemp);
end;

//  secherTout : Parcourt la ferme et sèche tous ses emplacements
procedure secherTout();
var
  i : Integer;  //Entier, parcourt les slots de la ferme
begin
  for i := low(getFerme) to high(getFerme) do
    secher(i);
end;
end.