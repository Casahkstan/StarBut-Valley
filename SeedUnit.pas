unit SeedUnit;

interface
uses weatherUnit, inventoryUnit, sysutils,dateUnit;

//type pour créer une graine
type   
seedSaison = array[0..3] of itemType;
Seeds = Array [0..3] of seedSaison;
		
// Init : procedure mettant les graines de saison dans les 4 saisons
procedure initGraines();

// Getter : Retourne les graines de saison du joueur
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getSeed() : seedSaison;

// Getter : Retourne la liste des graines
// ⚠️ Ne peut pas être utilisé pour modifier des variables
function getSeeds() : Seeds;

// Description : Procédure donnant une description de chaque graine 
procedure Description(graine : String);

// Affiche les graines et leurs caractéristiques 
procedure afficheGraines();


implementation

var 
	listeSeeds : Seeds;

// Init : procedure mettant les graines de saison disponible avec la saison en paramètre
procedure initGraines();
var 
	i,
	j : Integer;	// Entier, délimite les différentes informations
	texte : text;	// Texte, stocke les informations des graines
	ligneTemp,
	ligne : String; // Chaines de caractères, lignes du document
begin
	assign(texte,'./file/graine.txt');
	reset(texte);
	for i:=0 to 15 do 
		begin
			readln(texte,ligne);
			j := LastDelimiter(',', ligne);
			ligneTemp := copy(ligne, low(ligne), j-1);
			listeSeeds[i div 4, i mod 4].name := copy(ligneTemp, 1, LastDelimiter(',', ligneTemp)-1);
			listeSeeds[i div 4, i mod 4].rarete := base;
			listeSeeds[i div 4, i mod 4].saison := i div 4;
			listeSeeds[i div 4, i mod 4].prix := StrToInt(copy(ligneTemp, LastDelimiter(',', ligneTemp)+1, high(ligneTemp)));
			listeSeeds[i div 4, i mod 4].maturite := StrToInt(copy(ligne, j+1, high(ligne)));
			listeSeeds[i div 4, i mod 4].legume := false;
		end;
end;

// Getter : Retourne les graines de saison du joueur
// ⚠️ Ne peut pas être utilisépour modifier des variables
function getSeed() : seedSaison;
begin
	getSeed := (listeSeeds[getDate().saison]);
end;

function getSeeds() : Seeds;
begin
	getSeeds := listeSeeds;
end;

// Description : Procédure donnant une description de chaque graine 
procedure Description(graine:String);
begin
	case graine of 
		'carotte':write('Leur prix est de 5 d''or et leur temps de maturation est de 3 jours');
		'epinard':write('Leur prix est de 3 d''or et leur temps de maturation est de 2 jours');
		'chou':write('Leur prix est de 10 d''or et leur temps de maturation est de 5 jours');
		'poireau':write('Leur prix est de 2 d''or et leur temps de maturation est de 1 jours');

		'tomate':write('Leur prix est de 6 d''or et leur temps de maturation est de 3 jours');
		'poivron':write('Leur prix est de 4 d''or et leur temps de maturation est de 2 jours');
		'haricot':write('Leur prix est de 1 d''or et leur temps de maturation est de 1 jours');
		'concombre':write('Leur prix est de 9 d''or et leur temps de maturation est de 4 jours');  

		'asperge':write('Leur prix est de 5 d''or et leur temps de maturation est de 3 jours');
		'pois':write('Leur prix est de 1 d''or et leur temps de maturation est de 1 jours');
		'radis':write('Leur prix est de 4 d''or et leur temps de maturation est de 2 jours');
		'ail':write('Leur prix est de 9 d''or et leur temps de maturation est de 4 jours');

		'brocolis':write('Leur prix est de 4 d''or et leur temps de maturation est de 2 jours');
		'citrouille':write('Leur prix est de 10 d''or et leur temps de maturation est de 5 jours');
		'mache':write('Leur prix est de 5 d''or et leur temps de maturation est de 3 jours');
		'oignon':write('Leur prix est de 2 d''or et leur temps de maturation est de 1 jours');
	end;
end;

procedure afficheGraines();
var
	i : array of itemType;	// Tableau, parcourt la liste de graines
	j : Integer;	// Entier, parcourt i
begin
	for i in listeSeeds do
		for j := low(i) to high(i) do
		begin
			writeln(i[j].name, ' ', i[j].rarete, ' ', i[j].prix,' ',i[j].maturite);
		end;
end;

end.