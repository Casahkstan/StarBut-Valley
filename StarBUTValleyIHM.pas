unit StarBUTValleyIHM;
{$codepage utf-8}
interface


// debutPartie : procedure qui debute une partie 
procedure debutPartie();

implementation

uses GestionEcran,StarBUTlogic,playerUnit,SeedManagmentUnit;

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

//Affiche un message au centre de l'écran
procedure affichageMessage(message : String);
begin
  dessinerCadreXY(29, 10, 90, 14, double, black, white);
  deplacerCurseurXY(59-(length(message) div 2), 12);
  write(message);
  readln();
end;

// menuDepartIHM : IHM du menu de debut 
function menuDepartIHM() : Boolean;
var 
  choix:Boolean;
begin
  effacerEcran();
  dessinerCadreXY(61,5,171,49,simple,White,Black);
  afficheLogo(81,6);
  deplacerCurseurXY(90,28);
  write('1 - Nouvelle partie');
  deplacerCurseurXY(120,28);
  write('0 - Quitter');
  choix:=choixMenuPrincipal();
  menuDepartIHM:=choix;
end;

// FermeIHM : procedure qui affiche l'interface de la ferme
procedure FermeIHM();
begin
  effacerEcran();
  dessinerCadreXY(20,5,100,30,simple,White,Black);

end;

// debutPartie : procedure qui debute une partie 
procedure debutPartie();
var 
  choix:Boolean;
begin
  choix:=menuDepartIHM();
  write(choix);
  readln;
  if choix then 
    begin
      effacerEcran();
      Initpartie();
      dessinerCadreXY(70,5,150,30,double,White,Black);
      deplacerCurseurXY(62,7);
      write('Bienvenue dans votre nouvelle vie');
      deplacerCurseurXY(62,8);
      write('Vous avez decidé de rejoindre une ferme');
      deplacerCurseurXY(62,9);
      write('Vous êtes ....');
      deplacerCurseurXY(62,25);
      write('Votre nom : ');
      EcrisNom();
      deplacerCurseurXY(62,11);
      write('Votre ferme s''apelle ....');
      deplacerCurseurXY(62,25);
      write('Votre nom de ferme : ');
      EcrisFerme();
      effacerEcran();
      dessinerCadreXY(10,10,90,14,simple,White,Black);
      deplacerCurseurXY(62,12);
      write('Bienvenue',getName,' ',getNomFerme);
      affichageMessage('Vous arrivez dans votre ferme');
      FermeIHM();
    end;
end;


end.