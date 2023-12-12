// Esta es la solución en Power Query M a la primera parte del día 1 del Advent of Code 2023

let
    // Fichero con los textos a procesar
    RutaFicheroDatos = "C:\Users\nlope\source\repos\AdventOfCode2023\dia_01_input.txt",
    
    // Se guarda el contenido del fichero en una lista
    Origen = Lines.FromBinary(File.Contents(RutaFicheroDatos), null, null, 1252),
    
    // Función para extraer el primer y último dígitos, concatenarlos y convertirlo a un número
    fxExtraerPrimerUltimoDigitos = (textoOriginal as text) as number => 
      let
        soloDigitos = Text.Select(textoOriginal,{"0".."9"}),
        primerDigito = Text.Start(soloDigitos,1),
        ultimoDigito = Text.End(soloDigitos,1)
     in
       Number.From(primerDigito & ultimoDigito),

    // Aplicando la función anterior a cada elemento de la lista
    ExtraerPrimerUltimoDigitos = List.Transform(Origen,fxExtraerPrimerUltimoDigitos),

    // Obteniendo el valor final
    Sumar = List.Sum(ExtraerPrimerUltimoDigitos)
in
    Sumar