

canta(megurineLuka, cancion(nightFever,4)).
canta(megurineLuka, cancion(foreverYoung,5)).

canta(hatsuneMiku, cancion(tellYourWorld,4)).

canta(gumi, cancion(foreverYoung,4)).
canta(gumi, cancion(tellYourWorld,5)).

canta(seeU, cancion(novemberRain,6)).
canta(seeU, cancion(nightFever,5)).


esNovedoso(Vocaloid):-
    cantaAlMenosDos(Vocaloid),
    findall(Duracion, canta(Vocaloid, cancion(_,Duracion)), Duraciones),
    Duraciones < 15.

duracion(cancion(_,Duracion), Duracion).

cantaAlMenosDos(Vocaloid):-
    canta(Vocaloid, Cancion),
    canta(Vocaloid, OtraCancion),
    Cancion \= OtraCancion.

