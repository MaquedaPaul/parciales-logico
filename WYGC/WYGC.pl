
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tiene(egon, herramienta(aspiradora(200))).

tiene(egon, herramienta(trapeador)).
tiene(peter, herramienta(trapeador)).

tiene(winston, herramienta(varitaDeNeutrones)).


satisfaceNecesidad(Integrante, Herramienta):-
    tiene(Integrante, Herramienta).

satisfaceNecesidad(Integrante, herramienta(aspiradora(Potencia))):-
    tiene(Integrante, herramienta(aspiradora(OtraPotencia))),
    OtraPotencia >= Potencia.

puedeRealizar(Integrante, Tarea):-
    tiene(Integrante,_),
    herramientasRequeridas(Tarea, Herramientas),
    forall(member(Herramienta, Herramientas)
    , satisfaceNecesidad(Integrante, herramienta)).

puedeRealizar(Integrante, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Integrante, herramienta(varitaDeNeutrones)).








