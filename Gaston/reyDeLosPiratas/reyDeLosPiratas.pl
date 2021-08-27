% Voy a ser el rey de los piratas!
% Consignas en:
% https://docs.google.com/document/d/1UEvoioj18bCHDOpyUoM9hcWzBQoZ5iW_cNxfaWH2xEg/edit

% Agrego esto para que prolog no joda cuando ponga este predicado en 2 partes del tp.

:- discontiguous(esPeligroso/1).

% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).
tripulante(law, heart).
tripulante(bepo, heart).
tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo,240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo,sabaody,500).
impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).


% Punto 1.
% Relacionar a dos tripulaciones y un evento si ambas participaron del mismo, lo cual
% sucede si dicho evento impactó en la recompensa de al menos un pirata de cada tripulación.

seCruzaronEn(Tripulacion1, Tripulacion2, Evento):-
    participoEnEvento(Tripulacion1, Evento),
    participoEnEvento(Tripulacion2, Evento),
    Tripulacion1 \= Tripulacion2.
    
participoEnEvento(Tripulacion, Evento):-
    tripulante(Tripulante, Tripulacion),
    impactoEnRecompensa(Tripulante, Evento, _).

% Punto 2
% Saber quién fue el pirata que más se destacó en un evento, 
% en base al impacto que haya tenido su recompensa.

pirataQueMasSeDestaco(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, MontoMayor),
    not((impactoEnRecompensa(_, Evento, Monto), Monto > MontoMayor)).

pirataQueMasSeDestacoV2(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, MontoMayor),
    forall((impactoEnRecompensa(Pirata2, Evento, Monto), Pirata \= Pirata2), Monto < MontoMayor).


% Punto 3 
% Saber si un pirata pasó desapercibido en un evento, 
% que se cumple si su recompensa no se vio impactada por dicho evento 
% a pesar de que su tripulación participó del mismo.

pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata, Tripulacion),
    participoEnEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata, Evento, _)).

% Punto 4
% Saber cuál es la recompensa total de una tripulación, 
% que es la suma de las recompensas actuales de sus miembros.

recompensaTotal(Tripulacion, Total):-
    tripulante(_, Tripulacion),
    findall(Recompensa, recompensa(Tripulacion, Recompensa), Recompensas),
    sumlist(Recompensas, Total).

recompensa(Tripulacion, Recompensa):-
    tripulante(Tripulante, Tripulacion),
    impactoEnRecompensa(Tripulante, _, Recompensa).
    
% Punto 5
% Saber si una tripulacion es temible.
% Lo es si todos sus tripulantes son peligrosos o si la recompensa de la tripulacion
% supera los 500,000,000.
% Un pirata es temible si su recompensa supera los 100,000,000.

esPeligroso(Pirata):-
    tripulante(Pirata, _),
    findall(Recompensa, impactoEnRecompensa(Pirata, _, Recompensa), Recompensas),
    sumlist(Recompensas, RecompensaTotal),
    RecompensaTotal > 100000000.

esTemible(Tripulacion):-
    recompensaTotal(Tripulacion, RecompensaTotal),
    RecompensaTotal > 500000000.
esTemible(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion), esTemible(Pirata)).

    
%==================================
%   PARTE 2 - FRUTAS DEL DIABLO
%==================================

%comio(pirata, tipofruta(argumentos)).
%paramecia(nombre, peligrosa)
%zoan(nombre, especie) lobo || leopardo || anaconda son siempre peligrosas
%logia(transformacion) siempre peligrosas

comio(luffy, paramecia(gomugomu, noPeligrosa)).
comio(buggy, paramecia(barabara, noPeligrosa)).
comio(law, paramecia(opeope, peligrosa)).
comio(chopper, zoan(hitohito, humano)).
comio(lucci, zoan(nekoneko, leopardo)).
comio(smoker, logia(mokumoku, humo)).

%Punto 6:
%Necesitamos modificar la funcionalidad anterior, 
%porque ahora hay otra forma en la cual una persona puede considerarse peligrosa: 
%alguien que comió una fruta peligrosa se considera peligroso, 
%independientemente de cuál sea el precio sobre su cabeza       

comioFrutaPeligrosa(Pirata):-
    comio(Pirata, Fruta),
    esFrutaPeligrosa(Fruta).

esFrutaPeligrosa(paramecia(_, peligrosa)).
esFrutaPeligrosa(zoan(_, lobo)).
esFrutaPeligrosa(zoan(_, leopardo)).
esFrutaPeligrosa(zoan(_, anaconda)).
esFrutaPeligrosa(logia(_,_)).

esPeligroso(Pirata):-
    comioFrutaPeligrosa(Pirata).


% Punto 7
% Saber si una tripulación es de piratas de asfalto, 
% que se cumple si ninguno de sus miembros puede nadar

puedeNadar(Pirata):-
    not(comio(Pirata, _)).

sonPiratasDelAsfalto(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Tripulante, Tripulacion), not(puedeNadar(Tripulante))).

