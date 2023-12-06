unit StarBUTlogic;

interface

// choixMenuPrincipal : Retourne un booléen sur le choix du début du jeu si le joueur veur jouer
function choixMenuPrincipal() : Boolean;

// Initpartie : lance une partie complète de StarBUTValley
procedure Initpartie();

// EcrisNom : procédure qui écirs le nom du joueur au début du jeu
procedure EcrisNom();

// EcrisFerme : procédure qui écris le nom de la ferme au début du jeu
procedure EcrisFerme();

// Maison : procédure qui lance chaque choix possible dans la maison
procedure Maison();

// Ferme : procédure qui lance chaque choix possible dans la ferme
procedure Ferme();

// Shop : procédure qui lance chaque choix possible dans le shop
procedure Shop();
implementation

uses weatherUnit,SeedUnit,inventoryUnit,shopPierre,dateUnit,playerUnit,SeedManagmentUnit;


// Initpartie : lance une partie complète de StarBUTValley
procedure Initpartie();
begin
    initPlayer();
    initGarden();
    InitgraineSaison();
    initDate();
end;

// choixMenuPrincipal : Retourne un booléen sur le choix du début du jeu si le joueur veur jouer
function choixMenuPrincipal() : Boolean;
var 
    choixInt : Integer;
    choixBool : Boolean;
begin
    readln(choixInt);
    if choixInt=1 then 
        choixBool:=true
    else
        choixBool:=false;
    choixMenuPrincipal:=choixBool;
end;

// EcrisNom : procédure qui écirs le nom du joueur au début du jeu
procedure EcrisNom();
var
    nom : String;
begin
    readln(nom);
    setName(nom);
end;

// EcrisFerme : procédure qui écris le nom de la ferme au début du jeu
procedure EcrisFerme();
var
    nom : String;
begin
    readln(nom);
    setNomFerme(nom);
end;

// BatimentChoix : fonction qui propose tous les choix qui sont disponibles dans les batiments et renvoie le choix fait
function BatimentChoix() : Integer;
var
    choix : Integer;
begin
    readln(choix);
    BatimentChoix:=choix;
end;

// ChoixEmplacement : fonction qui retourne l'emplacement choisit 
function ChoixEmplacement() : Integer;
var
    choix : Integer;
begin
    readln(choix);
    ChoixEmplacement:=choix;
end;

// Maison : procédure qui lance chaque choix possible dans la maison
procedure Maison();
var 
    choix:Integer;
begin
    choix:=BatimentChoix();
    case choix of 
        1:Ferme();
        2:Attendre();
        3:repos();
        4:write(chaineMeteo());
        9:choixMenuPrincipal();
    end;
end;

// menuEmplacement : procedure qui ouvre un menu avec un emplecment passé en paramètre
procedure menuEmplacement();
var
    num:Integer;
begin
    num:=ChoixEmplacement();
    case num of 
        1:AddSeed(num,getInventory()[ChoixEmplacement()].iType);
        2:arrose(num);
        3:Ramasse(num);
    end;
end;
// Ferme : procédure qui lance chaque choix possible dans la ferme
procedure Ferme();
var 
    choix:Integer;
begin
    choix:=BatimentChoix();
    case choix of 
        1:Maison();
        2:Shop();
        3:menuEmplacement();
        4:arroseTout();
        9:choixMenuPrincipal();
    end;
end;
//menuachete : menu qui propose soit d'acheter soit d'avoir une description des graines
procedure menuachete();
var 
    choix:Integer;
begin
    choix:=ChoixEmplacement();
    case choix of 
        1..4:acheter(choix-1);
        5:upgradeInventory();
        6:description(getSeed()[choix].name);
    end;
end;
// Shop : procédure qui lance chaque choix possible dans le shop
procedure Shop();
var 
    choix:Integer;
begin
    choix:=BatimentChoix();
    case choix of 
        1:Ferme();
        2:Menuachete();
        3:vendre();
        9:choixMenuPrincipal();
    end;
end;
end.