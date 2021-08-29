
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
    , satisfaceNecesidad(Integrante, Herramienta)).

puedeRealizar(Integrante, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Integrante, herramienta(varitaDeNeutrones)).

%Punto 4

tareaPedida/3.
%tareaPedida(TareaPedida, Cliente, MetrosCuadrados).
precio/2.
%precio(Tarea, PrecioPorMetroCuadrado).



seLeCobra(Cliente, Cobro):-
    tareaPedida(_, Cliente,_),
    findall(Precio, calculoDelPrecio(Cliente, Precio, _), Precios),
    sum_list(Precios, Cobro).

calculoDelPrecio(Cliente, Precio, Tarea):-
    tareaPedida(Tarea, Cliente, Metros),
    precio(Tarea, PrecioPorTarea),
    Precio is PrecioPorTarea * Metros.

%Punto 5
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).



aceptaria(Integrante, Cliente):-
    tiene(Integrante, _),
    tareaPedida(_,Cliente,_),
    forall(tareaPedida(Tarea, Cliente, _), (puedeRealizar(Integrante, Tarea), estaDispuesto(Tarea, Integrante))).

estaDispuesto(Pedido, ray):-
    tareaPedida(Pedido,_,_),
    Pedido \= limpiarTecho.

estaDispuesto(_, winston):-
    seLeCobra(_, Cobro),
    Cobro > 500.


estaDispuesto(Pedido, egon):-
    tareaPedida(Pedido,_,_),
    not(tareaCompleja(Pedido)).

estaDispuesto(Pedido, peter):-
    tareaPedida(Pedido,_,_).



tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.
    


%Punto 6









