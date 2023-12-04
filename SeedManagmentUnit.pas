unit SeedManagmentUnit;
{$codepage utf-8}
interface

// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();

// Plant : Place dans un des emplacement une graine passé en paramètre
procedure plant(var slot:emplacement; seed:graine);


implementation
