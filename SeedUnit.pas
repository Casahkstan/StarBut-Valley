unit SeedUnit;

interface
    uses weatherUnit;

    //type pour créer une graine
    type   
    Saison=Array [1..4] of String;
        
    // Init : procedure mettant les graines de saison dans les 4 saisons
    procedure graineSaison(saison:TSaison);

    // Description : Procédure donnant une description de chaque graine 
    procedure Description(graine : String);

    // Getter : Retourne les graines de saison du joueur
    // ⚠️ Ne peut pas être utiliser pour modifier des variables
    function getSeed():Saison;


implementation

    var 
        seedSaison:Saison;

    // Init : procedure mettant les graines de saison disponible avec la saison en paramètre
    procedure graineSaison(saison:TSaison);
    begin
        case saison of
            Hiver:
                begin
                    seedSaison[1]:='carotte';
                    seedSaison[2]:='epinard';
                    seedSaison[3]:='chou';
                    seedSaison[4]:='poireau';
                end;     
            Ete:
                begin
                    seedSaison[1]:='tomate';
                    seedSaison[2]:='poivron';
                    seedSaison[3]:='haricot';
                    seedSaison[4]:='concombre';
                end;
            Printemps:
                begin
                    seedSaison[1]:='asperge';
                    seedSaison[2]:='pois';
                    seedSaison[3]:='radis';
                    seedSaison[4]:='ail';
                end;
            Automne:
                begin
                    seedSaison[1]:='brocolis';
                    seedSaison[2]:='citrouille';
                    seedSaison[3]:='mache';
                    seedSaison[4]:='oignon';
                end;
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
        getSeed:=seedSaison;
    end;


end.