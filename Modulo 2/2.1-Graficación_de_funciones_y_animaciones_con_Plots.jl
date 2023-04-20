### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 33f8289b-3e80-48a1-8a2c-ef6d2d2f107e
using Plots, PlutoUI

# ╔═╡ 8302701b-02ac-4d35-b7de-5dec8fe701fb
using LaTeXStrings

# ╔═╡ 967d628f-d940-45ae-ad80-947b15d8c099
html"""
<style>
	main {
		margin: 0 auto;
		max-width: 2000px;
    	padding-left: max(160px, 10%);
    	padding-right: max(160px, 10%);
	}
</style>
"""

# ╔═╡ c3db98d4-84a3-11ec-17c2-7510b678ee8a
md"# Graficación de funciones y animaciones con _Plots_"

# ╔═╡ b3f850d8-60d4-4798-9beb-d42a9cdac9ae
md"## Graficación de funciones

Las computadoras grafican funciones de la misma manera en que tú lo haces en papel: forman un _arreglo_ con algunos valores de la variable independiente junto a sus respectivas imágenes bajo la función (a este proceso, como quizás recuerdes, se le llama _tabulación_), y luego marcan esos puntos sobre un plano cartesiano o espacio euclideano, dependiendo del tipo de función que se trate. La principal diferencia entre tú y ellas es la apantallante **velocidad** con la que ellas pueden hacerlo, por lo que a menudo resulta conveniente asignarles esta tarea ;)

"

# ╔═╡ 8c5b9695-3625-4105-8a4f-9358e208115c
md" ### Gráficas bidimensionales

#### Las funciones `plot` y `scatter`

¡Empecemos a graficar! Las principales funciones para graficar del paquete `Plots` son **`plot`** -para funciones continuas- y **`scatter`** -para conjuntos discretos de datos. Empezaremos graficando con el comando `plot(func,arr)`, donde `func` es el **nombre** de la función que queremos graficar y `arr` es el arreglo a partir del cual queremos que tabule. Por ejemplo, grafiquemos la función `sin` de `0` a `2π`:

"

# ╔═╡ 67c22c14-24a6-4080-803b-fba2be7d0fa4
plot(sin,0:2π) #Grafica "sin" en el rango 0:2π

# ╔═╡ 22a9aee4-4c6d-47d3-8cca-e41e542a84ed
md"""

¡Se ve horrible! ¡¿Qué sucedió?! Observemos más atentamente los argumentos que le pusimos a `plot`:
* `sin` es la implementación de la función $\sin(x)$ en Julia, así que no hay problema ahí;
* `0:2π` es un arreglo de `0` a `2π`... _¡con "pasos" de tamaño uno!_
"""

# ╔═╡ 9520d566-f123-4b83-aa35-daebe75a83bd
md"Por lo tanto, al ejecutar la celda anterior en realidad sólo hicimos que Julia tabulara los valores de `sin` en los números _enteros_ entre `0` y `2π`. Nota que la función `plot` luego _unió los puntos tabulados con líneas rectas_; para ver sólo los puntos tabulados, podemos utilizar la función `scatter` con la misma sintáxis, i.e. `scatter(func,arr)`:"

# ╔═╡ 9bfbf61b-66b5-42d3-878b-fb02dd6d41ee
scatter(sin,0:2π) #Tabula "sin" en el rango 0:2π

# ╔═╡ e16ca2f5-4af7-4d16-b76e-4f124e1ddbbf
md"

Lo que hacen ambas funciones es
* tomar el arreglo de puntos de la variable independiente dado y
* obtener un arreglo de imágenes aplicando la función a todos los puntos del primer arreglo (igual a `func.(arr)`);

en lo que difieren es que
* `scatter` _grafica los pares ordenados_ obtenidos de la tabulación _con puntos_, mientras que
* `plots` _une los pares ordenados_ obtenidos de la tabulación _con líneas rectas_.
"

# ╔═╡ 7aaa5703-23a4-4c5d-8a1a-c12ff73d5a14
md"""Para mejorar la gráfica que hicimos con `plot`, podemos meter un "tamaño de paso" más pequeño en el arreglo que le alimentamos a la función `plot`:"""

# ╔═╡ 98c6c916-cdfa-4bc1-baad-8888aace5c98
plot(sin,0:0.05:2π) #¡Mucho mejor! :D

# ╔═╡ c6a475fd-bef2-4c09-a03b-211f6676d215
md"

Dado que evaluar una infinidad de valores le tomaría a una computadora una infinidad de tiempo, las tabulaciones que realizan al graficar deben ser finitas. Por ende, cuando graficamos, por ejemplo, una función de variable real con `plots`, la gráfica que obtenemos es en realidad la gráfica de una _aproximación discreta_ de la función en cuestión, unida por líneas rectas.

Sin embargo, podemos controlar el _nivel de detalle_ de nuestra gráfica controlando _el número de puntos en el arreglo de entrada_. Una forma de hacer esto es:
* definir los extremos del dominio de nuestra gráfica,
* crear un arreglo de intervalos uniformes de longitud paramétrica `l` que cubran el dominio de nuestra gráfica, y
* modificar el parámetro `l` a nuestra conveniencia.

"

# ╔═╡ d2472d6a-7072-49ae-ba55-207db17be3ca
begin
	l = 2            #¡Cambia el valor asignado a l, ejecuta la celda
	plot(sin,0:l:2π) #y observa qué sucede con la gráfica!
end

# ╔═╡ 4d136dae-c66d-4c9e-a267-12b2fa9fd596
md""" Con un poquito de 'magia' de Pluto, podemos hacer que el parámetro de longitud sea _interactivo_ (también existe una manera de hacer esto en Jupyter). Nota que cambiaremos el nombre del parámetro a `l1` para no generar conflicto con la variable `l` definida anteriormente pues, en Pluto, cada vez que ejecutas una celda, Pluto después vuelve a ejecutar todas las demás celdas para "actualizarlas". """

# ╔═╡ af69d454-96fc-4e92-af71-1251cf99ae38
@bind l1 Slider(0.05:0.05:2, default=0.5)
#Asignamos un valor a 'l1' a través de un deslizador interactivo que toma valores en 0.05:0.05:2.

# ╔═╡ 576a42f0-bd11-4480-9e97-2f9098312a25
plot(sin,0:l1:2π)

# ╔═╡ cdd16f8e-e945-4d5f-a71d-6896f9146512
l1 #Mostramos el valor asignado a 'l1'

# ╔═╡ 35d05477-a09e-4077-8513-2ac7dba4def1
scatter(sin,0:l1:2π)

# ╔═╡ fe4198bf-345a-46e5-bfeb-15619bd76f3a
md""" #### Las funciones "modificadoras" `plot!` y `scatter!`

El ejemplo anterior se vería mejor si pudiéramos encimar ambas gráficas. Para esto existen las funciones **`plot!`** y **`scatter!`** que, a diferencia de `plot` y `scatter`, _no borran las gráficas anteriores_ sino que _dibujan encima de ellas_.

"""

# ╔═╡ c6c40996-bb5f-4c4b-848b-821c79660042
@bind l2 Slider(0.05:0.05:2, default=0.5)

# ╔═╡ d6a012c7-47b6-4374-8522-aa8e6efbe84f
l2

# ╔═╡ 4d68a04e-6502-4478-a9c2-8a81bcc2b282
begin
    plot(sin,0:l2:2π)     #Haz una gráfica tipo 'plot' y luego
    scatter!(sin,0:l2:2π) #haz una gráfica tipo 'scatter' encima.
end

# ╔═╡ d8875d6b-7a53-43ad-87b4-5088e0fc9eac
md" Noten que el código anterior esencialmente da el mismo resultado que"

# ╔═╡ 0dd653e6-323f-450d-9097-ba4c0a304aa3
begin
    scatter(sin,0:l2:2π) #Haz una gráfica tipo 'scatter' y luego
	plot!(sin,0:l2:2π)   #haz una gráfica tipo 'plot' encima.
end

# ╔═╡ 809327b3-0353-4519-a586-93403d121169
md""" #### Atributos de figuras

La única diferencia entre las dos figuras anteriores es el color de cada gráfica y, por consecuencia, la leyenda. Este tipo de "detalles" se conocen como los [_atributos_](https://docs.juliaplots.org/latest/tutorial/#Plot-Attributes) de una figura, y pueden ser configurados dentro de los argumentos de estas funciones. Como ejemplo, la siguiente celda tiene una figura con los siguientes atributos configurados:
* `title` - el título de la figura;
* `xlabel` - la etiqueta del eje horizontal;
* `ylabel` - la etiqueta del eje vertical;
* `color` - el color de la gráfica en cuestión;
* `label` - el nombre de la gráfica en cuestión (nota que aparece dos veces);
* `marker` - la forma del símbolo utilizado para marcar la gráfica.

"""

# ╔═╡ d0ec9526-1bf9-4e38-be43-9aeedc56e97e
begin
	plot(sin, 0:0.25:2π, title = "plot y scatter", xlabel = "x", ylabel = "sin(x)", color = "darkorange", label = "plot")
    scatter!(sin, 0:0.25:2π, color = "green", label = "scatter", marker = :diamond)
end

# ╔═╡ f08d2863-8e08-4df1-a3e9-5914dc8f1600
md"De hecho, agregarle un atributo `marker = true` a una gráfica tipo `plot` nos mostrará los puntos que tabuló:"

# ╔═╡ fc94b6e8-cae9-46bc-9ac4-9cee5e86c8ee
begin
	plot(sin, 0:0.25:2π, title = "plot con atributo 'marker = true'", xlabel = "x", ylabel = "sin(x)", color = "darkorange", label = "plot", marker = true)
end

# ╔═╡ 77a60b5d-ad7f-4c44-a68d-694417619668
md"por lo que no es necesario llamar dos funciones cuando querramos hacer esto. Para quitar la leyenda, podemos agregar el atributo `legend = false` (_¡Inténtalo!_)."

# ╔═╡ 8b8aff3c-3d88-4022-bc86-b75ebefde2a3
md""" **Ejercicio** Define un parámetro interactivo `d` que controle el nivel de detalle de una gráfica tipo `plot` de las funciones `sin` y `cos` en el intervalo $[-\pi,\pi]$, con el título "Funciones trigonométricas", donde cada función se grafique con un color diferente y la leyenda indique el nombre de cada función.

"""

# ╔═╡ 352372c9-b853-4ce7-918b-a8181dd4b44d
@bind l3 Slider(0.05:0.05:2, default=0.5)

# ╔═╡ 88c61030-f253-416d-acd1-49c6d4cb0fb9
begin
	plot(sin, -π:l3:π, title = "Funciones trigonométricas", xlabel = "x", ylabel = "y", color = "darkorange", label = "Seno")
  plot!(cos, -π:l3:π, title = "Funciones trigonométricas", xlabel = "x", ylabel = "y", color = "blue", label = "Coseno")
end

# ╔═╡ acfe0334-c7aa-471f-b39e-8276e2e3dd42
md"""#### El paquete `LaTeXStrings`

Podemos usar $\LaTeX$ para escribir texto dentro de una gráfica creada con Plots, pero tiene una sintáxis complicada. Por ejemplo, si quisiéramos que la etiqueta del eje vertical de la gráfica anterior estuviera escrita como $\sin(x)$, tendríamos que reemplazar el `String` `"sin(x)"` por (¡inténtalo!)

`"\$\\sin(x)\$"`.

Afortunadamente, el paquete [LaTeXStrings](https://github.com/stevengj/LaTeXStrings.jl) facilita este proceso. Primero debemos instalarlo y cargarlo, lo cual, en Pluto, se hace automáticamente sólo con la siguiente línea:

"""

# ╔═╡ 02f9778e-21c8-42db-bed6-95a20d592f22
md"""Luego, podemos escribir el String anterior simplemente como (¡inténtalo!)

`L"\sin(x)"` 

Es decir, si escribimos la letra `L` antes del inicio del `String` y el paquete LaTeXStrings está cargado, Julia interpretará el contenido del `String` utilizando LaTeX."""

# ╔═╡ 1907f78f-e429-4a77-a90e-c9ebb94d6385
md"""

#### Campos vectoriales con `quiver`

La función **`quiver`** nos permite graficar un conjunto de flechas en una gráfica bidimensional. La sintáxis usual es

`quiver(x, y, quiver=(v1,v2))`

donde
* `x` es un arreglo de puntos en el eje horizontal,
* `y` es un arreglo de puntos en el eje vertical, y
* `v1` y `v2` son arreglos con las coordenadas horizontales y verticales de las flechas, respectivamente.

Nota que, dado que todos los arreglos anteriores son numéricos, entonces son de tipo `Vector`.

Al ejecutar este comando:
1. Julia creará una figura de una gráfica bidimensional.
1. Para cada entrada `i` de los arreglos, Julia graficará una flecha que tendrá origen en las coordenadas `(x[i], y[i])` y cuyas coordenadas relativas serán `(v1[i], v2[i])`.
1. Para cualquiera de los arreglos `x, y, v1, v2` que tenga menos entradas que los demás, Julia ciclará sobre los elementos de ese arreglo (es decir, empezará desde el principio) hasta haber utilizado todas las entradas del arreglo más grande de los cuatro.
"""

# ╔═╡ d4f72b47-0c61-45af-85d6-ebe914cd6128
md"Por ejemplo:"

# ╔═╡ 18368069-bf83-48e9-a6df-a2b5e6181277
quiver([1,1.5,3], [3,2,1], quiver=([-0.5,1,-1], [-1,1,0.5]))
#=Julia crea una figura bidimensional y,
  partiendo del punto (1,3), grafica una flecha con coordenadas relativas (-0.5,-1);
  partiendo del punto (1.5,2), grafica una flecha con coordenadas relativas (1,1);
  partiendo del punto (3,1), grafica una flecha con coordenadas (-1,0.5).=#

# ╔═╡ ec3dfa07-89c8-48a3-adaf-021c311d2c0d
md"""

Si alguno de los primeros dos argumentos de la función `quiver` es un vector renglón y el otro es un vector columna, la función `quiver` automáticamente hará una malla de puntos con el producto cartesiano de ambos arreglos. Esto es útil para, por ejemplo, graficar campos vectoriales. Primero, definimos una función de $\mathbb{R}^2$ en $\mathbb{R}^2$

"""

# ╔═╡ 73d1cb8f-4fc5-4a11-885d-9bc97ecd73d9
g(x,y) = [3x^2 - 3; 2y] / 50

# ╔═╡ 324cf67f-7cf1-4613-b072-aff38958612f
md"""

y, después, ejecutamos la función `quiver` _reemplazando el tercer argumento por_ `quiver=g` _en vez de_ `quiver=(v1,v2)`

"""

# ╔═╡ 7c580a14-b5ec-4bb1-960b-fbce583a9b62
quiver((-2:0.2:2)', (-2:0.2:2) , quiver=g, color="green") #¡La apóstrofe ' traspone matrices!

# ╔═╡ 3910bcbb-0e94-4c70-93c4-106a5fd4006a
md""" #### Conjuntos de nivel con `contour`

Consideremos la siguiente función de $\mathbb{R}^2$ en $\mathbb{R}$:

"""

# ╔═╡ d6d981f5-155f-4fa9-8985-ef9a1aa8e28c
h(x,y) = cos(x) + sin(y)

# ╔═╡ cc3f06b5-68b4-40c6-85ce-cb79a7f3a9df
md"""

Claramente, no podemos obtener una gráfica bidimensional completa de esta función, pues requerimos tres dimensiones... ¿o sí? En las gráficas que hemos visto hasta el momento, tenemos dos dimensiones _espaciales_, pero les podemos agregar una dimensión de _color_ y obtener una representación (al menos parcial) de nuestra función de $\mathbb{R}^2$ en $\mathbb{R}$. Esto se logra con la función **`contour`**. La sintáxis usual es `contour(x,y,h)`, donde
* `x` es un arreglo que define el rango del eje horizontal,
* `y` es un arreglo que define el rango del eje vertical y
* `h` es una función que toma dos argumentos y devuelve un número.
"""

# ╔═╡ 86c6332b-da98-41e2-96ec-12ab5692ac37
md"Por ejemplo:"

# ╔═╡ 7c8f914f-ad47-4487-8434-f02f2ce6d9e6
begin
    R = 0:0.05:2π #Definimos arbitrariamente un rango 'R' que utilizaremos para algunos ejemplos.
    contour(R,R,h)
end

# ╔═╡ 28bff1c1-4fe1-41ce-92fa-09277a48762b
md"Para tener una representación más completa de la función, podemos usar el atributo `fill` y asignarle el valor `true` o, equivalentemente, usar la función `contourf`:"

# ╔═╡ 8af3a0a7-df3b-4204-a806-9c330e636d84
contour(R,R,h,fill=true)
#Esto es equivalente a contourf(0:0.05:2π,0:0.05:2π,h).

# ╔═╡ db29912b-936a-4770-9f3b-fcd57a1ffd3a
md"""### Gráficas tridimensionales

A continuación, veremos varias formas diferentes de hacer gráficas de tres dimensiones espaciales.

"""

# ╔═╡ cd549e6e-23f6-4591-a21e-bcc3936e4b0e
md"""#### Puntos en tres dimensiones con `scatter`

Supongamos que `x`, `y` y `z` son arreglos de números y ejecutamos la función `scatter` con estos _tres_ argumentos:

`scatter(x,y,z)`

Al ejecutar este comando:
1. Julia creará una figura de una gráfica tridimensional. 
1. Para cada entrada `i` de los arreglos, Julia graficará un punto en la coordenada `(x[i], y[i], z[i])`.
1. Para cualquiera de los arreglos `x`, `y`, `z` que tenga menos entradas que los demás, Julia ciclará sobre los elementos de ese arreglo hasta haber utilizado todas las entradas del arreglo más grande de los tres.

Por ejemplo:

"""

# ╔═╡ 690f92de-4beb-452b-be8e-9469efd06632
scatter(0:10,0:10,0:10)

# ╔═╡ 2caaaf8d-21f2-4cb8-9c06-b84e36b7e28c
md"""En particular, el arreglo `z` se puede obtener aplicando una función de dos variables a los arreglos `x` y `y`.

Por ejemplo, utilizando la función `h` definida anteriormente y la sintáxis "de punto" para aplicarle algo a un arreglo

`h.(A,B)`

para evaluarla en los puntos del arreglo `[ [A[1],B[1]], [A[2],B[2]], ... ]`, tenemos:"""

# ╔═╡ 3497133e-f009-47ba-bb70-c3c6d0b8bf7c
scatter(R,R,h.(R,R))

# ╔═╡ 162a90d2-eda7-4a3a-b433-8c323bcf1334
md"""

#### Curvas en tres dimensiones con `plot`

Análogamente al ejemplo en gráficas de dos dimensiones, si queremos unir puntos por líneas rectas, podemos reemplazar la función `scatter` por `plot`:

"""

# ╔═╡ c5101ce8-7a70-421a-81c6-efa16b368dd1
plot(R,R,h.(R,R))

# ╔═╡ 33cfe266-21ab-43e5-bcca-ec75dd12f49b
md"""#### Superficies en tres dimensiones con `surface` y `wireframe`

Para graficar una función de $\mathbb{R}^2$ en $\mathbb{R}$ como una _superficie_, utilizamos la función `surface`. La sintáxis usual es

`surface(x,y,h)`

donde
* `x` es un arreglo con un rango de valores del eje horizontal,
* `y` es un arreglo con un rango de valores del eje vertical, y
* `h` es la función en cuestión.
"""

# ╔═╡ b541f5cb-6047-4322-bcaa-c5c1c695d766
md"Por ejemplo:"

# ╔═╡ 56c967bd-feb0-4266-8209-3c97379152b1
surface(R,R,h, color = :gist_rainbow)

# ╔═╡ 8eefdb22-91ad-494b-979a-d3b2a17f706e
md"Para representar esta superficie como una _malla_ creada a partir de los puntos de la forma `(x[i],y[i])` en los que se evalúa la función `h`, podemos usar la función `wireframe` con la misma sintáxis que `surface`:"

# ╔═╡ 2d598963-c0e9-4808-93b0-d02740da047c
wireframe(R,R,h)

# ╔═╡ e97b0843-45c9-4131-a52c-4880a644d5cb
md"**Nota** Las funciones `quiver`, `contour`, `surface` y `wireframe` también tienen su versión _modificadora_ con el símbolo `!` al final."

# ╔═╡ 754d5a6b-845b-4074-8686-96e1b57e088d
md"""## Animaciones

### `@gif`

Podemos animar un conjunto de gráficas colocando **`@gif`** al inicio de un ciclo _for_ que genere las gráficas.

Por ejemplo, sabemos que la función de dos variables

$$A\sin(Bx - t) + C$$

describe una onda sinodal que se mueve hacia la derecha, donde $A$ es la amplitud de la onda, $B$ es la frecuencia, y $C$ es la distancia del origen de la onda al eje horizontal.

Podemos animar esto como sigue:

"""

# ╔═╡ 0b199197-6d85-4530-b70f-b82e16d183d6
begin
	A, B, C = 0.5, 2, 0.25 #Definimos los valores de los parámetros A, B y C,
	f(x) = A*sin(B*x)+C    #así como la función f.
	
	@gif for t in 0:0.1:2π #Por cada t en 0:0.1:2π,
	plot(f.( range(0,2π, step = 0.1) .- t/B),      #grafica Asin(B(x-t/B))+C para todas las x en
		 legend = false, title = L"A\sin(Bx-t)+C") #el rango de 0 a 2π con tamaño de paso 0.1.
	end
end

# ╔═╡ 09c41f2a-2be2-48e5-9b83-6e066c7e03bf
md""" ### `@animate` y la función `gif`

Otra forma de animar un conjunto de gráficas es utilizando **`@animate`** y la _función_ **`gif`**. Este método permite especificar el nombre del archivo que se generará al hacer la animación, así como la cantidad de cuadros por segundo, como se muestra en el siguiente ejemplo:
"""

# ╔═╡ 46154837-a68e-4bf0-b39f-2b8670d9370c
begin

	#=Recordatorio: No hace falta definir los valores de los parámetros A, B y C ni la función f, 
	  pues ya fueron definidos en otra celda y Pluto ejecuta todas las celdas al mismo tiempo.=#
	
	anim = @animate for t in 0:0.1:2π # Por cada t ∈ 0:0.1:2π,
	plot(f.( range(0,2π, step = 0.1) .- t/B),      #grafica Asin(B(x-t/B))+C para todas las x en
		 legend = false, title = L"A\sin(Bx-t)+C") #el rango de 0 a 2π con tamaño de paso 0.1.
	end

	gif(anim, "ondaEnMovimiento.gif", fps = 30)
    #=Convertimos a la variable 'anim' en un gif de nombre
	"onda_en_movimiento.gif" con 30 cuadros por segundo.=#
	
end

# ╔═╡ 167dcedf-786f-471c-83ae-d8a09885005d
md""" #### ¿Pero qué son `@animate` y `@gif`?

`@animate` y `@gif` son ejemplos de _macros_, que tienen que ver con _metaprogramación_ (lo cual no veremos en este curso). Básicamente, un _macro_ es una función cuyo trabajo es _modificar código_. En Julia, los nombres de los _macros_ inician con el símbolo `@`. 

La forma de generar la misma animación anterior _sin utilizar macros_ sería como sigue:

"""

# ╔═╡ 765a0e10-4217-4a50-8fb1-e46bee83aaa6
begin
	anim2 = Plots.Animation() #Hay que definir una variable asignándole 'Plots.Animation()'
		
	for t in 0:0.1:2π
		plot(f.( range(0,2π, step = 0.1) .- t/B),
		     legend = false, title = L"A\sin(Bx-t)+C")
		
		Plots.frame(anim2)   #y agregar un cuadro a nuestra variable por cada gráfica generada
	end

	gif(anim2, "ondaEnMovimiento.gif", fps = 30)
end

# ╔═╡ abbce622-7912-40ee-8632-261b5129dcb4
md"Los _macros_ simplemente nos ahorran el tener que escribir secciones de códigos recurrentes."

# ╔═╡ 7577805b-1d52-47e4-aa45-2652943db1cf
md"""**Ejercicio** Haz un código donde definas cuatro variables `h`, `r`, `θ` y `t`, y animes el tiro parabólico de una partícula lanzada desde una altura `h` con rapidez `r` a un ángulo `θ` durante un tiempo `t`. La partícula se debe representar con un círculo y su trayectoria se debe ir trazando con una línea punteada. La animación debe terminar en cuanto la partícula toque el "suelo".

Sugerencia: Repasa las ecuaciones cinemáticaticas del tiro parabólico e investiga los atributos `xaxis` y `yaxis` para poder fijar los ejes de la gráfica durante la animación."""

# ╔═╡ 50f7f46b-081e-4b07-94af-1331b33a7c7f
begin
  altu=3 #Aquí defino mis parámetros
  r=3
  θ=π/3

  Vox=r*cos(θ) #Aquí defino las componentes del vector velocidad de la partícula
  Voy=r*sin(θ)
  

  k(x) =((Vox)*x,altu + (Voy)*x -9.81*x^2/2) #Aquí defino el vector posición y sus componentes 
  k_x(x)= (Vox)*x
  k_y(x) = altu + (Voy)*x -9.81*x^2/2

	anima = @animate for t in 0:0.1:3 # Por cada t ∈ 0:0.1:2π,
	plot(k.( range(-(3),0, step = 0.1) .+t),      
		 legend = false, title = "Tiro parabólico",lw=3, ls=:dot) #Aquí se grafica la línea punteada
	
  scatter!([k_x(t)],[k_y(t)])                                 #Aquí se grafica la partícula

  x_max= Vox*((2*Voy/9.81+((2*Voy/9.81)^2+8*altu/9.81)^(1/2))/2) #Estas variables son el alacance horizontal máximo
  y_max= altu + (Voy)*(Voy/9.81) -9.81*(Voy/9.81)^2/2            #y altura máxima, se calculan para fijar los ejes. 
  xlabel!("x")
  ylabel!("y")
  xlims!(0,x_max+0.5)
  ylims!(0,y_max+0.5)

  end

	gif(anima, "Tiro_Parabólico.gif", fps = 30)
    #=Convertimos a la variable 'anima' en un gif de nombre
	"Tiro_Parabólico.gif.gif" con 30 cuadros por segundo.=#
	
end

# ╔═╡ 59ec3890-303c-436a-8043-8e6bc9c427ed
md"**Ejercicio** Crea una función que tome parámetros `h`, `r`, `θ` y `t`, y haga lo descrito en el Ejercicio anterior."

# ╔═╡ c3264b4d-81b1-4e0c-9205-ff818665788c
begin

function Tiro_Parabolico(h,r,θ)
  altu=h #Aquí defino mis parámetros


  Vox=r*cos(θ) #Aquí defino las componentes del vector velocidad de la partícula
  Voy=r*sin(θ)
  

  k(x) =((Vox)*x,altu + (Voy)*x -9.81*x^2/2) #Aquí defino el vector posición y sus componentes 
  k_x(x)= (Vox)*x
  k_y(x) = altu + (Voy)*x -9.81*x^2/2

	anima = @animate for t in 0:0.1:3 # Por cada t ∈ 0:0.1:3,
	plot(k.( range(-(3),0, step = 0.1) .+t),      
		 legend = false, title = "Tiro parabólico",lw=3, ls=:dot) #Aquí se grafica la línea punteada
	
  scatter!([k_x(t)],[k_y(t)])                                 #Aquí se grafica la partícula

  x_max= Vox*((2*Voy/9.81+((2*Voy/9.81)^2+8*altu/9.81)^(1/2))/2) #Estas variables son el alacance horizontal máximo
  y_max= altu + (Voy)*(Voy/9.81) -9.81*(Voy/9.81)^2/2            #y altura máxima, se calculan para fijar los ejes 
  xlabel!("x")                                                   #y que nos muestren toda la trayectoria de la partícula.
  ylabel!("y")
  xlims!(0,x_max+0.5)
  ylims!(0,y_max+0.5)

  end

	gif(anima, "Tiro_Parabólico.gif", fps = 30)
    #=Convertimos a la variable 'anima' en un gif de nombre
	"Tiro_Parabólico.gif.gif" con 30 cuadros por segundo.=#
end
end

# ╔═╡ 4e3e810d-bbd4-49d0-b81d-823b0d74bf66
Tiro_Parabolico(1,3,π/3)

# ╔═╡ 77aacd79-26e3-40c2-ac22-f9121aac4155
md"""**Ejercicio** Crea una animación de cómo la superficie obtenida de la función $h(x,y) = \cos(x) + \sin(y)$ se desplaza hacia el eje vertical.
"""

# ╔═╡ 4e68ad0c-17ef-41f7-b9fe-8561415bb7f2
begin
default(legend = false)
x = y = range(-5, 5, length = 40)
zs = zeros(0, 40)
n = 100

@gif for i in range(0, stop = 2π, length = n)
    b(x, y) = cos(x + 10sin(i)) + sin(y) 
    
    p = plot(x, y, b, st =:surface, color = :gist_rainbow)
    fixed_x = zeros(40)
    z = map(b, fixed_x, y)

end
end

# ╔═╡ 88299b4d-2a7d-4c18-956e-c6e75473c658
md" ## Recursos complementarios

* Repositorio de GitHub del paquete [`Pluto`](https://github.com/fonsp/Pluto.jl).
* Documentación de [`Plots`](https://docs.juliaplots.org/stable/).
* Documentación de las funciones de [`Plots`](https://docs.juliaplots.org/latest/api/)
* Repositorio de GitHub del paquete [LaTeXStrings](https://github.com/stevengj/LaTeXStrings.jl).
* Tutorial de [backends de Plots](https://docs.juliaplots.org/latest/tutorial/#plotting-backends) en Julia.
* Manual de [backends de Plots](https://docs.juliaplots.org/latest/backends/) en Julia.
* Manual de [Animaciones](https://docs.juliaplots.org/latest/animations/) en Julia.
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
LaTeXStrings = "~1.3.0"
Plots = "~1.27.5"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "77e2734aeac55d5109eeed492b1ea958eae44caf"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cc37d689f599e8df4f464b2fa3870ff7db7492ef"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c6d890a52d2c4d55d326439580c3b8d0875a77d9"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.7"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "1cd7f0af1aa58abc02ea1d872953a97359cb87fa"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.4"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "c98aea696662d09e215ef7cda5296024a9646c75"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.4"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "bc9f7725571ddb4ab2c4bc74fa397c1c5ad08943"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.69.1+0"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "0eb6de0b312688f852f347171aba888658e29f20"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.3.0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "303202358e38d2b01ba46844b92e48a3c238fd9e"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.6"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "c95373e73290cf50a8a22c3375e4625ded5c5280"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "6f2dd1cf7a4bbf4f305a0d8750e351cb46dfbe80"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "dc1e451e15d90347a7decc4221842a022b011714"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.2"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "b8d897fe7fa688e93aef573711cb207c08c9e11e"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.19"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "GPUArraysCore", "StaticArraysCore", "Tables"]
git-tree-sha1 = "521a0e828e98bb69042fec1809c1b5a680eb7389"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.15"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "1544b926975372da01227b382066ab70e574a3ec"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6edfe154ad7b313c01aceca188c05c835c67360"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.4+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─967d628f-d940-45ae-ad80-947b15d8c099
# ╠═c3db98d4-84a3-11ec-17c2-7510b678ee8a
# ╠═33f8289b-3e80-48a1-8a2c-ef6d2d2f107e
# ╠═b3f850d8-60d4-4798-9beb-d42a9cdac9ae
# ╠═8c5b9695-3625-4105-8a4f-9358e208115c
# ╠═67c22c14-24a6-4080-803b-fba2be7d0fa4
# ╠═22a9aee4-4c6d-47d3-8cca-e41e542a84ed
# ╠═9520d566-f123-4b83-aa35-daebe75a83bd
# ╠═9bfbf61b-66b5-42d3-878b-fb02dd6d41ee
# ╠═e16ca2f5-4af7-4d16-b76e-4f124e1ddbbf
# ╠═7aaa5703-23a4-4c5d-8a1a-c12ff73d5a14
# ╠═98c6c916-cdfa-4bc1-baad-8888aace5c98
# ╠═c6a475fd-bef2-4c09-a03b-211f6676d215
# ╠═d2472d6a-7072-49ae-ba55-207db17be3ca
# ╠═4d136dae-c66d-4c9e-a267-12b2fa9fd596
# ╠═576a42f0-bd11-4480-9e97-2f9098312a25
# ╠═af69d454-96fc-4e92-af71-1251cf99ae38
# ╠═cdd16f8e-e945-4d5f-a71d-6896f9146512
# ╠═35d05477-a09e-4077-8513-2ac7dba4def1
# ╠═fe4198bf-345a-46e5-bfeb-15619bd76f3a
# ╠═d6a012c7-47b6-4374-8522-aa8e6efbe84f
# ╠═c6c40996-bb5f-4c4b-848b-821c79660042
# ╠═4d68a04e-6502-4478-a9c2-8a81bcc2b282
# ╟─d8875d6b-7a53-43ad-87b4-5088e0fc9eac
# ╠═0dd653e6-323f-450d-9097-ba4c0a304aa3
# ╠═809327b3-0353-4519-a586-93403d121169
# ╠═d0ec9526-1bf9-4e38-be43-9aeedc56e97e
# ╠═f08d2863-8e08-4df1-a3e9-5914dc8f1600
# ╠═fc94b6e8-cae9-46bc-9ac4-9cee5e86c8ee
# ╟─77a60b5d-ad7f-4c44-a68d-694417619668
# ╠═8b8aff3c-3d88-4022-bc86-b75ebefde2a3
# ╠═352372c9-b853-4ce7-918b-a8181dd4b44d
# ╠═88c61030-f253-416d-acd1-49c6d4cb0fb9
# ╠═acfe0334-c7aa-471f-b39e-8276e2e3dd42
# ╠═8302701b-02ac-4d35-b7de-5dec8fe701fb
# ╟─02f9778e-21c8-42db-bed6-95a20d592f22
# ╠═1907f78f-e429-4a77-a90e-c9ebb94d6385
# ╟─d4f72b47-0c61-45af-85d6-ebe914cd6128
# ╠═18368069-bf83-48e9-a6df-a2b5e6181277
# ╠═ec3dfa07-89c8-48a3-adaf-021c311d2c0d
# ╠═73d1cb8f-4fc5-4a11-885d-9bc97ecd73d9
# ╠═324cf67f-7cf1-4613-b072-aff38958612f
# ╠═7c580a14-b5ec-4bb1-960b-fbce583a9b62
# ╠═3910bcbb-0e94-4c70-93c4-106a5fd4006a
# ╠═d6d981f5-155f-4fa9-8985-ef9a1aa8e28c
# ╠═cc3f06b5-68b4-40c6-85ce-cb79a7f3a9df
# ╟─86c6332b-da98-41e2-96ec-12ab5692ac37
# ╠═7c8f914f-ad47-4487-8434-f02f2ce6d9e6
# ╠═28bff1c1-4fe1-41ce-92fa-09277a48762b
# ╠═8af3a0a7-df3b-4204-a806-9c330e636d84
# ╠═db29912b-936a-4770-9f3b-fcd57a1ffd3a
# ╠═cd549e6e-23f6-4591-a21e-bcc3936e4b0e
# ╠═690f92de-4beb-452b-be8e-9469efd06632
# ╠═2caaaf8d-21f2-4cb8-9c06-b84e36b7e28c
# ╠═3497133e-f009-47ba-bb70-c3c6d0b8bf7c
# ╠═162a90d2-eda7-4a3a-b433-8c323bcf1334
# ╠═c5101ce8-7a70-421a-81c6-efa16b368dd1
# ╠═33cfe266-21ab-43e5-bcca-ec75dd12f49b
# ╟─b541f5cb-6047-4322-bcaa-c5c1c695d766
# ╠═56c967bd-feb0-4266-8209-3c97379152b1
# ╠═8eefdb22-91ad-494b-979a-d3b2a17f706e
# ╠═2d598963-c0e9-4808-93b0-d02740da047c
# ╟─e97b0843-45c9-4131-a52c-4880a644d5cb
# ╠═754d5a6b-845b-4074-8686-96e1b57e088d
# ╠═0b199197-6d85-4530-b70f-b82e16d183d6
# ╟─09c41f2a-2be2-48e5-9b83-6e066c7e03bf
# ╠═46154837-a68e-4bf0-b39f-2b8670d9370c
# ╠═167dcedf-786f-471c-83ae-d8a09885005d
# ╠═765a0e10-4217-4a50-8fb1-e46bee83aaa6
# ╟─abbce622-7912-40ee-8632-261b5129dcb4
# ╟─7577805b-1d52-47e4-aa45-2652943db1cf
# ╠═50f7f46b-081e-4b07-94af-1331b33a7c7f
# ╟─59ec3890-303c-436a-8043-8e6bc9c427ed
# ╠═c3264b4d-81b1-4e0c-9205-ff818665788c
# ╠═4e3e810d-bbd4-49d0-b81d-823b0d74bf66
# ╟─77aacd79-26e3-40c2-ac22-f9121aac4155
# ╠═4e68ad0c-17ef-41f7-b9fe-8561415bb7f2
# ╟─88299b4d-2a7d-4c18-956e-c6e75473c658
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
