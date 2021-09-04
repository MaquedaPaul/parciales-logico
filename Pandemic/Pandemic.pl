

% Relaciona dos ciudad conectadas
conectada(ny, washington).
conectada(boston, ny).
conectada(washington, alaska).
conectada(washington, londres).
conectada(londres, madrid).
% Relaciona una ciudad con la cantidad de infecciones que hay en dicha ciudad
% virus(Infectados, Prevencion)
% bacteria(Infectados)
% plaga(Nombre, Infectados).
infeccion(ny, virus(1, vacuna(viruela))).
infeccion(ny, bacteria(1)).
infeccion(washington, virus(2, tratamiento(gripe))).
infeccion(londres, bacteria(2)).
infeccion(londres, plaga(pesteNegra, 10)).
% Relaciona un personaje con su rol
personaje(katie, medico).
personaje(mike, investigador).
% Relaciona un persona con alguna tarjeta que tenga
tarjeta(katie, ciudad(londres)).
tarjeta(mike, vacuna(viruela)).
tarjeta(katie, tratamiento(gripe)).
% Relaciona un personaje con su ubicación
ubicacion(katie, ny).
ubicacion(mike, ny).


%Punto 1

ciudad(Ciudad):-
    conectada(Ciudad,_).

ciudad(Ciudad):-
    conectada(_,Ciudad).

cantInfecciones(Ciudad, CantInfecciones):-
    infeccion(Ciudad,_),
    findall(Infeccion, infeccion(Ciudad, Infeccion), Infecciones),
    length(Infecciones, CantInfecciones).


%Punto 2

esMedico(Personaje):-
    personaje(Personaje, medico).


puedeCurar(Personaje, Ciudad):-
    esMedico(Personaje).
    %cantidadAcciones(Personaje, Acciones),
    %Acciones >= 1.

puedeCurar(Personaje, Ciudad):-
    cantInfecciones(Ciudad, CantInfecciones),
    cantidadAcciones(Personaje, Acciones),
    Acciones >= cantInfecciones.


cantidadAcciones(Personaje, Acciones):-
    nivelActual(Personaje, Acciones).

nivelActual(katie, 5).

nivelActual(mike, 2).

%Punto 3

estaAtrapado(Personaje):-
    ubicacion(Personaje, Ciudad),
    forall(conectada(Ciudad, OtraCiudad), not(esCurable(OtraCiudad))).

esCurable(Ciudad):-
    puedeCurar(_, Ciudad).

%Punto 4




puedenSerErradicadas(Ciudad):-
    puedeCurar(_,Ciudad),
    forall(enfermedadesDeUnaCiudad(Ciudad, Infecciones),(
    member(Infeccion, Infecciones), seTienenReqsParaPrevenirBrote(Infeccion))
    ).


seTienenReqsParaPrevenirBrote(bacteria(_)).
seTienenReqsParaPrevenirBrote(plaga(Plaga, _)):-
    infeccion(Ciudad, Plaga),
    not(infeccion(OtraCiudad, Plaga)),
    OtraCiudad \= Ciudad.

seTienenReqsParaPrevenirBrote(virus(Infectados, tratamiento(Tratamiento))):-
    tarjeta(_, tratamiento(Tratamiento)).


enfermedadesDeUnaCiudad(Ciudad, Infecciones):-
    infeccion(Ciudad,_),
    findall(Infeccion, infeccion(Ciudad, Infeccion), Infecciones).



%Punto 5





%Punto 6



%Punto 7













