personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).


pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

esPeligroso(Personaje):-
    realizaActividadPeligrosa(Personaje).

esPeligroso(Personaje):-
    tieneEmpleados(Personaje, Empleados),
    member(EmpleadoPeligroso, Empleados),
    esPeligroso(EmpleadoPeligroso).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, mafioso(maton)).

realizaActividadPeligrosa(Personaje):-
    personaje(Personaje, ladron(Lugares)),
    member(licorerias, Lugares).

tieneEmpleados(Personaje, Empleados):-
    trabajaPara(Personaje,_),
    findall(Empleado, trabajaPara(Personaje, Empleado), Empleados).



duoTemible(Personaje, OtroPersonaje):-
    sonPeligrosos(Personaje, OtroPersonaje),
    sonPareja(Personaje, OtroPersonaje).

duoTemible(Personaje, OtroPersonaje):-
    sonPeligrosos(Personaje, OtroPersonaje),
    sonAmigos(Personaje, OtroPersonaje).

sonPeligrosos(Personaje, OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    Personaje \= OtroPersonaje.


sonPareja(Personaje, OtroPersonaje):-
    pareja(Personaje, OtroPersonaje).

sonPareja(Personaje, OtroPersonaje):-
    pareja(OtroPersonaje, Personaje).

sonAmigos(Personaje, OtroPersonaje):-
    amigo(Personaje, OtroPersonaje).

sonAmigos(Personaje, OtroPersonaje):-
    amigo(OtroPersonaje, Personaje).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(carlitos)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    jefePeligroso(Personaje, Jefe),
    encargo(Jefe, Personaje, cuidar(Pareja)),
    sonPareja(Jefe, Pareja).


estaEnProblemas(Personaje):-
    jefePeligroso(Personaje, Jefe),
    encargo(Jefe, Personaje, buscar(_, _)).

jefePeligroso(Personaje, Jefe):-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe).


sanCayetano(Personaje):-
    trabajaPara(Personaje,_),
    forall((tieneCerca(Personaje, OtroPersonaje), Personaje \= OtroPersonaje), encargo(Personaje, OtroPersonaje,_)).

tieneCerca(Personaje, OtroPersonaje):-
    sonAmigos(Personaje, OtroPersonaje).

tieneCerca(Personaje, OtroPersonaje):-
    trabajaPara(Personaje, OtroPersonaje).


masAtareado(Personaje):-
    encargosDe(Personaje, Encargos),
    length(Encargos, CantidadEncargos),
    forall((encargosDe(OtroPersonaje, OtrosEncargos), Personaje \= OtroPersonaje, length(OtrosEncargos, OtraCantidadEncargos)), CantidadEncargos > OtraCantidadEncargos).

encargosDe(Personaje, Encargos):-
    encargo(_,Personaje,_),
    findall(Encargo, encargo(_,Personaje, Encargo), Encargos).


personajesRespetables(Personajes):-
    findall(Personaje, esRespetable(Personaje), Personajes).

esRespetable(Personaje):-
    nivelDeRespeto(Personaje, Nivel),
    Nivel > 9.

nivelDeRespeto(Personaje, Nivel):-
    personaje(Personaje, actriz(Peliculas)),
    length(Peliculas, CantidadDePeliculas),
    Nivel is CantidadDePeliculas/10.

nivelDeRespeto(Personaje, 10):-
    personaje(Personaje, mafioso(resuelveProblemas)).

nivelDeRespeto(Personaje, 1):-
    personaje(Personaje, mafioso(maton)).

nivelDeRespeto(Personaje, 20):-
    personaje(Personaje, mafioso(capo)).