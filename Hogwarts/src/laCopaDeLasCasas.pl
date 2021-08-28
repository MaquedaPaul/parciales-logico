%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - La copa de las casas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 :-style_check(-discontiguous).
esDe/2.
puntajeTotalCasa/2.

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

hizo/2.

hizo(harry,accion(andarDeNoche,-50)).
hizo(hermione,irA(seccionBiblioteca)).
hizo(hermione,irA(tercerPiso)).
hizo(harry,irA(bosque)).
hizo(harry,irA(tercerPiso)).
hizo(draco,irA(mazmorras)).
hizo(ron,buenaAccion(ganarAjedrez,50)).
hizo(harry,andarDeNoche).
hizo(hermione,buenaAccion(usarIntelecto,50)).
hizo(harry,buenaAccion(ganarVoldemort,60)).
hizo(hermione,respondio(dondeBezoar,20,snape)).
hizo(harry,respondio(dondeBezoar,20,epa)).

puntajeQueGenera(andarDeNoche,-50).
puntajeQueGenera(irA(bosque),-50).
puntajeQueGenera(irA(tercerPiso),-50).
puntajeQueGenera(irA(mazmorras),0).
puntajeQueGenera(irA(seccionBiblioteca),-10).
puntajeQueGenera(buenaAccion(_,Puntaje), Puntaje).
puntajeQueGenera(respondio(_,Dificultad,Profesor),Puntaje):-
    Profesor \= snape,
    Puntaje is Dificultad.

puntajeQueGenera(respondio(_,Dificultad,snape),Puntaje):-
    Puntaje is Dificultad/2.

/*
puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
  lugarProhibido(Lugar, Puntos),
  PuntajeQueResta is Puntos * -1.
puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).
*/

esBuenAlumno(Alumno):-
    hizo(Alumno,_),
    forall(hizo(Alumno,Acciones),not(esMalaAccion(Acciones))).

esMalaAccion(Accion):-
    puntajeQueGenera(Accion,Puntaje),
    Puntaje < 0.

esRecurrente(Accion):-
    esDe(Alumno,_),
    esDe(Alumno2,_),
    Alumno \= Alumno2,
    hizo(Alumno,Accion),
    hizo(Alumno2,Accion).


puntajeTotalCasa(Casa, PuntajeTotal):-
  esDe(_, Casa),
  findall(Puntos,
    (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)),
    ListaPuntos),
  sum_list(ListaPuntos, PuntajeTotal).


puntosQueObtuvo(Mago, Accion, Puntos):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntos).


casaGanadora(Casa):-
    puntajeTotalCasa(Casa,PuntajeCasa),
    forall((puntajeTotalCasa(Casas, Puntajes), Casas \= Casa), PuntajeCasa > Puntajes).










