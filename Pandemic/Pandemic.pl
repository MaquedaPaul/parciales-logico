

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


puedeCurar(Personaje, _):-
    esMedico(Personaje).
    %cantidadAcciones(Personaje, Acciones),
    %Acciones >= 1.

puedeCurar(Personaje, Ciudad):-
    cantInfecciones(Ciudad, CantInfecciones),
    cantidadAcciones(Personaje, Acciones),
    Acciones >= CantInfecciones.


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

seTienenReqsParaPrevenirBrote(virus(_, tratamiento(Tratamiento))):-
    tarjeta(_, tratamiento(Tratamiento)).


enfermedadesDeUnaCiudad(Ciudad, Infecciones):-
    infeccion(Ciudad,_),
    findall(Infeccion, infeccion(Ciudad, Infeccion), Infecciones).

%Punto 5
%infeccion(londres, plaga(pesteNegra, 10)).
/* a. por ejemplo, deberíamos modificar los
siguientes predicados: infeccion(Ciudad, nuevaInfeccion(Infectados, OtroParametro))
y añadir el requisito necesario para prevenir un nuevo brote
seTienenReqsParaPrevenirBrote(nuevaInfeccion(Infectados, OtroParametro)).
También se pueden añadir muchos más parametros, o reducir según convenga
No necesariamente tienen que ser 2.

b.  Si quisiéramos agregar una nueva enfermedad, por polimorfismo 
(bien aplicado), resulta sencillo.

c. Los dos casos más claros de polimorfismo son infeccion() y 
seTienenReqsParaPrevenirBrote(). Me dí cuenta de usarlos porque resultaría incómodo
escribir predicados por cada variante de infección, desde el momento
en que se decide utilizar infeccion(), habría que repetir mucha lógica
sino tuviéramos el polimorfismo (para contemplar cada caso), en cambio
con el polimorfismo puedo simplemente pensar en "Infeccion" y no en su
complejidad según la infección que sea.

*/
%Punto 6

accionesNecesarias(Ciudad, OtraCiudad, Accion):-
    ciudad(OtraCiudad),
    cadenaDeConexiones(Ciudad, Ciudades),
    nth1(Accion, Ciudades, OtraCiudad),
    forall(nth1(OtraAccion, Ciudades, OtraCiudad)
    , Accion =< OtraAccion).


accionesNecesarias(Ciudad, Ciudad, 0).

viaje(Personaje, CiudadDestino, Acciones):-
    ubicacion(Personaje, CiudadOrigen),
    accionesNecesarias(CiudadOrigen, CiudadDestino, Acciones).


viaje(Personaje, CiudadDestino, 1):-
    tarjeta(Personaje, ciudad(CiudadDestino)),
    ubicacion(Personaje, CiudadOrigen),
    CiudadOrigen \= CiudadDestino.







cadenaDeConexiones(Ciudad, [OtraCiudad | Ciudades]):-
    conectada(Ciudad, OtraCiudad),
    Ciudad \= OtraCiudad,
    cadenaDeConexiones(OtraCiudad, Ciudades).
cadenaDeConexiones(_, []).

%Punto 7













