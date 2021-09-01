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




