
jugador(stuart,
     [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim,
     [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve,
     [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).


lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).


tieneItem(Jugador, Item):-
    jugador(Jugador,Items,_),
    member(Item, Items).

sePreocupaPorSuSalud(Jugador):-
    tieneItem(Jugador, Item),
    tieneItem(Jugador, OtroItem),
    comestible(Item),
    comestible(OtroItem),
    Item \= OtroItem.

cantidadDeItem(Jugador, Item, Cantidad):-
    jugador(Jugador, Items,_),
    tieneItem(Jugador, Item),
    itemsIdenticos(Item, Items, ItemsIdenticos),
    length(ItemsIdenticos, Cantidad).

cantidadDeItem(Jugador, Item, 0):-
    jugador(Jugador,_,_),
    not(tieneItem(Jugador, Item)).

itemsIdenticos(Item, Items, ItemsIdenticos):-
    findall(ItemIdentico, (member(ItemIdentico, Items), ItemIdentico == Item)
    , ItemsIdenticos).

tieneMasDe(Jugador, Item):-
    cantidadDeItem(Jugador, Item, Cantidad),
    forall((cantidadDeItem(OtroJugador, Item, OtraCantidad), Jugador \= OtroJugador), Cantidad > OtraCantidad).


hayMonstruos(Lugar):-
    lugar(Lugar,_,NivelDeOscuridad),
    NivelDeOscuridad > 6.

correPeligro(Jugador):-
    lugar(Lugar,_,_),
    hayMonstruos(Lugar),
    seEncuentraEnLugar(Jugador, Lugar).

correPeligro(Jugador):-
    estaHambriento(Jugador),
    not(tieneItemComestible(Jugador)).

estaHambriento(Jugador):-
    jugador(Jugador,_,Hambre),
    Hambre < 4.

tieneItemComestible(Jugador):-
    tieneItem(Jugador, Item),
    comestible(Item).

seEncuentraEnLugar(Jugador, Lugar):-
    lugar(Lugar, Jugadores,_),
    member(Jugador, Jugadores).

nivelPeligrosidad(Lugar, NivelPeligrosidad):-
    lugar(Lugar,_,_),
    not(hayMonstruos(Lugar)),
    porcentajeDeHambrientos(Lugar, NivelPeligrosidad).

nivelPeligrosidad(Lugar, 100):-
    lugar(Lugar,_,_),
    hayMonstruos(Lugar).

nivelPeligrosidad(Lugar, NivelDePeligrosidad):-
    lugar(Lugar,_,NivelDeOscuridad),
    not(estaPoblado(Lugar)),
    NivelDePeligrosidad is 10* NivelDeOscuridad.

estaPoblado(Lugar):-
    lugar(Lugar,Jugadores,_),
    member(_, Jugadores).


porcentajeDeHambrientos(Lugar, Porcentaje):-
    lugar(Lugar,Jugadores,_),
    findall(JugadorHambriento, (member(JugadorHambriento, Jugadores), estaHambriento(JugadorHambriento)), JugadoresHambrientos),
    length(Jugadores, CantidadTotal),
    length(JugadoresHambrientos, Cantidad),
Porcentaje is (Cantidad * 100)/CantidadTotal.



item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador, Item):-
    jugador(Jugador,_,_),
    item(Item, ItemsNecesariosParaConstruir),
    forall(tieneItem(Jugador, ItemNecesario), Action)
    


