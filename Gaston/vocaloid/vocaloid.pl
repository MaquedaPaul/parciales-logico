%Vocaloid
%Consignas en:
% https://docs.google.com/document/d/1xbXPZnhwyK5FSHR_oaXU4esfkTd2S-jf3rH1XLw864M/edit

%============================================================
%---------------------Parte 1 - Vocaloids--------------------
%============================================================

% sabeCantar(Vocaloid, Cancion, Duracion).
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).

sabeCantar(hatsuneMiku, cancion(tellYourWorld, 4)).

sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).

sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(nightFever, 5)).

%Punto 1, esNovedoso(Vocaloid)
%Es novedoso si: Sabe al menos 2 canciones y el tiempo total de canciones es menor a 15.
sabeAlMenosDosCanciones(Vocaloid):-
    sabeCantar(Vocaloid, UnaCancion),
    sabeCantar(Vocaloid, OtraCancion),
    UnaCancion \= OtraCancion.

tiempoTotalCanciones(Vocaloid, TiempoTotal):-
    sabeCantar(Vocaloid, _),
    findall(Duracion, tiempoDeCancion(Vocaloid, Duracion), Duraciones),
    sum_list(Duraciones, TiempoTotal).
    
tiempoDeCancion(Cantante, TiempoCancion):-
    sabeCantar(Cantante, Cancion),
    tiempo(Cancion, TiempoCancion).
tiempo(cancion(_, Tiempo), Tiempo).

esNovedoso(Vocaloid):-
    sabeAlMenosDosCanciones(Vocaloid),
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal < 15.

%Punto 2
%Saber si un vocaloid es acelerado
%Que se da cuando todas sus canciones duran 4 minutos o menos.
%Resolver sin usar forall/2

esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not((tiempoDeCancion(Vocaloid, Tiempo), Tiempo > 4)).

vocaloid(Vocaloid):-
    sabeCantar(Vocaloid, _).

%============================================================
%---------------------Parte 2 - Conciertos-------------------
%============================================================

%Punto 1, modelar los conciertos y agregar todo lo necesario a la base de conocimiento.

%concierto(nombre, lugar, fama, tamaño(requisitosSegunTamaño)).
%concierto(nombre, lugar, fama, gigante(CantidadMinimaCanciones, DuracionTotalMinima)).
%concierto(nombre, lugar, fama, mediano(DuracionTotalMaxima)).
%concierto(nombre, lugar, fama, pequeño(AlgunaCancionDebeDurarAlmenos)).

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequeño(4)).


%Punto 2
%saber si un vocaloid puede participar en un concierto

puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto, _, _, _).
puedeParticipar(Vocaloid, Concierto):-
    vocaloid(Vocaloid),
    Vocaloid \= hatsuneMiku,
    concierto(Concierto, _, _, Requisitos),
    cumpleRequisitos(Vocaloid, Requisitos).

cumpleRequisitos(Vocaloid, gigante(CantCanciones, TiempoMinimo)):-
    cantidadCanciones(Vocaloid, Cantidad),
    Cantidad >= CantCanciones,
    tiempoTotalCanciones(Vocaloid, Total),
    Total > TiempoMinimo.
cumpleRequisitos(Vocaloid, mediano(TiempoMaximo)):-
    tiempoTotalCanciones(Vocaloid, Total),
    Total < TiempoMaximo.
cumpleRequisitos(Vocaloid, pequeño(TiempoMinimo)):-
    sabeCantar(Vocaloid, Cancion),
    tiempo(Cancion, Tiempo),
    Tiempo > TiempoMinimo.

cantidadCanciones(Vocaloid, Cantidad) :- 
    findall(Cancion, sabeCantar(Vocaloid, Cancion), Canciones),
    length(Canciones, Cantidad).
    

%Punto 3
%Conocer el Vocaloid Mas famoso:
%Se calcula sumando el nivel de fama total que le dan los conciertos en los cuales puede participar.

masFamoso(Vocaloid) :- 
    nivelFamoso(Vocaloid, NivelMasFamoso),
    forall(distinct(nivelFamoso(_, Nivel)), NivelMasFamoso >= Nivel).

nivelFamoso(Vocaloid, Nivel):-
    famaTotal(Vocaloid, FamaTotal),
    cantidadCanciones(Vocaloid, Cantidad),
    Nivel is FamaTotal * Cantidad.

famaTotal(Vocaloid, FamaTotal):-
    vocaloid(Vocaloid),
    findall(Fama, distinct(famaConcierto(Vocaloid, Fama)), CantidadesFama),
    sumlist(CantidadesFama, FamaTotal).

famaConcierto(Vocaloid,Fama):-
    puedeParticipar(Vocaloid, Concierto),
    fama(Concierto, Fama).

fama(Concierto, Fama):-
    concierto(Concierto, _, Fama, _).

%Punto 5:
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoParticipanteEntreConocidos(Cantante,Concierto):- 
    puedeParticipar(Cantante, Concierto),
	not((conocido(Cantante, OtroCantante), 
    puedeParticipar(OtroCantante, Concierto))).

%Conocido directo
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, OtroCantante).

%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, UnCantante), 
conocido(UnCantante, OtroCantante).
