%Punto 1
%creeEn(Persona, Creencia).

creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).

creeEn(juan, conejoDePascua).

creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

persona(macarena).
persona(juan).
persona(gabriel).
persona(diego).

%suenio(Suenio, Persona).
%suenio(ser(Cantante, #Discos), Persona).
%suenio(ser(Futbolista, Equipo), Persona).
%suenio(ganar(Loteria,numeros(UnNumero,OtroNumero)), Persona).

suenio(ganar(loteria, [5,9]), gabriel).
suenio(ser(futbolista, arsenal), gabriel).

suenio(ser(cantante, 100000), juan).

suenio(ser(cantante(erucaSativa), 10000), macarena).

%Punto 2

esAmbicioso(Persona):-
    suenio(_, Persona),
    findall(Dificultad, (suenio(Suenio, Persona), dificultadQueGenera(Suenio, Dificultad)), Dificultades),
    sum_list(Dificultades, TotalDificultad),
    TotalDificultad > 20.

dificultadQueGenera(ser(cantante, CantidadDiscosVendidos), Dificultad):-
    CantidadDiscosVendidos > 500000,
    Dificultad is 6.

dificultadQueGenera(ser(cantante, CantidadDiscosVendidos), Dificultad):-
    CantidadDiscosVendidos =< 500000,
    Dificultad is 4.

dificultadQueGenera(ganar(loteria, Numeros), Dificultad):-
    length(Numeros, CantidadDeNumerosApostados),
    Dificultad is 10 * CantidadDeNumerosApostados.

dificultadQueGenera(ser(futbolista, Equipo), Dificultad):-
    equipoChico(Equipo),
    Dificultad is 3.

dificultadQueGenera(ser(futbolista, Equipo), Dificultad):-
    not(equipoChico(Equipo)),
    Dificultad is 16.

%equipoGrande().
equipoChico(arsenal).
equipoChico(aldosivi).


tieneQuimica(Persona, campanita):-
    creeEn(Persona, campanita),
    suenio(Suenio, Persona),
    dificultadQueGenera(Suenio, Dificultad),
    Dificultad < 5.

tieneQuimica(Persona, Personaje):-
    creeEn(Persona, Personaje),
    forall(suenio(Suenio, Persona), esPuro(Suenio)),
    not(esAmbicioso(Persona)).


esPuro(ser(futbolista,_)).
esPuro(ser(cantante,CantidadDiscosVendidos)):-
    CantidadDiscosVendidos < 200000.

esPuro(ser(cantante(_),CantidadDiscosVendidos)):-
    CantidadDiscosVendidos < 200000.

%Punto 4

amigos(Persona, Amigo):-
    esAmigoDe(Persona, Amigo).

amigos(Persona, Amigo):-
    esAmigoDe(Amigo, Persona).

esAmigoDe(campanita, reyesMagos).
esAmigoDe(campanita, conejoDePascua).

esAmigoDe(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona):-
    tieneSuenioYQuimicaCon(Persona, Personaje),
    not(estaEnfermo(Personaje)).

puedeAlegrar(Personaje, Persona):-
    tieneSuenioYQuimicaCon(Persona, Personaje),
    cadenaDeAmigos(Personaje, Amigos),
    member(Amigo, Amigos), 
    not(estaEnfermo(Amigo)).


cadenaDeAmigos(Persona, [Amigo | Amigos]):-
    esAmigoDe(Persona, Amigo),
    Persona \= Amigo,
    cadenaDeAmigos(Amigo, Amigos).

cadenaDeAmigos(_, []).

tieneSuenioYQuimicaCon(Persona, Personaje):-
    suenio(_, Persona),
    tieneQuimica(Persona, Personaje).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

