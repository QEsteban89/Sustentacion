# Titulo: Encuesta representada con grafos 
# Autor: Jhoseth Esteban Muñoz Martinez
# Fecha: 27/10/2025

#Se descargan las librerias para visualizar el grafo en R que es igraph junto a la libreria readr
#para leer archivos .csv e interpretar los datos que albergan dentro.
library(igraph)
library(readr)

#Carga el archivo "Prueba64.csv" usando la funcion que admite este formato que son los punto y coma.
datos <- read_csv2("Prueba64.csv")

#Se limpia las filas con valores nulos para solo trabajar con los valores deseados.
datos <- na.omit(datos)

#Se crea un objecto el cual sera nuestra representacion general del grafos.
g <- make_empty_graph(directed = TRUE)

# Se extrae todos los datos para la construccion que estan ubicados en las columnas de interes con el fin de crear los vertices.
nodos <- unique(c(datos$`El trato de los clientes`, datos$`Días especiales de descuento`))

# Se añade los vertices del anterior paso al objecto grafo.
g <- add_vertices(g, nv = length(nodos), name = nodos)

# Creamos una funcion que itere por cada fila para la creacion de las aristas.
# usamos el objecto que almacenamos para guardar los datos del dataframe
for (i in 1:nrow(datos)) {
  desde <- datos$`El trato de los clientes`[i]  # Se define el nodo de origen de la conexión.
  hacia <- datos$`Días especiales de descuento`[i]  # Se define el nodo de destino.
  g <- add_edges(g, c(V(g)$name[V(g)$name == desde], V(g)$name[V(g)$name == hacia])) # Se añade la arista dirigida desde el origen al destino.
}

#Con la funcion "layaout_with_fr" evitamos las superposiciones entre nodos y lo escalamos por dos
# para aumentar la separacion
mi_layout <- layout_with_fr(g)
mi_layout <- mi_layout * 2

# Se renderiza el grafo con una serie de parámetros para mejorar su estética y legibilidad.
plot(g,
     layout = mi_layout,      # Aplica la disposición calculada       
     vertex.color = "skyblue", # Define el color de los nodos
     vertex.size = 12,         # Define el tamaño de los nodos
     vertex.label.cex = 0.75,         # Tamaño del texto de las etiquetas
     vertex.label.color = "black",    # Color del texto de las etiquetas
     vertex.label.dist = 1.3,        # Distancia entre el nodo y su etiquet
     edge.arrow.size = 0.4,          # Tamaño de la punta de las flechas
     main = "Grafo de Encuesta" # Título principal del gráfico
)