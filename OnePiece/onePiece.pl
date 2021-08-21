% Relaciona Pirata con Tripulacion
 :-style_check(-discontiguous).

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

impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).

impactoEnRecompensa(law, dressrosa, 60000000).

impactoEnRecompensa(bepo,sabaody,500).

impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).

impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

%1)
tripulacionesParticiparonEn(Tripulacion,OtraTripulacion,Evento):-
    tripulacionParticipaDeUnEvento(Tripulacion,Evento),
    tripulacionParticipaDeUnEvento(OtraTripulacion,Evento),
    Tripulacion \= OtraTripulacion.

tripulacionParticipaDeUnEvento(Tripulacion,Evento):-
    impactoEnRecompensa(Tripulante,Evento,_),
    tripulante(Tripulante, Tripulacion).




%2)
seDestacoEn(Pirata,Evento):-
    impactoEnRecompensa(Pirata,Evento,Recompensa),
    forall(impactoEnRecompensa(_, Evento, OtraRecompensa), Recompensa >= OtraRecompensa).

/*
seDestacoEn(Pirata,Evento):-
    impactoEnRecompensa(Pirata,Evento,Recompensa),
    forall((impactoEnRecompensa(OtroPirata, Evento, OtraRecompensa), Pirata \= OtroPirata), Recompensa > OtraRecompensa).
*/
/*
seDestacoEn(Pirata,Evento):-
    impactoEnRecompensa(Pirata,Evento,_),
    forall((impactoEnRecompensa(Pirata, Evento, Recompensa),impactoEnRecompensa(OtroPirata, Evento, OtraRecompensa), Pirata \= OtroPirata), Recompensa > OtraRecompensa).
*/
%3)

pasoDesapercibido(Evento, Pirata):-
    tripulante(Pirata, Tripulacion),
    tripulacionParticipaEn(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata,Evento,_)).


tripulacionParticipaEn(Tripulacion, Evento):-
    impactoEnRecompensa(Pirata,Evento,_),
    tripulante(Pirata, Tripulacion).

%4)

recompensaTotalTripulacion(Tripulacion, RecompensaTotal):-
    findall(Recompensa, (recompensaPirata(Pirata,Recompensa), tripulante(Pirata,Tripulacion)), Recompensas),
    sum_list(Recompensas, RecompensaTotal).

recompensaPirata(Pirata,RecompensaTotal):-
    tripulante(Pirata,_),
    findall(Recompensa,impactoEnRecompensa(Pirata,_,Recompensa),Recompensas),
    sum_list(Recompensas, RecompensaTotal).

%5)

esTemible(Tripulacion):-
    recompensaTotalTripulacion(Tripulacion, RecompensaTotal),
    RecompensaTotal > 500000000.

esTemible(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata,Tripulacion), esPeligroso(Pirata)).

esPeligroso(Pirata):-
    recompensaPirata(Pirata, Recompensa),
    Recompensa > 100000000.


%Modelado

noPuedeNadar/1.

comio(luffy, fruta(paramecia, gomugomu)).
comio(buggy, fruta(paramecia, barabara)).
comio(law, fruta(paramecia, opeope)).
comio(chopper, fruta(zoan, hitohito, humano)).
comio(lucci, fruta(zoan, nekoneko, leopardo)).
comio(smoker, fruta(logia, mokumoku, humo)).


frutaPeligrosa(fruta(paramecia, opeope)).
frutaPeligrosa(fruta(zoan, _, lobo)).
frutaPeligrosa(fruta(zoan, _, leopardo)).
frutaPeligrosa(fruta(zoan, _, anaconda)).
frutaPeligrosa(fruta(logia,_,_)).

noPuedeNadar(Pirata):-
    comio(Pirata,_).

/*
noPuedeNadar(zoro).
noPuedeNadar(robin).
noPuedeNadar(ussop).
noPuedeNadar(sanji).
noPuedeNadar(nami).
*/
%6)

esPeligroso(Pirata):-
    comio(Pirata,Fruta),
    frutaPeligrosa(Fruta).

%7)

tripulacionDeAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata, Tripulacion), noPuedeNadar(Pirata)).


