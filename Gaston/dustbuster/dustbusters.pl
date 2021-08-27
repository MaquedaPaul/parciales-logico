% DustBusters
% Consignas en:
% https://docs.google.com/document/d/1GBORNTd2fujNy0Zs6v7AKXxRmC9wVICX2Y-pr7d1PwE/edit

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).

% Punto 1
% Agregar a la base de conocimientos la informacion:

tieneHerramienta(egon, aspiradora(200)).
tieneHerramienta(egon, trapeador).
tieneHerramienta(peter, trapeador).
tieneHerramienta(winston, varitaDeNeutrones).

% Punto 2
% definir un predicado que determine si un integrante satisface la necesidad de una herramienta
% si es una aspiradora itene que tener la potencia o superior a la requerida.
% no se pretende inversibilidad respecto a la herramienta.

satisfaceHerramienta(Persona, Herramienta):-
    tieneHerramienta(Persona, Herramienta),
    Herramienta \= aspiradora(_).

satisfaceHerramienta(Persona, aspiradora(PotenciaNecesaria)):-
    tieneHerramienta(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaNecesaria.

% Punto 3
% Queremos saber si una persona puede realizar una tarea, 
% que dependerá de las herramientas que tenga.
% Quien tenga una varita de neutrones puede hacer cualquier tarea

puedeRealizarUnaTarea(Persona, Tarea):-
    herramientasRequeridas(Tarea, _),
    tieneHerramienta(Persona, varitaDeNeutrones).
puedeRealizarUnaTarea(Persona, Tarea):-
    tieneHerramienta(Persona, _),
    herramientasRequeridas(Tarea, _),
    forall(requiereHerramienta(Tarea, Herramienta), satisfaceHerramienta(Persona, Herramienta)).

requiereHerramienta(Tarea, Herramienta):-
    herramientasRequeridas(Tarea, ListaDeHerramientas),
    member(Herramienta, ListaDeHerramientas).

% Punto 4
% Nos interesa saber de antemano cuanto se le debería cobrar a un cliente por un pedido 
% (que son las tareas que pide)
%  tareaPedida/3: relaciona al cliente, con la tarea pedida y 
%                 la cantidad de metros cuadrados sobre los cuales hay que realizar esa tarea
%  precio/2: relaciona una tarea con el precio por metro cuadrado que se cobraría al cliente.

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

precioACobrar(Cliente, Monto):-
    tareaPedida(_, Cliente, _),
    findall(Precio, precioTarea(Cliente, _, Precio), Precios),
    sum_list(Precios, Monto).
    
precioTarea(Cliente, Tarea, Precio):-
    tareaPedida(Tarea, Cliente, MetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is MetrosCuadrados * PrecioPorMetroCuadrado.

%Punto 5
%Finalmente necesitamos saber quiénes aceptarían el pedido de un cliente. 
%Un integrante acepta el pedido cuando puede realizar todas las tareas del pedido y 
%además está dispuesto a aceptarlo.

aceptariaPedido(Integrante, Cliente):-
    puedeRealizarTodasLasTareas(Integrante, Cliente),
    estaDispuesto(Integrante, Cliente).

puedeRealizarTodasLasTareas(Integrante, Cliente):-
    tareaPedida(_, Cliente, _),
    tieneHerramienta(Integrante, _),
    forall(tareaPedida(Tarea, Cliente, _), puedeRealizarUnaTarea(Integrante, Tarea)).

estaDispuesto(ray, Cliente):-
    not(tareaPedida(limpiarTecho, Cliente, _)).
estaDispuesto(winston, Cliente):-
    precioACobrar(Cliente, Monto),
    Monto > 500.
estaDispuesto(egon, Cliente):- 
    tareaPedida(_, Cliente, _),
    not(tieneTareaCompleja(Cliente)).
estaDispuesto(peter, _).

tieneTareaCompleja(Cliente):-
    tareaPedida(Tarea, Cliente, _),
    esTareaCompleja(Tarea).

esTareaCompleja(limpiarTecho).
esTareaCompleja(Tarea):-
    herramientasRequeridas(Tarea, ListaDeHerramientas),
    length(ListaDeHerramientas, Cantidad),
    Cantidad > 2.

%Punto 6.
%Necesitamos agregar la posibilidad de tener herramientas reemplazables, 
%que incluyan 2 herramientas de las que pueden tener los integrantes como alternativas, 
%para que puedan usarse como un requerimiento para poder llevar a cabo una tarea.

%Mostrar cómo modelarías este nuevo tipo de información modificando el hecho de 
%herramientasRequeridas/2 para que ordenar un cuarto pueda realizarse tanto con una 
%aspiradora de 100 de potencia como con una escoba, además del trapeador y el plumero 
%que ya eran necesarios

%Realizar los cambios/agregados necesarios a los predicados definidos en los puntos anteriores 
%para que se soporten estos nuevos requerimientos de herramientas para poder llevar a cabo 
%una tarea, teniendo en cuenta que para las herramientas reemplazables alcanza con que el 
%integrante satisfaga la necesidad de alguna de las herramientas indicadas para cumplir dicho 
%requerimiento

% Explicar a qué se debe que esto sea difícil o fácil de incorporar.
%