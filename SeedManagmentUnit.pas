unit SeedManagmentUnit;
{$codepage utf-8}
interface
type 
    Etat = (graine,pousse,mature);

    slot = record 
        itemType
// Init : Initialise les 30 emplacements de notre ferme
procedure initGarden();

implementation


