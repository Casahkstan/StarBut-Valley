unit StarBUTtest;

{$codepage utf8}
{$mode objfpc}{$H+}

interface
procedure test();

implementation
uses StarBUTlogic, TestUnitaire, playerUnit, inventoryUnit;

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
end;

procedure Dates_Test();
begin
  
end;

procedure test();
begin
  InitialisationJoueur_Test;


  Summary();
end;

end.