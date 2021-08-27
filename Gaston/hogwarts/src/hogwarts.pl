%LAS CASAS DE HOGWARTS

%consignas en: 
% https://docs.google.com/document/d/e/2PACX-1vR9SBhz2J3lmqcMXOBs1BzSt7N1YWPoIuubAmQxPIOcnbn5Ow9REYt4NXQzOwXXiUaEQ4hfHNEt3_C7/pub


%%===========================================
%%--------------PARTE 1----------------------
%%===========================================

%Punto 1:
%Saber si una casa permite entrar a un mago
%Slytherin no permite entrar a magos de sangre impura
%El resto de casas permiten entrar a cualquier mago.

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(neville, pura).
sangre(luna, pura).

permiteEntrar(Mago, slytherin):-
    sangre(Mago, Sangre),
    Sangre \= impura.
permiteEntrar(Mago, Casa) :-
    casa(Casa),
    sangre(Mago, _),
    Casa \= slytherin.


%Punto 2:
%Saber si un mago tiene el caracter adecuado para una casa.

tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, inteligencia).
tieneCaracteristica(draco, orgullo).
tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, responsabilidad).
tieneCaracteristica(neville, responsabilidad).
tieneCaracteristica(neville, coraja).
tieneCaracteristica(neville, amistad).
tieneCaracteristica(luna, amistad).
tieneCaracteristica(luna, inteligencia).
tieneCaracteristica(luna, responsabilidad).

caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistad).

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    sangre(Mago, _),
    forall(caracteristicaBuscada(Casa, Caracteristica), 
            tieneCaracteristica(Mago, Caracteristica)).


%Punto 3.
%saber enq ue casa podria ser seleccionado un mago.
odiariaQuedarEn(draco, hufflepuff).
odiariaQuedarEn(harry, slytherin).

puedeQuedarSeleccionado(hermione, gryffindor).
puedeQuedarSeleccionado(Mago, Casa):-
    tieneCaracterApropiado(Mago, Casa),
    permiteEntrar(Mago, Casa),
    not(odiariaQuedarEn(Mago, Casa)).

%Punto 4
%desarrollar cadena de amistades.

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).

todosAmistosos(Magos):-
    forall(member(Mago, Magos), amistoso(Mago)).  

amistoso(Mago):-
    tieneCaracteristica(Mago, amistad).

cadenaDeCasas(Magos):-
    forall(consecutivos(Mago1, Mago2, Magos), puedenQuedarEnLaMismaCasa(Mago1, Mago2)).

consecutivos(Anterior, Siguiente, Lista) :-
    nth1(IndiceAnterior, Lista, Anterior),
    IndiceSiguiente is IndiceAnterior + 1,
    nth1(IndiceSiguiente, Lista, Siguiente).
    
puedenQuedarEnLaMismaCasa(Mago1, Mago2):-
    puedeQuedarSeleccionado(Mago1, Casa),
    puedeQuedarSeleccionado(Mago2, Casa),
    Mago1 \= Mago2.



%%===========================================
%%--------------PARTE 2----------------------
%%===========================================

%Punto 1,a
%Saber si un alumno es buen alumno.

hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, buenaAccion(50, ganarAlAjedrezMagico)).
hizo(hermione, buenaAccion(60, salvarASusAmigos)).
hizo(harry, buenaAccion(60,ganarleAVoldemort)).
hizo(cedric, buenaAccion(100, ganarAlQuidditch)).
hizo(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermione, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).


hizoAlgunaAccion(Mago):-
    hizo(Mago, _).

hizoAlgoMalo(Mago):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntaje),
    Puntaje < 0.

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(irA(Lugar), Puntaje):-
    lugarProhibido(Lugar, Puntaje).
puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).
puntajeQueGenera(responderPregunta(_, Dificultad, snape), Puntaje):-
    Puntaje is Dificultad / 2.
puntajeQueGenera(responderPregunta(_, Dificultad, Profesor), Puntaje):-
    Profesor \= snape,
    Dificultad = Puntaje.

lugarProhibido(bosque, -50).
lugarProhibido(seccionRestringida, -10).
lugarProhibido(tercerPiso, -75).

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).

%Punto 1,b
%Saber si una accion es recurrente, que se cumple si mas de un mago hizo la misma accion
esRecurrente(Accion):-
    hizo(Mago, Accion),
    hizo(Mago2, Accion),
    Mago \= Mago2.

%Punto 2
%Saber cual es el puntaje total de una casa, 
%que es la suma de los puntos obtenidos por todos sus miembros.
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric, hufflepuff).

puntajeTotal(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntos, 
                (esDe(Mago, Casa), 
                hizo(Mago, Accion), 
                puntajeQueGenera(Accion, Puntos)), 
                ListaPuntos),
    sum_list(ListaPuntos, PuntajeTotal).
        
%Punto 3
% saber cual es la casa ganadora de la copa.
casaGanadora(Casa):-
    puntajeTotal(Casa, PuntajeMayor),
    forall((puntajeTotal(OtraCasa, PuntajeMenor), OtraCasa \= Casa),
            PuntajeMayor > PuntajeMenor).
