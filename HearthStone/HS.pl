% jugadores
/*
jugador(Nombre, PuntosVida, PuntosMana, 
CartasMazo, CartasMano, CartasCampo)

% cartas
criatura(Nombre, PuntosDanio, PuntosVida, CostoMana)
hechizo(Nombre, FunctorEfecto, CostoMana)

% efectos
danio(CantidadDanio)
cura(CantidadCura)

*/

nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

danio(criatura(_,Danio,_), Danio).
danio(hechizo(_,danio(Danio),_), Danio).

mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

%Punto 1

tiene(Jugador, Carta):-
    cartasCampo(Jugador, Carta).

tiene(Jugador, Carta):-
    cartasMano(Jugador, Carta).

tiene(Jugador, Carta):-
    cartasMazo(Jugador, Carta).


%Punto 2

esGuerrero(Jugador):-
    tiene(Jugador,_),
    forall(tiene(Jugador, Carta), esCriatura(Carta)).

esCriatura(criatura(_,_,_,_)).

%Punto 3


