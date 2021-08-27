Hearthstone es un juego de cartas entre dos jugadores. Cada jugador tiene un nombre, un mazo de cartas, una cantidad de puntos de vida, una cantidad de puntos de maná, cartas en la mano y cartas de criatura en el campo. Pierde el primer jugador en llegar a cero de vida.


Todas las cartas del juego tienen nombre. Las cartas de criatura, además, tienen daño (de un ataque de la criatura), vida y costo en maná. Las cartas de hechizo, en cambio, tienen el efecto de curar o dañar en una cantidad de puntos de vida, y un correspondiente costo en maná.

En cada turno, un jugador puede gastar su mana para usar hechizos o invocar criaturas que tiene en la mano al campo, y atacar con sus criaturas.


El estado actual del juego se modela en base a hechos jugador/1, los cuales se cumplen para un functor jugador/6. Los functores tienen el siguiente formato:

% jugadores
jugador(Nombre, PuntosVida, PuntosMana, 
CartasMazo, CartasMano, CartasCampo)

% cartas
criatura(Nombre, PuntosDaño, PuntosVida, CostoMana)
hechizo(Nombre, FunctorEfecto, CostoMana)

% efectos
daño(CantidadDaño)
cura(CantidadCura)


Se cuenta con los siguientes predicados auxiliares:

nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

daño(criatura(_,Daño,_), Daño).
daño(hechizo(_,daño(Daño),_), Daño).

mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

 Puede que no se necesite usar todos, de acuerdo a cómo se plantee la solución.


Se pide modelar los predicados que permitan resolver los requerimientos indicados. Todos los predicados deben ser totalmente inversibles, a menos que se indique lo contrario.


1) Relacionar un jugador con una carta que tiene. La carta podría estar en su mano, en el campo o en el mazo.

2) Saber si un jugador es un guerrero. Es guerrero cuando todas las cartas que tiene, ya sea en el mazo, la mano o el campo, son criaturas.

3) Relacionar un jugador consigo mismo después de empezar el turno. Al empezar el turno, la primera carta del mazo pasa a estar en la mano y el jugador gana un punto de maná.

4) Cada jugador, en su turno, puede jugar cartas.
a) Saber si un jugador tiene la capacidad de jugar una carta, esto es verdadero cuando el jugador tiene igual o más maná que el costo de maná de la carta. 
Este predicado no necesita ser inversible!

b) Relacionar un jugador y las cartas que va a poder jugar en el próximo turno, una carta se puede jugar en el próximo turno si tras empezar ese turno está en la mano y además se cumplen las condiciones del punto 4.a.

5) Conocer, de un jugador, todas las posibles jugadas que puede hacer en el próximo turno, esto es, el conjunto de cartas que podrá jugar al mismo tiempo sin que su maná quede negativo.


Nota: Se puede asumir que existe el predicado jugar/3 como se indica en el punto 7.b. No hace falta implementarlo para resolver este punto. 
Importante: También hay formas de resolver este punto sin usar jugar/3. 
Tip: Pensar en explosión combinatoria.


6) Relacionar a un jugador con el nombre de su carta más dañina.

7) Cuando un jugador juega una carta, él mismo y/o su rival son afectados de alguna forma:

a) jugarContra/3. Modela la acción de jugar una carta contra un jugador. Relaciona a la carta, el jugador antes de que le jueguen la carta y el jugador después de que le jueguen la carta. Considerar que únicamente afectan al jugador las cartas de hechizo de daño.
Este predicado no necesita ser inversible para la carta ni para el jugador antes de que le jueguen la carta.

b) BONUS: jugar/3. Modela la acción de parte de un jugador de jugar una carta. Relaciona a la carta, el jugador que puede jugarla antes de hacerlo y el mismo jugador después de jugarla. En caso de ser un hechizo de cura, se aplicará al jugador y no a sus criaturas. No involucra al jugador rival (para eso está el punto a).





