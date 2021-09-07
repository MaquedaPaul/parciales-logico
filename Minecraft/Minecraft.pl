
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

itemsIdenticos(Item, Items, ItemsIdenticos):-
    findall(ItemIdentico, (member(ItemIdentico, Items), ItemIdentico == Item)
    , ItemsIdenticos).

tieneMasDe(Jugador, Item):-
    cantidadDeItem(Jugador, Item, Cantidad),
    forall((cantidadDeItem(OtroJugador, Item, OtraCantidad), Jugador \= OtroJugador), Cantidad > OtraCantidad).


