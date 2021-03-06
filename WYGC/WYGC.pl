
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

herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).



/*
estaDispuestoAHacer(egon, Cliente):-
	forall(tareaPedida(Cliente, Tarea, _), 
		not(tareaCompleja(Tarea))).
Ambas propuestas para estaDispuestoAHacer son v??lidas
Decir "para todas las tareas que pidio un cliente, ninguna es compleja"
Equivale a decir "no existe una tarea que haya pedido un 
cliente y que sea compleja"
6
Por qu?? para este punto no bastaba s??lo con agregar un nuevo 
hecho?
Con nuestra definici??n de puedeHacerTarea verificabamos con un 
forall que una persona posea todas las herramientas que requer??a
una tarea; pero s??lo ligabamos la tarea. Entonces Prolog hubiera
matcheado con ambos hechos que encontraba, y nos hubiera devuelto
las herramientas requeridas presentes en ambos hechos.
Una posible soluci??n era, dentro de puedeHacerTarea, tambi??n ligar
las herramientasRequeridas antes del forall, y as?? asegurarnos que
el predicado matcheara con una ??nica tarea a la vez.
Cual es la desventaja de esto? Para cada nueva herramienta remplazable
deber??amos contemplar todos los nuevos hechos a generar para que 
esta soluci??n siga funcionando como queremos.
Se puede hacer? En este caso s??, pero con el tiempo se volver??a costosa.
La alternativa que planteamos en esta soluci??n es agrupar en una lista
las herramientas remplazables, y agregar una nueva definici??n a 
satisfaceNecesidad, que era el predicado que usabamos para tratar
directamente con las herramientas, que trate polimorficamente tanto
a nuestros hechos sin herramientas remplazables, como a aquellos que 
s?? las tienen. Tambi??n se podr??a haber planteado con un functor en vez
de lista.
Cual es la ventaja? Cada vez que aparezca una nueva herramienta
remplazable, bastar?? s??lo con agregarla a la lista de herramientas
remplazables, y no deber?? modificarse el resto de la soluci??n.
Notas importantes:
I) Este enunciado ped??a que todos los predicados fueran inversibles
Recordemos que un predicado es inversible cuando 
no necesit??s pasar el par??metro resuelto (un individuo concreto), 
sino que pod??s pasar una inc??gnita (variable sin unificar).
As?? podemos hacer tanto consultas individuales como existenciales.
II) No siempre es conveniente trabajar con listas, no abusar de su uso.
	En general las listas son ??tiles s??lo para contar o sumar muchas cosas
	que est??n juntas.
III) Para usar findall es importante saber que est?? compuesto por 3 cosas:
		1. Qu?? quiero encontrar
		2. Qu?? predicado voy a usar para encontrarlo
		3. Donde voy a poner lo que encontr??
IV) Todo lo que se hace con forall podr??a tambi??n hacerse usando not.





