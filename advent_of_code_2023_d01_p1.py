''' Esta es la solución en Python con Pandas a la primera parte del día 1 del Advent of Code 2023
'''
import pandas as pd

# Fichero con los textos a procesar
RUTA_FICHERO_DATOS = 'dia_01_input.txt'

def extraer_primer_ultimo_digitos(texto_original):
    '''Función para extraer el primer y último dígitos, concatenarlos y convertirlo a un número
    '''
    digitos = list(filter(lambda c: c.isdigit(),texto_original))
    primer_digito = digitos[0]
    ultimo_digito = digitos[-1]
    return int(primer_digito + ultimo_digito)

# Cargando el contenido del fichero en un DataFrame con una columna con el nombre c1
df = pd.read_csv(RUTA_FICHERO_DATOS, header=None, names=['c1'], dtype='string')                           

# Aplicando la función anterior a cada fila del DataFrame
df['c2'] = df['c1'].apply(extraer_primer_ultimo_digitos)

# Obteniendo el valor final
suma = df['c2'].sum()

print(suma)