''' Esta es la solución en Python con Pandas a la segunda parte del día 1 del Advent of Code 2023
'''
import pandas as pd

# Fichero con los textos a procesar
RUTA_FICHERO_DATOS = 'dia_01_input.txt'

# Se crea un diccionario para mapear cada palabra con su número 
MAPA_PALABRA_A_DIGITO = { 'one' : '1', 'two' : '2', 'three' : '3', 'four' : '4', 'five' : '5', 'six' : '6', 'seven' : '7', 'eight' : '8', 'nine' : '9'}

def convertir_palabras_a_digitos(s):
    '''Función que convierte las palabras que representen números a el dígito correspondiente.
    Hay que revisar cada caracter del texto original de izquierda a derecha para ir identificando si van apareciendo las palabras que indican números.
    Por ejemplo, se puede presenetar esta situación: 
      eightwothree  
    en este caso hay que extrar el 8 y el 2 que se solapan en eightwo y el 3 de three, para que la línea quede así:
      823        
    '''
    texto_acumulado = ''
    for i in range(len(s)):
        texto_original_desde_indice = s[i:]
        palabra_encontrada = None
        for p in MAPA_PALABRA_A_DIGITO.keys():
            if texto_original_desde_indice.startswith(p):
                palabra_encontrada = p
                break
        if palabra_encontrada is not None:
            texto_acumulado = texto_acumulado + MAPA_PALABRA_A_DIGITO[palabra_encontrada]
        else:
            texto_acumulado = texto_acumulado + s[i]
    return texto_acumulado

def extraer_primer_ultimo_digitos(texto_original):
    '''Función para extraer el primer y último dígitos, concatenarlos y convertirlo a un número
    '''
    digitos = list(filter(lambda c: c.isdigit(),texto_original))
    primer_digito = digitos[0]
    ultimo_digito = digitos[-1]
    return int(primer_digito + ultimo_digito)

def convertir_y_extraer_primer_ultimo_digitos(s):
    '''Función que aplica las dos funciones anteriores
    '''
    palabras_a_digitos = convertir_palabras_a_digitos(s)
    extraer_digitos = extraer_primer_ultimo_digitos(palabras_a_digitos)
    return extraer_digitos

# Cargando el contenido del fichero en un DataFrame con una columna con el nombre c1
df = pd.read_csv(RUTA_FICHERO_DATOS, header=None, names=['c1'], dtype='string')                           

# Aplicando la función anterior a cada fila del DataFrame
df['c2'] = df['c1'].apply(convertir_y_extraer_primer_ultimo_digitos)

# Obteniendo el resultado final
suma = df['c2'].sum()

print(suma)