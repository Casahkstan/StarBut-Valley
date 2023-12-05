unit SeedUnit;

interface
    uses weatherUnit;

    //type pour créer une graine
    type   
    SeedSaison=Array [0..3][0..3] of itemType;
        
    // Init : procedure mettant les graines de saison dans les 4 saisons
    procedure InitgraineSaison();

    // Description : Procédure donnant une description de chaque graine 
    procedure Description(graine : String);

    // Getter : Retourne les graines de saison du joueur
    // ⚠️ Ne peut pas être utiliser pour modifier des variables
    function getSeed():Saison;


implementation

    var 
        seedSaison:SeedSaison;

    // Init : procedure mettant les graines de saison disponible avec la saison en paramètre
    procedure InitgraineSaison();
    var 
        i,j:Integer;
        texte:text;
        ligne:String;
    begin
        assign(texte,'./file/graine.txt');
        reset(texte);
        i:=0;
        j:=0;
        for i:=0 to 3 do 
            for j:=0 to 3 do 
            begin
                readln(texte,ligne);
                seedSaison.name[i,j]:=ligne;
                seedSaison.rarete[i,j]:=base;
            end; 

            
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

    // Getter : Retourne les graines de saison du joueur
    // ⚠️ Ne peut pas être utiliser pour modifier des variables
    function getSeed():Saison;
    begin
        getSeed:=seedSaison[getNumSaison];
    end;


end.