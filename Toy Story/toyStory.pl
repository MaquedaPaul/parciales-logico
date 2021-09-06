:-style_check(-discontiguous).

%Tenemos la siguiente base de conocimientos de ejemplo:
% Relaciona al dueño con el nombre del juguete
%y la cantidad de años que lo ha tenido
duenio(andy, woody, 8).
duenio(andy, buzz, 2).
duenio(sam, jessie, 3).
duenio(jorge, seniorCaraDePapa, 3).
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
repuesto(nariz)])).

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


esDePlastico(Juguete):-
    juguete(Juguete, miniFiguras(_,_)).

esDePlastico(Juguete):-
    juguete(Juguete, _),
    esJugueteCaraDePapa(Juguete).

esDeColeccion(Juguete):-
    juguete(Juguete, deAccion(_,_)),
    esRaro(Juguete).

esRaro(Juguete):-
    juguete(Juguete, deTrapo(_)).


%Punto 2

amigoFiel(Duenio, Juguete):-
    tieneJugueteQueNoEsDePlastico(Duenio, Juguete, Anios),
    forall((tieneJugueteQueNoEsDePlastico(Duenio, OtroJuguete, OtrosAnios),Juguete \= OtroJuguete), Anios > OtrosAnios).


tieneJugueteQueNoEsDePlastico(Duenio, Juguete, Anios):-
    juguete(Juguete, _),
    not(esDePlastico(Juguete)),
    duenio(Duenio, Juguete, Anios).


%Punto 3

superValioso(Juguete):-
    duenio(Duenio, Juguete, _),
    tieneTodasSusPiezasOriginales(Juguete),
    not(esColeccionista(Duenio)).

tieneTodasSusPiezasOriginales(CaraDePapa):-
    juguete(CaraDePapa, caraDePapa(Piezas)),
    forall(member(Pieza, Piezas), esOriginal(Pieza)).

esOriginal(original(_)).

%Punto 4

duoDinamico(Duenio, Juguete, OtroJuguete):-
    lePertenecen(Duenio, Juguete, OtroJuguete),
    hacenBuenaPareja(Juguete, OtroJuguete).

hacenBuenaPareja(Juguete, OtroJuguete):-
    tematicaDeUnJuguete(Juguete, Tematica),
    tematicaDeUnJuguete(OtroJuguete, Tematica).

hacenBuenaPareja(woody, buzz).

lePertenecen(Duenio, Juguete, OtroJuguete):-
    duenio(Duenio, Juguete,_),
    duenio(Duenio, OtroJuguete,_),
    Juguete \= OtroJuguete.


%Punto 5

felicidad(Duenio, FelicidadTotal):-
    juguetesDe(Duenio, Juguetes),
    findall(Felicidad, (member(Juguete, Juguetes), felicidadQueOtorga(Juguete, Felicidad)), Felicidades),
    sum_list(Felicidades, FelicidadTotal).   

juguetesDe(Duenio, Juguetes):-
    duenio(Duenio, _,_),
    findall(Juguete, duenio(Duenio, Juguete, _), Juguetes).

felicidadQueOtorga(Juguete, Felicidad):-
    juguete(Juguete, miniFiguras(_,Figuras)),
    Felicidad is 20 * Figuras.

felicidadQueOtorga(Juguete, Felicidad):-
    juguete(Juguete, caraDePapa(Piezas)),
    piezasDeRepuesto(Piezas, Repuestos),
    piezasOriginales(Piezas, Originales),
    felicidadTotalPiezasDeRepuesto(Repuestos, FelicidadTotalPorRepuesto),
    felicidadTotalPiezasOriginales(Originales, FelicidadTotalPorOriginal),
    Felicidad is FelicidadTotalPorOriginal + FelicidadTotalPorRepuesto.

felicidadQueOtorga(Juguete, 100):-
    juguete(Juguete, deTrapo(_)).

felicidadQueOtorga(Juguete, 120):-
    juguete(Juguete, deAccion(_,_)),
    esDeColeccion(Juguete),
    duenio(Duenio, Juguete, _),
    esColeccionista(Duenio).

felicidadQueOtorga(Juguete, 100):-
    juguete(Juguete, deAccion(_,_)).



piezasDeRepuesto(Piezas, Repuestos):-
    findall(Repuesto, (member(Repuesto, Piezas),
    esPiezaRepuesto(Repuesto))
    , Repuestos).

piezasOriginales(Piezas, Originales):-
    findall(Original, (member(Original, Piezas),
    esOriginal(Original))
    , Originales).

esPiezaRepuesto(repuesto(_)).

felicidadPiezaRepuesto(repuesto(_),8).

felicidadPiezaOriginal(original(_),5).

felicidadTotalPiezasDeRepuesto(Repuestos, FelicidadTotalPorRepuesto):-
    findall(FelicidadPorRepuesto, (member(Repuesto, Repuestos),felicidadPiezaRepuesto(Repuesto, FelicidadPorRepuesto))
    , ListaFelicidadesPorPiezaRepuesto),
    sum_list(ListaFelicidadesPorPiezaRepuesto, FelicidadTotalPorRepuesto).


felicidadTotalPiezasOriginales(Originales, FelicidadTotalPorOriginal):-
    findall(FelicidadPorOriginal, (member(Original, Originales),felicidadPiezaOriginal(Original, FelicidadPorOriginal))
    , ListaFelicidadesPorPiezaOriginal),
    sum_list(ListaFelicidadesPorPiezaOriginal, FelicidadTotalPorOriginal).



%Punto 6

puedeJugarCon(Duenio, Juguete):-
    duenio(Duenio, Juguete,_).

puedeJugarCon(Duenio, Juguete):-
    puedeJugarCon(OtroDuenio, Juguete),
    puedePrestar(OtroDuenio, Duenio, Juguete).

puedePrestar(Duenio, OtraPersona, Juguete):-
    duenio(Duenio, Juguete,_),
    not(duenio(OtraPersona, Juguete,_)),
    juguetesDe(Duenio, Juguetes),
    juguetesDe(OtraPersona, OtrosJuguetes),
    length(Juguetes, CantidadDeJuguetes),
    length(OtrosJuguetes, CantidadDeOtrosJuguetes),
    CantidadDeJuguetes > CantidadDeOtrosJuguetes.


podriaDonar(Duenio, JuguetesPropios, CantidadFelicidad):-
    duenio(Duenio,_,_),
    juguetesDe(Duenio, Juguetes),
    forall(member(Juguete, JuguetesPropios), member(Juguete, Juguetes)),
    findall(Felicidad, (member(Juguete, JuguetesPropios), felicidadQueOtorga(Juguete, Felicidad)), Felicidades),
    sum_list(Felicidades, TotalFelicidad),
    CantidadFelicidad > TotalFelicidad.


