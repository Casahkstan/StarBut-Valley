unit StarBUTValleyIHM;
{$codepage utf-8}
interface

{ CADRE : 235 par 60 }
// debutPartie : procedure qui debute une partie 
procedure debutPartie();
procedure FermeIHM();
implementation

uses GestionEcran,StarBUTlogic,playerUnit,SeedManagmentUnit,sysutils,dateUnit;

// afficheLogo : procedure permettant d'afficher le logo
procedure afficheLogo(x,y:Integer);
var
  i : Integer;
  texte : text;
	ligne : String;
begin
  assign(texte,'./file/logo.txt');
  reset(texte);
  for i:=0 to 19 do 
    begin
      deplacerCurseurXY(x,y+i);
      readln(texte,ligne);
      write(ligne);
    end;
end;

//AffichePerso : procedure qui affiche le cadre avec les infos du personnage
procedure AffichePerso();
begin
  dessinerCadreXY(2,2,25,8,double,White,Black);
  deplacerCurseurXY(5,3);
  write('Nom : '+getName);
  deplacerCurseurXY(5,5);
  write('Argent : '+ IntToStr(getMoney));
  deplacerCurseurXY(5,7);
  write('Stamina : '+ IntToStr(getStamina));
end; 

//AfficheLieuFerme : procedure qui affiche le cadre avec le lieu actuel
procedure AfficheLieuFerme();
begin
  dessinerCadreXY(56,2,108,6,double,Black,White);
  deplacerCurseurXY(76,4);
  write('Lieu : Ferme');
  couleurTexte(Black);
end;

//AfficheHeure : procedure qui affiche le cadre avec l'heure et la saison
procedure AfficheHeure();
begin
  dessinerCadreXY(183,2,198,8,double,White,Black);
  deplacerCurseurXY(184,3);
  write(IntToStr(getHeureActuelle)+' : '+IntToStr(getMinuteActuelle));
  deplacerCurseurXY(184,5);
  write(getJourActuel);
  deplacerCurseurXY(184,7);
  write(getSaisonActuelle);
end;

// Refresh : procedure qui resfresh les écrans de donné
procedure refresh();
begin
  AfficheHeure;
  AffichePerso;
end;
//Affiche un message au centre de l'écran
procedure affichageMessage(message : String);
begin
  dessinerCadreXY(26, 10, 114, 14, double, black, white);
  deplacerCurseurXY(65-(length(message) div 2), 12);
  write(message);
  readln();
end;

// menuDepartIHM : IHM du menu de debut 
function menuDepartIHM() : Boolean;
var 
  choix:Boolean;
begin
  effacerEcran();
  dessinerCadreXY(25,5,135,49,simple,White,Black);
  afficheLogo(45,6);
  deplacerCurseurXY(54,40);
  write('1 - Nouvelle partie');
  deplacerCurseurXY(94,40);
  write('0 - Quitter');
  deplacerCurseurXY(36,48);
  choix:=choixMenuPrincipal();
  menuDepartIHM:=choix;
end;

// AfficheEmplacmentVide : procedure qui affiche un emplacement
procedure AfficheEmplacementVide(x,y,num:Integer);
begin
  deplacerCurseurXY(x,y);
  write(getFerme[num].elem.name);
end;

// AfficheEmplacmentRempli : procedure qui affiche un emplacement
procedure AfficheEmplacementRempli(x,y,num:Integer);
begin
  deplacerCurseurXY(x,y);
  write(getFerme[num].elem.name+'('+IntToStr(getFerme[num].joursRestant)+')');
end;

// AfficheAllEmplacement : procedure qui affiche tous les emplacemnts
procedure AfficheAllEmplacement();
var 
  i,j:Integer;
begin
  couleurTexte(LightGreen);
  for i:=0 to 2 do
    begin
      for j:=1 to 10 do 
        begin
          if  not EstVide(j+i*10) then 
            AfficheEmplacementRempli(10+i*70,10+j*4,j+i*10)
          else
            AfficheEmplacementVide(10+i*70,10+j*4,j+i*10);
        end;
    end;
  couleurTexte(White);
end;
// FermeIHM : procedure qui affiche l'interface de la ferme
procedure FermeIHM();
begin
  effacerEcran();
  dessinerCadreXY(1,1,199,60,simple,White,Black);
  AfficheLieuFerme;
  Refresh;
  AfficheAllEmplacement;
end;

// debutPartie : procedure qui debute une partie 
procedure debutPartie();
var 
  choix:Boolean;
begin
  choix:=menuDepartIHM();
  if choix then 
    begin
      effacerEcran();
      Initpartie();
      dessinerCadreXY(34,5,126,30,double,White,Black);
      deplacerCurseurXY(46,7);
      write('Bienvenue dans votre nouvelle vie');
      deplacerCurseurXY(46,8);
      write('Vous avez decidé de rejoindre une ferme');
      deplacerCurseurXY(46,9);
      write('Vous êtes ....');
      deplacerCurseurXY(46,25);
      write('Votre nom : ');
      EcrisNom();
      deplacerCurseurXY(46,11);
      write('Votre ferme s''apelle ....');
      deplacerCurseurXY(46,25);
      write('Votre nom de ferme : ');
      EcrisFerme();
      effacerEcran();
      deplacerCurseurXY(26,12);
      affichageMessage('Bienvenue '+getName+' dans votre ferme : '+getNomFerme);
      effacerEcran();
      affichageMessage('Vous arrivez dans votre ferme');
      FermeIHM();
    end;
end;


end.