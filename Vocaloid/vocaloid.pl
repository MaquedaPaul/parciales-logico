

canta(megurineLuka, cancion(nightFever,4)).
canta(megurineLuka, cancion(foreverYoung,5)).

canta(hatsuneMiku, cancion(tellYourWorld,4)).

canta(gumi, cancion(foreverYoung,4)).
canta(gumi, cancion(tellYourWorld,5)).

canta(seeU, cancion(novemberRain,6)).
canta(seeU, cancion(nightFever,5)).

%No es novedoso:
canta(juancito, cancion(hola,16)).

canta(carlos, cancion(hola,6)).
canta(carlos, cancion(hola,10)).
canta(carlos, cancion(hola,20)).
%-----------------------

%Punto 1
esNovedoso(Vocaloid):-
    distinct(Vocaloid, esNovedosoSub(Vocaloid)).

esNovedosoSub(Vocaloid):-
    cantaAlMenosDos(Vocaloid),
    duracionDeTodasLasCanciones(Vocaloid, TotalDuracion),
    TotalDuracion < 15.

duracionDeTodasLasCanciones(Vocaloid, TotalDuracion):-
    canta(Vocaloid,_),
    findall(Duracion, canta(Vocaloid, cancion(_,Duracion)), Duraciones),
    sum_list(Duraciones, TotalDuracion).



duracion(cancion(_,Duracion), Duracion).

cantaAlMenosDos(Vocaloid):-
    canta(Vocaloid, Cancion),
    canta(Vocaloid, OtraCancion),
    Cancion \= OtraCancion.

cantaMasDe(Cantidad, Vocaloid):-
    canta(Vocaloid,_),
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, TotalDeCanciones),
    TotalDeCanciones > Cantidad.

cancionesTotalesQueCanta(Vocaloid, Cantidad):-
    canta(Vocaloid,_),
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, Cantidad).


%Punto 2
esAcelerado(Vocaloid):-
    canta(Vocaloid,_),
    not(cantaCancionesLargas(Vocaloid)).


cantaCancionesLargas(Vocaloid):-
    canta(Vocaloid,cancion(_,Duracion)),
    Duracion > 4.

%concierto(Nombre, Pais, Fama, Tipo).

esConcierto(concierto(mikuExpo, estadosUnidos, 2000, gigante)).
esConcierto(concierto(magicalMirai, japon, 3000, gigante)).
esConcierto(concierto(vocalektVisions, estadosUnidos, 1000, mediano)).
esConcierto(concierto(mikuFest, argentina, 100, pequenio)).


%No funciona distinct en este caso.
puedeParticiparEn(Vocaloid, Concierto):-
        distinct(Vocaloid, puedeParticiparEnSub(Vocaloid, Concierto)).

puedeParticiparEnSub(hatsuneMiku, Concierto):-
    esConcierto(Concierto).

puedeParticiparEnSub(Vocaloid,
    concierto(mikuExpo, estadosUnidos, 2000, gigante)):-
        canta(Vocaloid,_),
        cancionesTotalesQueCanta(Vocaloid, Cantidad),
        Cantidad > 2,
        duracionDeTodasLasCanciones(Vocaloid, Duracion),
        Duracion >= 6.

puedeParticiparEnSub(Vocaloid,
    concierto(magicalMirai, japon, 3000, gigante)):-
        cancionesTotalesQueCanta(Vocaloid, Cantidad),
        Cantidad > 3,
        duracionDeTodasLasCanciones(Vocaloid, Duracion),
        Duracion >= 10.

puedeParticiparEnSub(Vocaloid,
    concierto(vocalektVisions, estadosUnidos, 1000, mediano)):-
        canta(Vocaloid,_),
        duracionDeTodasLasCanciones(Vocaloid, Duracion),
        Duracion =< 9.

puedeParticiparEnSub(Vocaloid,
    concierto(mikuFest, argentina, 100, pequenio)):-
        canta(Vocaloid,_),
        cantaCancionesLargas(Vocaloid).




%Con que sepa una cancion larga cumple la condicion, además cualquier otra canción que cante
%va a ser corta o larga, es indistinto.

%Punto 3

fama(concierto(_,_,Fama,_),Fama).

nivelDeFama(Vocaloid, Nivel):-
    canta(Vocaloid,_),
    findall(Fama, (puedeParticiparEn(Vocaloid, Concierto),
     fama(Concierto, Fama)), ListaDeFamasPorConcierto),
     sum_list(ListaDeFamasPorConcierto, FamaTotal),
    cancionesTotalesQueCanta(Vocaloid, Cantidad),
    Nivel is Cantidad * FamaTotal.


vocaloidMasFamoso(Vocaloid):-
    nivelDeFama(Vocaloid, Nivel),
    forall((nivelDeFama(OtroVocaloid, OtroNivel), Vocaloid \= OtroVocaloid), Nivel > OtroNivel).


%Punto 4

%conoceA(Vocaloid, Conocido).
conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).

conoceA(gumi, seeU).
conoceA(seeU, jorgito).
conoceA(jorgito, pedrito ).
conoceA(pedrito, carlos).
conoceA(megurineLuka, kaito).

esElUnicoQueParticipaEn(Vocaloid, Concierto):-
    puedeParticiparEn(Vocaloid, Concierto),
    forall((cadenaDeConocidos(Vocaloid, Conocidos),
    member(Conocido, Conocidos)),
    not(puedeParticiparEn(Conocido, Concierto))).

cadenaDeConocidos(Vocaloid, [Conocido | Conocidos]):-
    conoceA(Vocaloid, Conocido),
    Vocaloid \= Conocido,
    cadenaDeConocidos(Conocido, Conocidos).
cadenaDeConocidos(_, []).



%Conocido directo
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, OtroCantante).

%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, UnCantante), 
conocido(UnCantante, OtroCantante).




%Punto 5
/*
En la solución planteada habría que agregar una claúsula en el predicado cumpleRequisitos/2  que tenga en cuenta el nuevo functor con sus respectivos requisitos 

El concepto que facilita los cambios para el nuevo requerimiento es el polimorfismo, que nos permite dar un tratamiento en particular a cada uno de los conciertos en la cabeza de la cláusula.
*/






