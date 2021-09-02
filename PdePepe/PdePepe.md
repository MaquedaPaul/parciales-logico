En nuestra base de conocimientos contamos con los siguientes datos de los boliches:
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

También sabemos que existen los siguientes tipos de boliches:

%tematico(tematica)
%cachengue(listaDeCancionesHabituales)
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina)
Y se asocian con un boliche a partir del siguiente predicado:
%esDeTipo(Boliche, Tipo)
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel, buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).
Hacé los siguientes predicados teniendo en cuenta que deben ser totalmente inversibles.

1) esPiola/1: sabemos que un boliche es piola cuando queda en General Las Heras o
cuando es grande, es decir, entran más de 700 personas. En ambos casos es
necesario que sirvan comida.

2) soloParaBailar/1: un boliche es solo para bailar cuando no sirve comida.


3) podemosIrConEsa/1: cuando decimos que podemos ir con una localidad es
porque sabemos que todos sus boliches son piolas.

4) puntaje/2: nos permite relacionar un boliche con su puntaje. Los boliches de temática ochentosa tienen un puntaje de 9 mientras que los otros temáticos tienen un puntaje de 7. El puntaje de boliches electrónicos está dado por la suma de la hora en que empieza y deja de tocar el DJ. Por último, los de cachengue son un 10 si suelen pasar biodiesel y buenComportamiento pero no sabemos el puntaje de los que no pasan estos temaikenes.


5) elMasGrande/2: el boliche más grande de una localidad es aquel que tiene la
mayor capacidad.

6) puedeAbastecer/2: una localidad puede abastecer a una determinada cantidad de personas si la suma de capacidades de los boliches que quedan en ella es mayor o igual a esa cantidad. Tener en cuenta que este punto no puede ser totalmente inversible.

7) ¡Parame la música! ¡No pare, sigue sigue! 🎶 Se van a abrir más boliches y nos pidieron que reflejemos esta información en nuestra base de conocimientos:

○ 
"Trabajamos y nos divertimos" será un boliche de temática oficina en el que
entran 500 personas. Se va a poder cenar en esta interesante propuesta de
Concordia. 

○ 
"El fin del mundo" será el boliche más austral de la Argentina, con capacidad para 1500 personas. No se va a poder comer pero esto no interesa porque tendrá las vistas más lindas de Ushuaia y al DJ Luis tocando toda la noche: de 00 a 6 de la mañana.

○ 
"Misterio" será el boliche más grande de Argentina, con capacidad para
1.000.000 de personas. La verdad es que no sabemos dónde se hará un
boliche tan grande pero sí sabemos que se va a poder comer ahí mismo.











