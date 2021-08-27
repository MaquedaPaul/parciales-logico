%Sueños
%Consigna en:
%https://docs.google.com/document/d/1QcIfJEvOb-oxIFH4jeXEfiVTgMFQa00V0nvF11wIEAg/edit

% Punto 1:
% Generar base de conocimiento.
cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, magoCapria).
cree(macarena, campanita).

% sueños:
% sercantante(discosVendidos).
% serFutbolista(equipo).
% ganarLoteria([numeros]).
sueña(gabriel, ganarLoteria([5, 9])).
sueña(gabriel, serFutbolista(arsenal)).
sueña(juan, serCantante(100000)).
sueña(macarena, serCantante(10000)).

%Punto 2
%Queremos saber si una persona es ambiciosa, esto ocurre cuando la suma 
% de dificultades de los sueños es mayor a 20. 
%La dificultad de cada sueño se calcula como:
%   - 6 para ser un cantante que vende más de 500.000 ó 4 en caso contrario
%   - ganar la lotería implica una dificultad de 10 * la cantidad de los números apostados
%   - lograr ser un futbolista tiene una dificultad de 3 en equipo chico o 
%        16 en caso contrario. 
%Arsenal y Aldosivi son equipos chicos.

esAmbicioso(Persona):-
    ambiciones(Persona, DificultadSueños),
    sum_list(DificultadSueños, DificultadTotal),
    DificultadTotal > 20.

ambiciones(Persona, DificultadSueños):-
    sueña(Persona,_),
    findall(Dificultad, 
        (sueña(Persona, Sueño), dificultadSueño(Sueño, Dificultad)),
        DificultadSueños).

dificultadSueño(serCantante(Cantidad), 6):-
    Cantidad > 500000.
dificultadSueño(serCantante(Cantidad), 4):-
    Cantidad =< 500000.
dificultadSueño(ganarLoteria(Lista), Dificultad):-
    length(Lista, Cantidad),
    Dificultad is Cantidad * 10.
dificultadSueño(serFutbolista(Equipo), 3):-
    esEquipoChico(Equipo).
dificultadSueño(serFutbolista(Equipo), 16):-
    not(esEquipoChico(Equipo)).

esEquipoChico(arsenal).
esEquipoChico(aldosivi).


% Punto 3
% Queremos saber si un personaje tiene química con una persona. Esto se da
% si la persona cree en el personaje y...
%   - para Campanita, la persona debe tener al menos un sueño de dificultad menor a 5.
%   - para el resto, 
%       - todos los sueños deben ser puros (ser futbolista o cantante de menos de 200.000 discos)
%       - y la persona no debe ser ambiciosa

tieneQuimica(Persona, campanita):-
    cree(Persona, campanita),
    sueña(Persona, Sueño),
    dificultadSueño(Sueño, Dificultad),
    Dificultad < 5.
tieneQuimica(Persona, Personaje):-
    cree(Persona, Personaje),
    Personaje \= campanita,
    todosSusSueñosSonPuros(Persona),
    not(esAmbicioso(Persona)).

todosSusSueñosSonPuros(Persona):-
    forall(sueña(Persona, Sueño), esPuro(Sueño)).

esPuro(serFutbolista(_)).
esPuro(serCantante(Discos)):-
    Discos < 200000.

%Punto 4 (2 puntos)
%Sabemos que
%Campanita es amiga de los Reyes Magos y del Conejo de Pascua
%el Conejo de Pascua es amigo de Cavenaghi, entre otras amistades
amigos(campanita, reyesMagos).
amigos(campanita, conejoDePascua).
amigos(conejoDePascua, cavenaghi).

estaEnfermo(conejoDePascua).
estaEnfermo(campanita).
estaEnfermo(reyesMagos).

puedeAlegrar(Persona, Personaje):-
    sueña(Persona, _),
    tieneQuimica(Persona, Personaje),
    personajeDisponible(Personaje).

personajeDisponible(Personaje):-
    cree(_, Personaje),
    not(estaEnfermo(Personaje)).
personajeDisponible(Personaje):-
    cree(_, Personaje),
    estaEnfermo(Personaje),
    sonAmigos(Personaje, Amigo),
    personajeDisponible(Amigo).

sonAmigos(Personaje, Amigo):-
    amigos(Personaje, Amigo).
sonAmigos(Personaje, Amigo):-
    amigos(Amigo, Personaje).
