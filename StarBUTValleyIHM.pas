unit StarBUTValleyIHM;
{$codepage utf-8}
interface

{ CADRE : 235 par 60 }
// debutPartie : procedure qui debute une partie 
procedure debutPartie();

//RubanEmplacement : procedure qui affiche le ruban quand le joueur choisit de rentrer dans un emplacement
procedure RubanEmplacement();

// FermeIHM : procedure qui affiche l'interface de la ferme
procedure FermeIHM();

// afficheLogo : procedure permettant d'afficher le logo
procedure afficheLogo(x,y:Integer);

// MaisonIHM : procedure qui affiche l'interface de la ferme
procedure MaisonIHM();


// affichePierre : procedure permettant d'afficher pierre
procedure affichePierre(x,y:Integer); 

//EffaceRuban
procedure EffaceRuban();

// ShopIHM : procedure qui affiche l'interface de la ferme
procedure ShopIHM();

//RubanMenuAchete : procedure qui affiche le ruban quand le joueur choisit de rentrer dans un MenuAchete
procedure RubanMenuAchete();

//Affiche un message au centre de l'écran
procedure affichageMessage(x1,x2,y1,y2:Integer;message : String);

// ecranFin :  procedure qui affiche l'ecran de fin
procedure ecranFin();

implementation
uses GestionEcran,StarBUTlogic,playerUnit,SeedManagmentUnit,sysutils,dateUnit,weatherUnit,SeedUnit;
// ecranFin :  procedure qui affiche l'ecran de fin
procedure ecranFin();
begin
  effacerEcran();
  dessinerCadreXY(25,5,135,49,simple,White,Black);
  afficheLogo(45,6);
  deplacerCurseurXY(49,40);
  write('Merci d''avoir joué');
  readln;
end;

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

// affichePierre : procedure permettant d'afficher pierre
procedure affichePierre(x,y:Integer);
var
  i : Integer;
  texte : text;
	ligne : String;
begin
  couleurFond(White);
  couleurTexte(Cyan);
  assign(texte,'./file/pierre.txt');
  reset(texte);
  for i:=0 to 39 do 
    begin
      deplacerCurseurXY(x,y+i);
      readln(texte,ligne);
      write(ligne);
    end;
  couleurTexte(Black);
  couleurFond(Black);
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
  dessinerCadreXY(60,2,112,8,double,Black,White);
  deplacerCurseurXY(80,4);
  write('Lieu : ',getNomFerme);
  deplacerCurseurXY(80,6);
  write('Temps : ',getCurrentWeather);
  couleurTexte(Black);
end;

//AfficheLieuMaison : procedure qui affiche le cadre avec le lieu actuel
procedure AfficheLieuMaison();
begin
  dessinerCadreXY(60,2,112,6,double,Black,White);
  deplacerCurseurXY(80,4);
  write('Lieu : Maison');
  couleurTexte(Black);
end;

//AfficheLieuShop : procedure qui affiche le cadre avec le lieu actuel
procedure AfficheLieuShop();
begin
  dessinerCadreXY(60,2,112,6,double,Black,White);
  deplacerCurseurXY(76,4);
  write('Lieu : Shop de Pierre');
  couleurTexte(Black);
end;

//AfficheHeure : procedure qui affiche le cadre avec l'heure et la saison
procedure AfficheHeure();
begin
  dessinerCadreXY(175,2,198,8,double,White,Black);
  deplacerCurseurXY(179,3);
  write(IntToStr(getHeureActuelle)+' heure');
  deplacerCurseurXY(179,5);
  write(getJourActuel,' ',IntToStr(getNumJour),' (',getDate().annee,')');
  deplacerCurseurXY(179,7);
  write(getSaisonName);
end;

// Refresh : procedure qui resfresh les écrans de donné
procedure refresh();
begin
  AfficheHeure;
  AffichePerso;
end;
//EffaceRuban
procedure EffaceRuban();
var
  i,j:Integer;
begin
  for i:=0 to 7 do 
    begin
      changerLigneCurseur(i+42);
      for j:=2 to 198 do
        begin
          write(' ');
          changerColonneCurseur(j);
        end;
    end;
end;

//Affiche un message au centre de l'écran
procedure affichageMessage(x1,x2,y1,y2:Integer;message : String);
begin
  dessinerCadreXY(x1,y1,x2,y2,double, black, white);
  deplacerCurseurXY(x1+1, y1+1);
  write(message);
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
  write(getFerme[num].elem.name+' '+IntToStr(num));
end;

// AfficheEmplacmentRempli : procedure qui affiche un emplacement
procedure AfficheEmplacementRempli(x,y,num:Integer);
var 
  arrose:Boolean;
  estarrose:String;
begin
  arrose:=getFerme[num].arrose;
  if arrose then 
    estarrose:='Arrosé'
  else
    estarrose:='N''est pas arrosé';
  deplacerCurseurXY(x,y);
  write(getFerme[num].elem.name+' '+'(temps restant :'+IntToStr(getFerme[num].joursRestant)+') '+estarrose);
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
            AfficheEmplacementRempli(10+i*70,10+j*3,j+i*10)
          else
            AfficheEmplacementVide(10+i*70,10+j*3,j+i*10);
        end;
    end;
  couleurTexte(White);
end;

// rubanBasFerme : procedure qui affiche le ruban en bas de l'écran
procedure rubanBasFerme();
begin
  EffaceRuban();  
  deplacerCurseurXY(5,45);
  write('1 - Aller à la maison');
  deplacerCurseurXY(35,45);
  write('2 - Aller au shop');
  deplacerCurseurXY(65,45);
  write('3 - Aller sur un emplacement');
  deplacerCurseurXY(105,45);
  write('4 - Tout arroser');
  deplacerCurseurXY(135,45);
  write('9 - Revenir au menu principal');
  deplacerCurseurXY(10,47);
  Ferme();
  deplacerCurseurXY(10,47);
  write(' ');
  refresh();
  rubanBasFerme();
end;

// rubanBasMaison : procedure qui affiche le ruban en bas de l'écran
procedure rubanBasMaison();
begin
  EffaceRuban();  
  deplacerCurseurXY(5,45);
  write('1 - Aller à la ferme');
  deplacerCurseurXY(35,45);
  write('2 - Attendre 1 heure');
  deplacerCurseurXY(65,45);
  write('3 - Dormir');
  deplacerCurseurXY(95,45);
  write('4 - Regarder la météo');
  deplacerCurseurXY(125,45);
  write('9 - Revenir au menu principal');
  deplacerCurseurXY(10,47);
  Maison();
  deplacerCurseurXY(10,47);
  write(' ');
  refresh();
  rubanBasMaison();
end;

// rubanBasShop : procedure qui affiche le ruban en bas de l'écran
procedure rubanBasShop();
begin
  EffaceRuban();  
  deplacerCurseurXY(5,45);
  write('1 - Aller à la ferme');
  deplacerCurseurXY(35,45);
  write('2 - Acheter');
  deplacerCurseurXY(60,45);
  write('3 - Vendre');
  deplacerCurseurXY(125,45);
  write('9 - Revenir au menu principal');
  deplacerCurseurXY(10,47);
  Shop();
  deplacerCurseurXY(10,47);
  write(' ');
  refresh();
  rubanBasShop;
end;

//RubanEmplacement : procedure qui affiche le ruban quand le joueur choisit de rentrer dans un emplacement
procedure RubanEmplacement();
begin
  EffaceRuban();
  deplacerCurseurXY(5,45);
  write('1 - Planter une graine');
  deplacerCurseurXY(35,45);
  write('2 - Arrosé une plante');
  deplacerCurseurXY(65,45);
  write('3 - Ramasser un  légume');
  deplacerCurseurXY(10,47);
  menuEmplacement();
  deplacerCurseurXY(10,47);
  write(' ');
  RubanEmplacement();
end;

//RubanMenuAchete : procedure qui affiche le ruban quand le joueur choisit de rentrer dans un MenuAchete
procedure RubanMenuAchete();
begin
  EffaceRuban();
  deplacerCurseurXY(5,45);
  write('1 - ',getSeed[0].name);
  deplacerCurseurXY(25,45);
  write('2 - ',getSeed[1].name);
  deplacerCurseurXY(45,45);
  write('3 - ',getSeed[2].name);
  deplacerCurseurXY(65,45);
  write('4 - ',getSeed[3].name);
  deplacerCurseurXY(85,45);
  write('5 - Améliore ton sac');
  deplacerCurseurXY(115,45);
  write('6 - Description des graines');
  deplacerCurseurXY(145,45);
  write('7 - Retour au Shop');
  deplacerCurseurXY(10,47);
  menuachete;
  write(' ');
  refresh;
  RubanMenuAchete;
end;

// FermeIHM : procedure qui affiche l'interface de la ferme
procedure FermeIHM();
begin
  effacerEcran();
  dessinerCadreXY(1,1,199,50,simple,White,Black);
  AfficheLieuFerme;
  Refresh;
  AfficheAllEmplacement;
  EffaceRuban;
  rubanBasFerme;
end;

// MaisonIHM : procedure qui affiche l'interface de la ferme
procedure MaisonIHM();
begin
  effacerEcran();
  dessinerCadreXY(1,1,199,50,simple,White,Black);
  AfficheLieuMaison;
  Refresh;
  deplacerCurseurXY(25,25);
  write('Bienvenue chez vous !');
  deplacerCurseurXY(25,27);
  write('Votre lit et votre télé vous attendent...');
  EffaceRuban;
  rubanBasMaison;
end;

// ShopIHM : procedure qui affiche l'interface de la ferme
procedure ShopIHM();
begin
  heureSuivante;
  effacerEcran();
  dessinerCadreXY(1,1,199,50,simple,White,Black);
  AfficheLieuShop;
  Refresh;
  deplacerCurseurXY(25,20);
  write('Bienvenue dans le magasin de Pierre !');
  deplacerCurseurXY(25,22);
  write('Il a de nombreux produits à vous proposer');
  deplacerCurseurXY(25,24);
  write('Vous pouvez acheter ou vendre des produits');
  deplacerCurseurXY(25,26);
  write('Vous pouvez aussi avoir une description des graines');
  EffaceRuban;
  rubanBasShop;
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
      dessinerCadreXY(26,10,114,14,double, black, white);
      deplacerCurseurXY(50,12);
      write('Bienvenue '+getName+' dans votre ferme : '+getNomFerme);
      readln();
      effacerEcran();
      dessinerCadreXY(26,10,114,14,double, black, white);
      deplacerCurseurXY(56,12);
      write('Vous arrivez dans votre ferme');
      readln();
      FermeIHM();
    end
  else
  begin
    ecranFin;
  end;
end;
end.