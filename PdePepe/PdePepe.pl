%quedaEn(Boliche, Localidad)
quedaEn(pachuli, generalLasHeras).
quedaEn(why, generalLasHeras).
quedaEn(chaplin, generalLasHeras).
quedaEn(masDe40, sanLuis).
quedaEn(qma, caba).
%entran(Boliche, CapacidadDePersonas)
entran(pachuli, 500).
entran(why, 1000).
entran(chaplin, 700).
entran(masDe40, 1200).
entran(qma, 800).
%sirveComida(Boliche)
sirveComida(chaplin).
sirveComida(qma).

%tematico(tematica)
%cachengue(listaDeCancionesHabituales)
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina)
%Y se asocian con un boliche a partir del siguiente predicado:
%esDeTipo(Boliche, Tipo)
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel, buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).



esPiola(generalLasHeras):-
    sirveComida(generalLasHeras).

esPiola(Boliche):-
    esGrande(Boliche),
    sirveComida(Boliche).

esGrande(Boliche):-
    entran(Boliche, Personas),
    Personas > 700.


boliche(Boliche):-
    quedaEn(Boliche,_).

soloParaBailar(Boliche):-
    boliche(Boliche),
    not(sirveComida(Boliche)).







