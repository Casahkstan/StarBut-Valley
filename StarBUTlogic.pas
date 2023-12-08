unit StarBUTlogic;
{$codepage utf-8}
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

// menuEmplacement : procedure qui ouvre un menu avec un emplecment passé en paramètre
procedure menuEmplacement();

//menuachete : menu qui propose soit d'acheter soit d'avoir une description des graines
procedure menuachete();

implementation

uses weatherUnit,inventoryUnit,shopPierre,dateUnit,playerUnit,SeedManagmentUnit,StarBUTValleyIHM,GestionEcran,sysutils,SeedUnit;

// Initpartie : lance une partie complète de StarBUTValley
procedure Initpartie();
begin
    initPlayer();
    initGarden();
    initgraines();
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
        1:FermeIHM;
        2:Attendre();
        3:
            begin
                EffaceRuban;
                dessinerCadreXY(40,30,159,40,double,White,Black);
                deplacerCurseurXY(94,35);
                write('Bonne nuit');
                repos();
                attendrems(1000);
                MaisonIHM;
            end;
        4:
            begin
                effacerEcran;
                dessinerCadreXY(1,1,199,50,double,White,White);
                dessinerCadreXY(1,1,199,8,double,Brown,Black);
                deplacerCurseurXY(86,4);
                write('Allumage de la télé');
                affichePierre(50,9);
                attendrems(1000);
                effacerEcran;
                dessinerCadreXY(1,1,199,50,double,Black,White);
                deplacerCurseurXY(86,25);
                write('Météo de demain : ',chaineMeteo);
                readln;
                MaisonIHM;
            end;
        9:debutPartie();
    end;
end;

// menuEmplacement : procedure qui ouvre un menu avec un emplacment passé en paramètre
procedure menuEmplacement();
var
    num,choix1,choix2,i,j:Integer;
begin
    num:=ChoixEmplacement();
    case num of 
        1:
            begin
                effacerEcran;
                dessinerCadreXY(40,20,159,30,double,White,Black);
                deplacerCurseurXY(68,22);
                write('Quel graine de ton inventaire choisis tu (numéro de slot)');
                for i:=0 to getInventoryLevel do
                    for j:=0 to 4 do 
                        begin
                            deplacerCurseurXY(10+j*40,40+i*3);
                            write(getInventory[i*5+j].Itype.name+' vous en avez '+IntToStr(getInventory[i*5+j].stack)); 
                        end;
                deplacerCurseurXY(45,25);
                choix1:=ChoixEmplacement()-1;
                effacerEcran;
                dessinerCadreXY(40,30,159,40,double,White,Black);
                deplacerCurseurXY(75,32);
                write('Sur quel emplacement veux-tu le planter ?');
                deplacerCurseurXY(45,35);
                choix2:=ChoixEmplacement();
                AddSeed(choix2,getInventory[choix1].iType);
                effacerEcran;
                FermeIHM;
            end;
        2:
            begin
                EffaceRuban();
                dessinerCadreXY(40,30,130,40,double,White,Black);
                deplacerCurseurXY(75,32);
                write('Quel emplacement veux-tu arroser ?');
                deplacerCurseurXY(45,35);
                choix2:=ChoixEmplacement();
                arrose(choix2);
                if getFerme[choix2].arrose =false then 
                    begin
                        dessinerCadreXY(40,30,130,40,double,White,Black);
                        deplacerCurseurXY(75,35);
                        write('Impossible d''arroser un emplacement vide');
                        readln;
                    end;
                effacerEcran;
                FermeIHM();
            end;
        3:
            begin
                effacerEcran;
                dessinerCadreXY(40,30,159,40,double,White,Black);
                deplacerCurseurXY(75,32);
                write('Quel emplacement veux tu ramasser ?');
                deplacerCurseurXY(45,35);
                choix2:=ChoixEmplacement();
                if (EstVide(choix2)) or (getFerme[choix2].joursRestant>0) then
                    begin
                        effacerEcran;
                        dessinerCadreXY(40,30,159,40,double,White,Black);
                        deplacerCurseurXY(85,35);
                        write('Emplacement vide ou pas mûr');
                        attendrems(2000);
                        effacerEcran;
                    end
                else
                    begin
                        Ramasse(choix2);
                    end;
                FermeIHM;
            end;
    end;
end;


// Ferme : procédure qui lance chaque choix possible dans la ferme
procedure Ferme();
var 
    choix:Integer;
begin
    choix:=BatimentChoix();
    case choix of 
        1:MaisonIHM;
        2:ShopIHM;
        3:RubanEmplacement();
        4:arroseTout();
        9:debutPartie();
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
        7:ShopIHM
    end;
end;
// Shop : procédure qui lance chaque choix possible dans le shop
procedure Shop();
var 
    choix:Integer;
begin
    choix:=BatimentChoix();
    case choix of 
        1:FermeIHM;
        2:rubanMenuachete;
        3:vendre();
        9:debutPartie();
    end;
end;
end.