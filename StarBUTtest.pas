unit StarBUTtest;

{$codepage utf8}
{$mode objfpc}{$H+}

interface

// Réalise l'ensemble des tests unitaires
procedure test();

implementation
uses StarBUTlogic, TestUnitaire, playerUnit, inventoryUnit, dateUnit, SeedManagmentUnit, SeedUnit, sysutils;

// Retourne true si les 2 records sont similaires
function compareRec(s1, s2 : itemType) : Boolean;
begin
  if (s1.name = s2.name) and (s1.maturite = s2.maturite) and (s1.prix = s2.prix) and (s1.rarete = s2.rarete) and (s1.saison = s2.saison) and (s1.legume = s2.legume) then
    compareRec := True
  else
    compareRec := False;
end;

// Réalise le test sur l'initialisation du joueur
procedure InitialisationJoueur_Test();
var
  estVide : Boolean;  
  inv : inventory;  // Inventaire du joueur
  i : Integer;    // Entier, parcourt l'inventaire du joueur
begin
  newTestsSeries('Initialisation Joueur');
  initPlayer();
  newTest('Initialisation Joueur', 'Pseudo valide');
  testIsEqual(getName(), 'Non défini');
  newTest('Initialisation Joueur', 'Bon nombre d''xp');
  testIsEqual(getExpLevel(), 0);
  newTest('Initialisation Joueur', 'Initialisation du sac');
  inv := getInventory;
  estVide := True;
  for i := low(inv) to high(inv) do
    if inv[i].iType.name <> 'Vide' then
      estVide := False;
  testIsEqual(estVide);
  newTest('Initialisation Joueur', 'Taille du sac');
  testIsEqual(length(getInventory), 5);
end;

// Réalise les tests sur l'unité date
procedure Dates_Test();
var
  dateTest : date;  // Date temporaire pour le test
begin
  newTestsSeries('Gestion des dates');
  initDate;
  dateTest := getDate;
  newTest('Gestion des dates', 'Passage de mois');
  setNumJour(28);
  jourSuivant;
  testIsEqual(getNumJour, 29);
  newTest('Gestion des dates', 'Saison suivante');
  testIsEqual(succ(dateTest.saison) = getSaisonActuelle);
  newTest('Gestion des dates', 'Année suivante');
  setSaisonActuelle(3);
  saisonSuivante();
  testIsEqual(getDate().annee, 2024);
  newTest('Gestion des dates', 'Changement date totale');
  dateTest.annee := 2023;
  dateTest.heure := 23;
  dateTest.minute := 0;
  dateTest.saison := 3;
  setDate(dateTest);
  setNumJour(28);
  heureSuivante();
  testIsEqual(getDate().annee, 2024);
end;

// Réalise les tests sur les graines
procedure Seeds_Test();
var 
  i,
  j : Integer;  // Entier, délimite les lignes
  texte : text; // Texte, stocke le texte du document
  ligneTemp,  
  ligne : String; // Lignes du texte
  sameSeeds : Boolean;  // True si ce sont les mêmes graines, false sinon
  seed : Seeds; 
  seedActuelle : itemType;
begin
  newTestsSeries('Test sur les graines');
  newTest('Test sur les graines', 'Initialisation graines');
  initGraines();
  assign(texte,'./file/graine.txt');
  reset(texte);
  seed := getSeeds;
  sameSeeds := True;
  i := low(seed);
  while (i < high(seed)) and (sameSeeds = True) do 
    begin
      readln(texte,ligne);
      j := LastDelimiter(',', ligne);
      ligneTemp := copy(ligne, low(ligne), j-1);
      seedActuelle.name := copy(ligneTemp, 1, LastDelimiter(',', ligneTemp)-1);
      seedActuelle.rarete := base;
      seedActuelle.saison := i div 4;
      seedActuelle.prix := StrToInt(copy(ligneTemp, LastDelimiter(',', ligneTemp)+1, high(ligneTemp)));
      seedActuelle.maturite := StrToInt(copy(ligne, j+1, high(ligne)));
      if not compareRec(seed[i div 4, i mod 4], seedActuelle) then
      begin
        writeln(seed[i div 4, i mod 4].saison, ' and ', seedActuelle.saison);
        sameSeeds := False;
      end;
      i := i + 1;
    end;
  testIsEqual(sameSeeds);
end;

// Réalise l'ensemble des tests unitaires
procedure test();
begin
  InitialisationJoueur_Test;
  Dates_Test;
  Seeds_Test;

  Summary();
end;

end.