%quedaEn(Boliche, Localidad)
quedaEn(pachuli, generalLasHeras).
quedaEn(why, generalLasHeras).
quedaEn(chaplin, generalLasHeras).
quedaEn(masDe40, sanLuis).
quedaEn(qma, caba).
%entran(Boliche, CapacidadDePersonas)
entran(pachuli, 500).
entran(why, 1000).
entran(chaplin, 700).
entran(masDe40, 1200).
entran(qma, 800).
%sirveComida(Boliche)
sirveComida(chaplin).
sirveComida(qma).

%tematico(tematica)
%cachengue(listaDeCancionesHabituales)
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina)
%Y se asocian con un boliche a partir del siguiente predicado:
%esDeTipo(Boliche, Tipo)
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel, buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).



esPiola(generalLasHeras):-
    sirveComida(generalLasHeras).

esPiola(Boliche):-
    esGrande(Boliche),
    sirveComida(Boliche).

esGrande(Boliche):-
    entran(Boliche, Personas),
    Personas > 700.


boliche(Boliche):-
    quedaEn(Boliche,_).

soloParaBailar(Boliche):-
    boliche(Boliche),
    not(sirveComida(Boliche)).

podemosIrConEsa(Localidad):-
    quedaEn(_, Localidad),
    forall(quedaEn(Boliche, Localidad), esPiola(Boliche)).

puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche, tematico(ochentoso)),
    Puntaje is 9.

puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche, tematico(Tematica)),
    Tematica \= ochentoso,
    Puntaje is 7.


puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche, electronico(_,HoraInicio,HoraFinal)),
    Puntaje is HoraFinal + HoraInicio.

puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche,
         cachengue(Canciones)),
    pasanUnaCancion(biodiesel, Canciones),
    pasanUnaCancion(buenComportamiento, Canciones),
    Puntaje is 10.

puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche,
         cachengue(Canciones)),
    not(pasanUnaCancion(biodiesel, Canciones)),
    not(pasanUnaCancion(buenComportamiento, Canciones)),
    Puntaje = "No lo sabemos".

pasanUnaCancion(Cancion, Canciones):-
    member(Cancion, Canciones).

elMasGrande(Localidad, Boliche):-
    quedaEn(Boliche, Localidad),
    entran(Boliche, Personas),
    forall((quedaEn(OtroBoliche, Localidad), OtroBoliche \= Boliche), (entran(OtroBoliche, OtrasPersonas), Personas > OtrasPersonas)).


puedeAbastecer(Localidad, Personas):-
    quedaEn(_,Localidad),
    capacidadDeUnaLocalidad(Localidad, CapacidadTotal),
    CapacidadTotal >= Personas.


capacidadDeUnBoliche(Boliche, Capacidad):-
    entran(Boliche, Capacidad).


capacidadDeUnaLocalidad(Localidad, CapacidadTotal):-
    quedaEn(_, Localidad),
    findall(Capacidad, (quedaEn(Boliche, Localidad), capacidadDeUnBoliche(Boliche, Capacidad)), Capacidades),
    sum_list(Capacidades, CapacidadTotal).

