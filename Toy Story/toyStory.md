Tenemos la siguiente base de conocimientos de ejemplo:
% Relaciona al dueño con el nombre del juguete
y la cantidad de años que lo ha tenido
dueño(andy, woody, 8).
dueño(sam, jessie, 3).
% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)
juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero))
juguete(buzz, deAccion(espacial, [original(casco)]).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(señorCaraDePapa,
caraDePapa([ original(pieIzquierdo),
original(pieDerecho),
repuesto(nariz) ])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, 1, [sombrero])).
% Dice si una persona es coleccionista
esColeccionista(sam).

Resolver los siguiente requerimientos:
Nota: siempre que nos refiramos al functor que representa al juguete le diremos “juguete”. Y siempre que nos refiramos al átomo con su nombre, le diremos “nombre del juguete”

1. a. tematica/2: relaciona a un juguete con su temática. La temática de los cara de papa es caraDePapa.

1. b. esDePlastico/1: Nos dice si el juguete es de plástico, lo cual es verdadero sólo para las miniFiguras y los caraDePapa.

1. c. esDeColeccion/1:Tanto lo muñecos de acción como los cara de papa son de colección si son raros, los de trapo siempre lo son, y las mini figuras, nunca.


2. amigoFiel/2: Relaciona a un dueño con el nombre del juguete que no sea de plástico que tiene hace más tiempo. Debe ser completamente inversible.

3. superValioso/1: Genera los nombres de juguetes de colección que tengan todas sus piezas originales, y que no estén en posesión de un coleccionista.

4. dúoDinámico/3: Relaciona un dueño y a dos nombres de juguetes que le pertenezcan que hagan buena pareja. Dos juguetes distintos hacen buena pareja si son de la misma temática. Además woody y buzz hacen buena pareja. Debe ser complemenente inversible.

5. felicidad/2:Relaciona un dueño con la cantidad de felicidad que le otorgan todos sus juguetes:

● las minifiguras le dan a cualquier dueño 20 * la cantidad de figuras del conjunto

● los cara de papas dan tanta felicidad según que piezas tenga: las originales dan 5, las de repuesto,8.

● los de trapo, dan 100 
● Los de accion, dan 120 si son de coleccion y el dueño es coleccionista. Si no dan lo mismo que los de trapo.
Debe ser completamente inversible.


6. puedeJugarCon/2: Relaciona a alguien con un nombre de juguete cuando puede jugar con él. Esto ocurre cuando:
● este alguien es el dueño del juguete
● o bien, cuando exista otro que pueda jugar con este juguete y pueda prestárselo
Alguien puede prestarle un juguete a otro cuando es dueño de una mayor cantidad de juguetes.

7. podriaDonar/3: relaciona a un dueño, una lista de
juguetes propios y una cantidad de felicidad cuando entre
todos los juguetes de la lista le generan menos que esa
cantidad de felicidad. Debe ser completamente inversible.

8. Comentar dónde se aprovechó el polimorfismo










