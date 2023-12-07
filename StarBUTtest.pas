unit StarBUTtest;

{$codepage utf8}
{$mode objfpc}{$H+}

interface
procedure test();

implementation
uses StarBUTlogic, TestUnitaire, playerUnit, inventoryUnit, dateUnit;

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


procedure test();
begin
  InitialisationJoueur_Test;
  Dates_Test;

  Summary();
end;

end.