%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Base de conocimientos inicial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 :-style_check(-discontiguous).


% anterior/2 se verifica si la primer fecha es anterior que la segunda
anterior(fecha(_, _, AnioAnterior), fecha(_, _ , Anio)):- AnioAnterior < Anio.
anterior(fecha(_, MesAnterior, Anio), fecha(_, Mes, Anio)):- MesAnterior < Mes.
anterior(fecha(DiaAnterior, Mes, Anio), fecha(Dia, Mes, Anio)):- DiaAnterior < Dia.

% categoriaDisfraz/2 relaciona un disfraz con una categoría
categoriaDisfraz(slash, musica).
categoriaDisfraz(madonna, musica).
categoriaDisfraz(madonna, sexy).
categoriaDisfraz(sailorMoon, anime).
categoriaDisfraz(hulk, cine).
categoriaDisfraz(hulk, superheroes).
categoriaDisfraz(samara, cine).
categoriaDisfraz(samara, terror).
categoriaDisfraz(elefanteRosado, llamativo).

% eligioDisfraz/3 relaciona una fiesta, una persona y el disfraz elegido para la misma
eligioDisfraz(cumpleLuli2042, jochirock, slash).
eligioDisfraz(cumpleLuli2042, jacinta2020, sailorMoon).
eligioDisfraz(jochiween42, jochirock, madonna).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Punto 1
%%La fiesta cumpleLuli2042, del 27 de Agosto de 2042 fue organizada por luli47. Fue por un cumpleaños de 13, y el disfraz elegido para el cumpleañero fue hulk.

%fiesta(nombreFiesta, fecha(dia, mes, anio), organizador, cumpleaños)

fiesta(jochiween42, fecha(1, 11 , 2042), jochirock, halloween).
fiesta(cumpleLuli2042, fecha(27, 8, 2042), luli47, cumpleanios(hulk, 13)).
fiesta(fiestaTest, fecha(1, 10, 2042), test, cumpleanios(disfrazSexy, 20)).
fiesta(primeraFiestaTest, fecha(1, 10, 2039), test, cumpleanios(hulk, 17)).
fiesta(fiestaTest2, fecha(1,5, 2040), test, halloween).

nuncaUsoDisfraz(Persona,Disfraz):-
    not(eligioDisfraz(_, Persona, Disfraz)).

leInteresaDisfraz(Persona, Disfraz):- 
    categoriaDisfraz(Disfraz,_),
    nuncaUsoDisfraz(Persona,Disfraz),
    eligioDisfraz(_,Persona,OtroDisfraz),
    esSimilar(Disfraz, OtroDisfraz).

esSimilar(Disfraz,OtroDisfraz):-
    categoriaDisfraz(Disfraz,Categoria),
    categoriaDisfraz(OtroDisfraz,Categoria),
    Disfraz \= OtroDisfraz.


%% Punto 2

anioAnterior(Anio, AnioAnterior):-
    AnioAnterior is Anio - 1.

estaDeModa(Anio, Disfraz):-
    fueMuyUsado(Anio,Disfraz),
    anioAnterior(Anio, AnioAnterior),
    not(fueMuyUsado(AnioAnterior,Disfraz)).

fueMuyUsado(Anio, Disfraz):-
    fiesta(_, fecha(_,_, Anio), _, _),
    eligioDisfraz(_, _, Disfraz),
    forall(fiesta(NombreFiesta, fecha(_,_, Anio), _, _), eligioDisfraz(NombreFiesta, _, Disfraz)).

%% Punto 3
esApropiado(Disfraz, Fiesta):-
    fiesta(Fiesta, _, _, halloween),
    categoriaDisfraz(Disfraz, terror).
esApropiado(Disfraz, Fiesta):-
    fiesta(Fiesta, _, _, halloween),
    categoriaDisfraz(Disfraz, sexy).

esApropiado(Disfraz, Fiesta):-
    fiesta(Fiesta, _, _, cumpleanios(DisfrazCumpleaniero, EdadCumpleaniero)),
    not(opacaA(Disfraz, DisfrazCumpleaniero)),
    EdadCumpleaniero >= 18.

esApropiado(Disfraz, Fiesta):-
    fiesta(Fiesta, _, _, cumpleanios(DisfrazCumpleaniero, EdadCumpleaniero)),
    not(opacaA(Disfraz, DisfrazCumpleaniero)),
    EdadCumpleaniero =< 18,
    esAdecuadoParaMenores(Disfraz).


esAdecuadoParaMenores(Disfraz):-
    not(categoriaDisfraz(Disfraz, sexy)).

opacaA(OtroDisfraz, Disfraz):-
    categoriaDisfraz(OtroDisfraz,sexy),
    not(categoriaDisfraz(Disfraz,sexy)),
    Disfraz \= OtroDisfraz.

opacaA(OtroDisfraz, Disfraz):-
    categoriaDisfraz(OtroDisfraz,llamativo),
    Disfraz \= OtroDisfraz.


% Punto 4

sugerirDisfraz(Fiesta, Persona, Disfraz):-
    eligioDisfraz(_,Persona,_),
    fiesta(Fiesta, fecha(_, _, Anio), _, _),
    estaDeModa(Anio, Disfraz),
    not(eligioDisfraz(Fiesta, Persona, _)),
    esApropiado(Disfraz, Fiesta).

sugerirDisfraz(Fiesta, Persona, Disfraz):-
    fiesta(Fiesta, _, _, _),
    leInteresaDisfraz(Persona, Disfraz),
    not(eligioDisfraz(Fiesta, Persona, _)),
    esApropiado(Disfraz, Fiesta).

%Punto 5

asistieronA(TotalDePersonas, Fiesta):-
    fiesta(Fiesta, _, _, _),
    findall(Persona, eligioDisfraz(Fiesta,Persona,_), Personas),
    length(Personas, TotalDePersonas).


%Punto 6

fueExitosa(Fiesta):-
    fiesta(Fiesta, _, _, _),
    disfracesSonApropiadosPara(Fiesta).


disfracesSonApropiadosPara(Fiesta):-
    fiesta(Fiesta, _, _, _),
    forall(eligioDisfraz(Fiesta,_,Disfraz),esApropiado(Disfraz, Fiesta)).



buenNumeroDeAsistentes(Fiesta):-
    fiesta(Fiesta, _, Persona, _),
    primeraFiestaQueOrganiza(Persona, Fiesta),
    asistieronA(TotalDePersonas, Fiesta),
    TotalDePersonas >= 10.

buenNumeroDeAsistentes(Fiesta):-
    organizoFiesta(Persona, Fiesta),
    organizoFiesta(Persona, OtraFiesta),
    not(primeraFiestaQueOrganiza(Persona, Fiesta)),
    not(hayFiestaEntre(Fiesta,OtraFiesta, Persona)),
    asistieronA(TotalDePersonasFiesta, Fiesta),
    asistieronA(TotalDePersonasOtraFiesta, OtraFiesta),
    TotalDePersonasFiesta >= TotalDePersonasOtraFiesta + 3.


hayFiestaEntre(Fiesta,OtraFiesta, Persona):-
    organizoFiesta(Persona, FiestaEnMedio),
    organizoFiesta(Persona, Fiesta),
    organizoFiesta(Persona, OtraFiesta),
    fiestaAnterior(FiestaEnMedio, OtraFiesta),
    fiestaAnterior(Fiesta, FiestaEnMedio),
    sonDiferentesFiestas(Fiesta,OtraFiesta,FiestaEnMedio).


sonDiferentesFiestas(Fiesta1,Fiesta2,Fiesta3):-
    Fiesta1 \= Fiesta2,
    Fiesta2 \= Fiesta3,
    Fiesta1 \= Fiesta3.


primeraFiestaQueOrganiza(Persona, PrimeraFiesta):-
    organizoFiesta(Persona, PrimeraFiesta),
    forall((organizoFiesta(Persona, Fiesta),
            Fiesta \= PrimeraFiesta),
            fiestaAnterior(Fiesta,PrimeraFiesta)).

organizoFiesta(Persona, Fiesta):-
    fiesta(Fiesta, _, Persona, _).

fiestaAnterior(OtraFiesta, Fiesta):-
    fiesta(Fiesta, Fecha, _, _),
    fiesta(OtraFiesta, OtraFecha, _, _),
    anterior(Fecha,OtraFecha).

%Punto 7


/*
En consecuencia del modelado de "fiesta" se facilita considerablemente la tarea de añadir nuevos tipos de fiesta, ya que solamente habría que cambiar el tipo de fiesta en "fiesta", además de añadir qué disfraces serían apropiados para ese nuevo tipo.

Por ejemplo, si quisieramos añadir el tipo de fiesta "boda", donde aclaramos quiénes se casan:
Agregaríamos a la base de conocimiento dichas fiestas:

    fiesta(bodaEjemplo, fecha(1,5,2040), pablo, boda(marido, mujer)).
    
    y agregariamos que disfraces son apropiados, por ejemplo, solo los que sean de categoria "formal"

    esApropiado(Disfraz, Fiesta):-
        fiesta(Fiesta, _, _, boda(_, _)),
        categoriaDisfraz(Disfraz, formal).

*/



/*
Pruebas realizadas

    %%%Propia base de conocimientos para ejemplos
categoriaDisfraz(freddie, musica).



eligioDisfraz(primeraFiestaTest, persona1, slash).
eligioDisfraz(primeraFiestaTest, persona2, slash).
eligioDisfraz(primeraFiestaTest, persona3, slash).
eligioDisfraz(primeraFiestaTest, persona4, slash).
eligioDisfraz(primeraFiestaTest, persona5, slash).
eligioDisfraz(primeraFiestaTest, persona6, slash).
eligioDisfraz(primeraFiestaTest, persona7, slash).
eligioDisfraz(primeraFiestaTest, persona8, slash).
eligioDisfraz(primeraFiestaTest, persona9, slash).
eligioDisfraz(primeraFiestaTest, persona10, slash).

eligioDisfraz(fiestaTest2, persona1, slash).

eligioDisfraz(fiestaTest, persona1, slash).
eligioDisfraz(fiestaTest, persona2, slash).
eligioDisfraz(fiestaTest, persona3, slash).
eligioDisfraz(fiestaTest, persona4, slash).
*/