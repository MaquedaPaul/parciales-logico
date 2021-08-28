Nos encontramos en un contexto post-apocalíptico, donde sólo es posible organizar reuniones online usando dispositivos de realidad virtual para que se asemejen a las experiencias cotidianas del pasado. Para lucrar en este mundo, decidimos armar una aplicación para organizar fiestas de disfraces virtuales que permita, entre otras cosas, sugerir ideas de disfraces para que los asistentes personalicen su avatar dentro de la aplicación y premiar a los anfitriones que organizan fiestas exitosas.

Tenemos registrados en una base de conocimientos de ejemplo los disfraces disponibles asociados a cada una de sus categorías (como ser terror, cine, música, sexy…) mediante un predicado categoriaDisfraz/2.


De cada fiesta necesitaremos registrar un nombre que nos permita identificarla, la fecha en la que se hace, quién la organiza y el tipo de fiesta. Los tipos de fiestas que manejamos de momento son halloween y cumpleaños (en caso de ser un cumpleaños también se indicará cuál es el disfraz a usar por el cumpleañero y cuántos años cumple). Sabemos que podrían existir más tipos de fiestas a futuro, con lo cual debería ser fácil de extender.

Para representar una fecha usaremos un functor fecha(Dia,Mes,Año) y ya disponemos de un predicado anterior/2 que se verifica si la primer fecha es anterior a la segunda, por ejemplo la siguiente consulta sería cierta:
?- anterior(fecha(10,8,2020), fecha(20,2,2021)). 

Dentro de la base de conocimientos deberíamos poder expresar información como la de los siguientes ejemplos:

La fiesta cumpleLuli2042, del 27 de Agosto de 2042 fue organizada por luli47. Fue por un cumpleaños de 13, y el disfraz elegido para el cumpleañero fue hulk.

La fiesta jochiween42 se hizo el 1 de Noviembre de 2042 por halloween, organizada por jochirock.

También sabemos qué disfraz eligió cada asistente para una fiesta mediante un predicado eligioDisfraz/3 que relaciona una fiesta, una persona y el disfraz elegido para la misma.


Se pide desarrollar predicados para modelar la información (considerando los ejemplos previos) y resolver los siguientes requerimientos aprovechando los conceptos del paradigma lógico, usando buenas abstracciones y evitando soluciones poco declarativas. Asegurar que todos los predicados principales sean inversibles a menos que se indique lo contrario.



----------------------------------------------------

Necesitamos:
1)
Relacionar una persona con un disfraz que podría interesarle, lo cual se cumple si es un disfraz que no eligió nunca para una fiesta y es similar a alguno que ya haya elegido. Para que dos disfraces se consideren similares alcanza con que tengan alguna categoría en común.

2)
Saber si un disfraz está de moda en un año, que se cumple para los disfraces que fueron muy usados en ese año y en el anterior no. Consideramos que un disfraz fue muy usado si en todas las fiestas organizadas en ese año alguien lo eligió.

3)
Saber si un disfraz es apropiado para un tipo de fiesta en particular. Sabemos que:

*Para halloween son apropiados tanto los de categoría terror como sexy.

Para los cumpleaños son apropiados aquellos que no opacan el disfraz del cumpleañero y son adecuados para la edad del mismo (para menores de 18 sólo son adecuados los disfraces que no son sexy; para mayores de edad, cualquier disfraz es adecuado).
Consideramos que un disfraz opaca a otro si el primero es sexy y el otro no, o si el primero tiene la categoría llamativo, independientemente de cuál sea el otro. 
Nota: no se pretende que sea inversible este predicado.


4)
Saber qué disfraz se le puede sugerir a una persona para una fiesta para la cual aún no haya elegido un disfraz. Queremos sugerir sólo disfraces que podrían interesarle a esa persona o que estén de moda en el año de la fiesta, considerando siempre que el disfraz sea apropiado para el tipo de fiesta correspondiente.

5)
Saber cuántas personas asistieron a una fiesta, sabiendo que todas las personas que asistieron deben haber elegido un disfraz para esa fiesta.

6)
Saber si una fiesta fue exitosa, que se cumple si todos los disfraces elegidos eran apropiados para el tipo de fiesta y además hubo un buen número de asistentes.

Para la primera fiesta que organizó una persona, si hay al menos 10 asistentes ya se considera un buen número. Para las demás se considerará un buen número si tuvo por lo menos 3 asistentes más que la fiesta que organizó previamente.

Por ejemplo: si una persona organizó 4 fiestas con las siguientes fechas y cantidad de asistentes:
20/4/2040 - 15 asistentes
29/4/2040 - 17 asistentes
15/8/2041 - 22 asistentes
29/10/2041 - 23 asistentes
La fiesta del 20/4/2040 tuvo un buen número de asistentes por ser la primera fiesta organizada por esa persona, y también la del 15/8/2041, porque tuvo 5 asistentes más que la fiesta anterior. Por otro lado, la fiesta del 29/10/2041 no tuvo un buen número de asistentes considerando que la fiesta anterior tuvo 22.
Tip: usar el predicado anterior/2 para este problema (no vale asumir que la base de conocimientos tendrá la información de las fiestas ordenada cronológicamente) y evitar soluciones algorítmicas.

7)
En base a tu solución general, explicar qué sería necesario cambiar o extender para considerar otro tipo de fiesta que no tenga nada en común con halloween o los cumpleaños.
En caso de haber alguna característica de tu solución que simplifique esta tarea, comentar brevemente de qué se trata y demostrarlo incorporando un nuevo tipo de fiesta de tu elección de modo que se integre adecuadamente al resto del programa desarrollado.