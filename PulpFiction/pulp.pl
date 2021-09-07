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