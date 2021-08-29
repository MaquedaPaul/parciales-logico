
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%Punto 1

tiene(egon, herramienta(aspiradora(200))).

tiene(egon, herramienta(trapeador)).
tiene(peter, herramienta(trapeador)).

tiene(winston, herramienta(varitaDeNeutrones)).

%Punto 2

satisfaceNecesidad(Integrante, Herramienta):-
    tiene(Integrante, Herramienta).

satisfaceNecesidad(Integrante, herramienta(aspiradora(Potencia))):-
    tiene(Integrante, herramienta(aspiradora(OtraPotencia))),
    OtraPotencia >= Potencia.

%Punto 3

puedeRealizar(Integrante, Tarea):-
    tiene(Integrante,_),
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas)
    , satisfaceNecesidad(Integrante, herramienta)).

puedeRealizar(Integrante, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Integrante, herramienta(varitaDeNeutrones)).

%Punto 4

tareaPedida/3.
%tareaPedida(Cliente, TareaPedida, MetrosCuadrados).
precio/2.
%precio(Tarea, PrecioPorMetroCuadrado).



seLeCobra(Cliente, Cobro):-
    tareaPedida(Cliente,_,_),
    findall(Precio, (tareaPedida(Cliente, Tarea, Metros), precio(Tarea, PrecioPorTarea), Precio is PrecioPorTarea * Metros), Cobro).

%Punto 5

aceptaria(Integrante, Cliente):-
    tiene(Integrante, _),
    tareaPedida(Cliente,_,_),
    forall(tareaPedida(Cliente, Tarea, _), (puedeRealizar(Integrante, Tarea), estaDispuesto(Tarea, Integrante))).

estaDispuesto(Tarea, ray):-
    not(herramientasRequeridas(limpiarTecho,_)).




%Punto 6









