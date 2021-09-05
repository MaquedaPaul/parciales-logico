%Tenemos la siguiente base de conocimientos de ejemplo:
% Relaciona al dueño con el nombre del juguete
%y la cantidad de años que lo ha tenido
duenio(andy, woody, 8).
duenio(sam, jessie, 3).
% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)
juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa,
caraDePapa([ original(pieIzquierdo),
original(pieDerecho),
repuesto(nariz) ])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, 1, [sombrero])).
% Dice si una persona es coleccionista
esColeccionista(sam).

%Punto 1
tematicaDeUnJuguete(NombreDelJuguete, TematicaDelJuguete):-
    juguete(NombreDelJuguete, Tematica),
    tematica(Tematica,TematicaDelJuguete).

tematicaDeUnJuguete(NombreDelJuguete, caraDePapa):-
    juguete(NombreDelJuguete, _),
    esJugueteCaraDePapa(NombreDelJuguete).

tematica(deTrapo(Tematica), Tematica).
tematica(deAccion(Tematica,_), Tematica).
tematica(miniFiguras(Tematica,_), Tematica).

esJugueteCaraDePapa(seniorCaraDePapa).


%Punto 2


%Punto 3


%Punto 4


%Punto 5


%Punto 6

