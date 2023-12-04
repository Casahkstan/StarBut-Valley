unit SeedUnit;

interface

//type pour créer une graine
type
   seedHiver=(carotte,epinard,chou,poireau);
   seedEte=(tomate,poivron,haricot,concombre);
   seedPrintemps=(asperge,pois,radis,ail);
   seedAutomne=(brocolis,citrouille,mache,oignon);
   seedSaison=Array [1..4] of String;
    

// Description : Procédure donnant une description de chaque graine 
procedure Description(graine : String);


implementation

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


end.