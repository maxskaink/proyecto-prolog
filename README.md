#Desarrolladores
- Miguel Angel Calambas Vivas
- Esteban Santiago Escandon Causaya

#Entrega Proyecto prolog
En el menú “OLA INVERNAL”, debe aparecer los siguientes submenús y cada uno
abrirá una ventana nueva, que permitan contestar las siguientes preguntas:
1. ¿Qué enfermedad padece un individuo en particular? (este individuo será
ingresado desde teclado).
2. ¿Quiénes padecen gripe?
3. ¿Quiénes sienten dolor de estómago?
4. ¿Quiénes sienten cansancio?
5. ¿Qué fármaco aliviará a un individuo particular? (este individuo será ingresado
desde teclado).

De “Ola invernal”, se tiene la siguiente información:
Con la ola invernal que azota por estos días a nuestro país, se han presentado
una serie de enfermedades que han afectado a varias celebridades:
gustavo padece gripe.
shakira padece hepatitis.
juanes padece intoxicación.
francia padece hepatitis.
sofia padece gripe.
Además, dichas enfermedades tienen asociada una sintomatología:
La fiebre es síntoma de gripe.
El cansancio es síntoma de hepatitis.
El dolor de estómago es síntoma de intoxicación.
El cansancio es síntoma de gripe.

Ciertos fármacos ayudan a suprimir dichos síntomas:
La aspirina suprime la fiebre
El lomotil suprime el dolor de estómago

Además, se conoce el siguiente conocimiento inferido:
Un fármaco alivia una enfermedad si la enfermedad tiene un síntoma que es
suprimido por un fármaco.
Una persona debería tomar un fármaco si padece una enfermedad cuyos síntomas
pueden ser tratados por un fármaco.

Los hechos y reglas formuladas deben reflejar TODO el anterior conocimiento
indicado y permitir resolver las anteriores preguntas, las cuales se presentarán
como submenús individuales (menú desplegado hacia la derecha) de Ola invernal.
NOTA: En caso de que alguna pregunta no tenga respuesta asociada, se debe
mostrar un mensaje descriptivo al usuario.

En el menú “Árbol Familiar”, se abrirá una nueva ventana con título: Árbol
Familiar, en la cual se deberá colocar un botón para cada una de las preguntas
formuladas, 12 en total. La respuesta podrá ser mostrada en cuadros de mensaje
o en etiquetas (labels).

Del árbol familiar de la profesora Jimena se sabe que:
• javier, lisandro, carlos, matias y joaquin son hombres.
• maria, jimena, belkis y luisa son mujeres.
• jimena tiene como padres a javier y maria.
• carlos tiene como padres a javier y maria.
• matias tiene como padres a lisandro y jimena.
• joaquin tiene como padres a lisandro y jimena.
• luisa tiene como padres a carlos y belkis.
• javier y maria son esposos.
• lisandro y jimena son esposos.
• carlos y belkis son esposos.
• Se sabe además que alguien tiene una hermana, si esa hermana es mujer y
tienen los mismo padres.
• Se sabe además que alguien tiene un hermano, si ese hermano es hombre y
tienen los mismo padres.
• Se sabe que alguien es hijo de otra persona, si ese alguien es hombre y esa
otra persona hace parte de sus padres.
• Se sabe que alguien es hija de otra persona, si ese alguien es mujer y esa
otra persona hace parte de sus padres.
Responda las siguientes preguntas:
1. jimena tiene hermano?
2. ¿Quién es el hermano de jimena?
3. ¿Quiénes son los padres de carlos?
4. ¿Es jimena hija de javier?
5. ¿Es carlos hijo de maria?
6. ¿Es joaquin hijo de belkis?
7. ¿Es luisa hija de carlos?
8. ¿Es matias hijo de lisandro?
9. ¿Es matias hijo de jimena?
10.¿Quién es hijo de jimena?
11.¿Es joaquin hermano de matias?
12.¿Quién es el hermano de joaquin?

Luego, construya una regla que permita saber si alguien es tio(a) de otra persona.
En el ejemplo:
Si se pregunta:
?- tia(jimena,luisa) la respuesta será que sí.
Esta parte se hará a través de un botón adicional denominado “tio(a) de” y
solicitará al usuario el nombre de 2 personas, y permitirá deducir si la primera
persona es tio(a) de la segunda persona.
