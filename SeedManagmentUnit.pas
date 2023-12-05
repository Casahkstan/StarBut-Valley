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

// GetterEmplacement : Retourne un numero d'emplacement passé en paramètre
function GetEmplacement(num : Integer) : slot;

// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre
procedure AddSeed(numEmplacement : Integer; seed : itemType);

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arrosé
procedure arrose(numEmplacement:Integer);

// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();

// Ramasse : permet de ramasser un légumes mûr
function Ramasse(numEmplacement:Integer) : itemType;

// joursPluvieux : arrose automatiquement les légumes quand il pleut
procedure joursPluvieux();

implementation
var
    ferme:emplacement;

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();
var
    i:Integer;
begin
    for i:=low(ferme) to high(ferme) do
        begin
            ferme[i].elem.name:='Emplacement vide';
            ferme[i].elem.rarete:=base;
            ferme[i].elem.saison:=-1;
            ferme[i].elem.prix:=-1;
            ferme[i].joursRestant:=-1;
            ferme[i].arrose:=false;
            ferme[i].joursPlante:=-1;
            ferme[i].joursMature:=-1;
        end;
end;
// Getter : Retourne toute la ferme du joueur
// ⚠️ Ne peut pas être utiliser pour modifier des variables
function getFerme() : emplacement;
begin
    getFerme:=ferme;
end;


// GetterEmplacement : Retourne un numero d'emplacement passé en paramètre
function GetEmplacement(num : Integer) : slot;
begin
    GetEmplacement:=getFerme()[num];
end;
// EstVide : Retourne True si un emplacement est vide et False sinon
function EstVide(num:Integer):Boolean;
begin
    if GetEmplacement(num).elem.name<>'Emplacement vide' then
        EstVide:=true
    else
        EstVide:=false;
end;

// AddSeed : Plante une graine dans un des emplacement passé en paramètre
procedure AddSeed(numEmplacement : Integer; seed : itemType);
begin
    if EstVide(numEmplacement)=False then 
        writeln('L''emplacement est déja pris vous ne pouvez pas l''utilisé')
    else
        begin
            GetEmplacement(numEmplacement).elem.name:=seed.name;
            GetEmplacement(numEmplacement).elem.rarete:=seed.rarete;
            GetEmplacement(numEmplacement).elem.saison:=seed.saison;
            GetEmplacement(numEmplacement).elem.prix:=seed.prix;
            GetEmplacement(numEmplacement).elem.maturite:=seed.maturite;
            GetEmplacement(numEmplacement).joursRestant:=seed.maturite;
            GetEmplacement(numEmplacement).arrose=false;
            GetEmplacement(numEmplacement).joursPlante:=getNumJour();
            GetEmplacement(numEmplacement).joursMature:=GetEmplacement(numEmplacement).joursPlante+GetEmplacement(numEmplacement).elem.maturite;
        end;
end;

// Arrose : passe le booléen nommé "arrose" de faux à vrai pour l'arrosé
procedure arrose(numEmplacement:Integer);
begin
    if GetEmplacement(numEmplacement).arrose=false then
        GetEmplacement(numEmplacement).arrose:=true
    else
        writeln('Votre plante est deja arrosé');
end;

// Grandit : reduit de 1 la valeur du jours restant
procedure Grandit();
var 
    i:Integer;
begin
    for i:=low(getFerme()) to high(getFerme()) do 
    begin
        if GetEmplacement(i).joursMature>=getNumJour() then
            GetEmplacement(i).joursRestant:=GetEmplacement(i).joursRestant+1;
    end;
end;

//donne la rareté d'un objet en fonction de l'expérience d'un joueur
function DonneRarete() : Rarity;
var
    chanceBase,
    chanceArgent,
    chanceOr,
    chanceIridium,
    numChance : Integer;
    probRarete:Rarity;
begin
    Randomize;
    numChance:=random(101);
    chanceBase:=78-(3*getExp());
    chanceArgent:=14+getExp();
    chanceOr:=8+getExp();
    chanceIridium:=getExp();
    case numChance of 
        0..chanceBase: probRarete:=base;
        chanceBase+1..chanceBase+chanceArgent: probRarete:=argent;
        chanceBase+chanceArgent+1..chanceBase+chanceArgent+chanceOr : probRarete:=or;
        chanceBase+chanceArgent+chanceOr+1..100 : probRarete:=iridium;
    end;
    DonneRarete:=probRarete;
end;
// ClearEmplacement : Permet de vider un emplacement passé en paramètre
procedure ClearEmplacement(numEmplacement:Integer);
begin
    if not EstVide(numEmplacement) then 
        begin
            getFerme()[numEmplacement].elem.name:='Emplacement vide';
            getFerme()[numEmplacement].elem.rarete:=base;
            getFerme()[numEmplacement].elem.saison:=-1;
            getFerme()[numEmplacement].elem.prix:=-1;
            getFerme()[numEmplacement].joursRestant:=-1;
            getFerme()[numEmplacement].arrose:=false;
            getFerme()[numEmplacement].joursPlante:=-1;
            getFerme()[numEmplacement].joursMature:=-1; 
        end;
end;
// Ramasse : permet de ramasser un légumes mûr
function Ramasse(numEmplacement:Integer) : itemType;
var 
    retour:itemType;
begin
    if (not EstVide(numEmplacement) and GetEmplacement(numEmplacement).joursRestant=0) then 
        begin
            retour:=getFerme()[numEmplacement].elem;
            retour.rarete:=DonneRarete();
            ClearEmplacement(numEmplacement);
        end;
    else
    begin
        writeln('Vous ne pouvez pas ramassé.');
        writeln('Veuillez attendre ou planter une graine');
    end;
end;

procedure joursPluvieux();
begin
  if (currentWeather = Pluie) or (currentWeather = Orage) then
  begin
    for i:=low(getFerme) to high(getFerme) do
      GetEmplacement[i].arrose := True;
  end;
end;
end.