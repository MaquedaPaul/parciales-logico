Tarantino, un poco cansado después de largas horas de filmación de su clásico noventoso Pulp Fiction, decidió escribir un programa Prolog para entender mejor las relaciones entre sus personajes. 

Para ello nos entregó la siguiente base de conocimientos sobre sus personajes, parejas y actividades:

personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

%etc

Sabiendo eso, resolver los siguientes predicados, los cuales deben ser completamente inversibles:
 
1. esPeligroso/1. Nos dice si un personaje es peligroso. Eso ocurre cuando:
* realiza alguna actividad peligrosa: ser matón, o robar licorerías. 
* tiene empleados peligrosos

2. duoTemible/2 que relaciona dos personajes cuando son peligrosos y además son pareja o amigos. Considerar que Tarantino también nos dió los siguientes hechos:

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

3.  estaEnProblemas/1: un personaje está en problemas cuando 
el jefe es peligroso y le encarga que cuide a su pareja
o bien, tiene que ir a buscar a un boxeador. 
Además butch siempre está en problemas. 

Ejemplo:

? estaEnProblemas(vincent)
yes. %porque marsellus le pidió que cuide a mia, y porque tiene que ir a buscar a butch

La información de los encargos está codificada en la base de la siguiente forma: 

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

4.  sanCayetano/1:  es quien a todos los que tiene cerca les da trabajo (algún encargo). 
Alguien tiene cerca a otro personaje si es su amigo o empleado. 

5. masAtareado/1. Es el más atareado aquel que tenga más encargos que cualquier otro personaje.

6. personajesRespetables/1: genera la lista de todos los personajes respetables. Es respetable cuando su actividad tiene un nivel de respeto mayor a 9. Se sabe que:
Las actrices tienen un nivel de respeto de la décima parte de su cantidad de peliculas.
Los mafiosos que resuelven problemas tienen un nivel de 10 de respeto, los matones 1 y los capos 20.
Al resto no se les debe ningún nivel de respeto. 

7. hartoDe/2: un personaje está harto de otro, cuando todas las tareas asignadas al primero requieren interactuar con el segundo (cuidar, buscar o ayudar) o un amigo del segundo. Ejemplo:

? hartoDe(winston, vincent).
true % winston tiene que ayudar a vincent, y a jules, que es amigo de vincent. 

8. Ah, algo más: nuestros personajes tienen características. Lo cual es bueno, porque nos ayuda a diferenciarlos cuando están de a dos. Por ejemplo:

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

Desarrollar duoDiferenciable/2, que relaciona a un dúo (dos amigos o una pareja) en el que uno tiene al menos una característica que el otro no. 















