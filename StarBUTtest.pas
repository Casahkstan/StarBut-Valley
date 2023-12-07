unit StarBUTtest;

{$codepage utf8}
{$mode objfpc}{$H+}

interface
procedure test();

implementation
uses StarBUTlogic, TestUnitaire, playerUnit, inventoryUnit, dateUnit, SeedManagmentUnit, SeedUnit, sysutils;

procedure InitialisationJoueur_Test();
var
  estVide : Boolean;
  inv : inventory;
  i : Integer;
begin
  newTestsSeries('Initialisation Joueur');
  initPlayer();
  newTest('Initialisation Joueur', 'Pseudo valide');
  testIsEqual(getName(), 'Non défini');
  newTest('Initialisation Joueur', 'Bon nombre d''xp');
  testIsEqual(getExp(), 0);
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

procedure Dates_Test();
var
  dateTest : date;
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

procedure Seeds_Test();
var 
  i,
  j : Integer;
  texte : text;
  ligneTemp,
  ligne : String;
  sameSeeds : Boolean;
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
      if not CompareMem(@(seed[i div 4, i mod 4]), @seedActuelle, SizeOf((itemType))) then
      begin
        writeln(seed[i div 4, i mod 4].rarete, ' and ', seedActuelle.rarete);
        sameSeeds := False;
      end;
      i := i + 1;
    end;
  testIsEqual(sameSeeds);
end;

procedure test();
begin
  InitialisationJoueur_Test;
  Dates_Test;
  Seeds_Test;

  Summary();
end;

end.