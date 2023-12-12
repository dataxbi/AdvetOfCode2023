// Esta es la solución en Power Query M a la segunda parte del día 1 del Advent of Code 2023

let
  //Fichero con los textos a procesar
  RutaFicheroDatos = "C:\Users\nlope\source\repos\AdventOfCode2023\dia_01_input.txt",
  
  // Se guarda el contenido del fichero en una lista
  Origen = Lines.FromBinary(File.Contents(RutaFicheroDatos), null, null, 1252),
  
  // Se crea un registro para mapear cada palabra con su número 
  mapaPalabraADigito = [one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"],
  
  // Función que convierte las palabras que representen números a el dígito correspondiente.
  // Hay que revisar cada caracter del texto original de izquierda a derecha para ir identificando si van apareciendo las palabras que indican números.
  // Por ejemplo, se puede presenetar esta situación: 
  // eightwothree  
  // en este caso hay que extrar el 8 y el 2 que se solapan en eightwo y el 3 de three, para que la línea quede así:
  // 823        
  fxConvertirPalabrasADigitos = (textoOriginal as text) as text =>
    List.Accumulate (
      {0..Text.Length(textoOriginal) - 1},
      "",
      (textoAcumulado, indice) => 
        let 
          textoOriginalDesdeIndice = Text.Middle(textoOriginal,indice),
          listaPalabraEncontrada = List.Select(Record.FieldNames(mapaPalabraADigito),(p) => Text.StartsWith(textoOriginalDesdeIndice,p)),
          palabraEncontrada = List.First(listaPalabraEncontrada),
          proximoTextoAcumulado = 
            if palabraEncontrada <> null then 
              textoAcumulado & Record.Field(mapaPalabraADigito,palabraEncontrada)
            else 
              textoAcumulado & Text.At(textoOriginal,indice)
        in
          proximoTextoAcumulado
    ),   
  
  // Función para extraer el primer y último dígitos, concatenarlos y convertirlos a un número
  fxExtraerPrimerUltimoDigitos = (textoOriginal as text) as number => 
    let
      soloDigitos = Text.Select(textoOriginal,{"0".."9"}),
      primerDigito = Text.Start(soloDigitos,1),
      ultimoDigito = Text.End(soloDigitos,1)
    in
      Number.From(primerDigito & ultimoDigito),

  // Función que aplica las dos funciones anteriores
  fxConvertirYExtraerPrimerUltimoDigitod = (textoOriginal as text) as number =>
    let
      palabrasADigitos = fxConvertirPalabrasADigitos(textoOriginal),
      extraerDigitos = fxExtraerPrimerUltimoDigitos(palabrasADigitos)
    in
      extraerDigitos,

  // Procesando cada línea del fichero original
  ConvertirYExtraerPrimerUltimoDigitos = List.Transform(Origen,fxConvertirYExtraerPrimerUltimoDigitod),

  // Obteniendo el valor final
  Sumar = List.Sum(ConvertirYExtraerPrimerUltimoDigitos)
in
  Sumar