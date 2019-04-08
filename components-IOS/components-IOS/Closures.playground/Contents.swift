import UIKit

//Closures

/*
 - Funciones globales que tiene un nombre y no capturan ningún valor
 - Funciones anidades con un nombre que puede capturar valores de la función englobante
 - Funciones sin nombre escrita en un contexto dentro de otra función que puede capturar valores del contexto que la rodea.
 
 - Inferir un parámetro y devolver un valor de retorno en un contexto
 - Hacer un retorno implicito de una expresión simple
 - Nomenclatura simplificada (shorthand)
 - Sintaxis de closure para funciones específicas
 */

let people = ["Juan Gabriel","Margarita","Juan José","Carmen","Ricardo"]

func sortBackward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedPeople = people.sorted(by: sortBackward)
print(reversedPeople)

/* Sintaxis de Closures
 { (parametros) -> valor de retorno in
    // codigo de closure
 }
 */

reversedPeople = people.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
reversedPeople = people.sorted(by: { s1,s2 in return s1 > s2})
reversedPeople = people.sorted(by: { s1,s2 in s1 > s2})
reversedPeople = people.sorted(by: { $0 > $1 })
reversedPeople = people.sorted(by: >)


// Trailing closure

func functionThatTakesAClosure(closure : () -> Void) {
    
}

functionThatTakesAClosure {
    // Esto es el cuerpo de closure
}

functionThatTakesAClosure() {
    // Trailing closure con el cuerpo a ejecutar
}

people.sorted() { $0 > $1 }
people.sorted { $0 > $1 }

let digitNames = [0: "Cero", 1: "Uno", 2 : "Dos"]

let numbers = [12,20]

let stringNumbers = numbers.map { (number) -> String in
    var number = number
    
    var output = ""
    
    repeat {
        output = digitNames[number%10]! + output
        number /= 10
    } while number > 0
    return output
}

print(stringNumbers)


func makeIncrement (forIncrement amout: Int) -> () -> Int {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amout
        return runningTotal
    }
    
    return incrementer
}

let incrementByFive = makeIncrement(forIncrement: 5)

incrementByFive()
//

var completionHandlers : [() -> Void] = []

func someFunctionWithEscapingHandler(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

var customers = ["Cristina","Carlos","Ruben","Marcos"]

customers.count

let customerProvider = { customers.remove(at: 0) }
 
print(customers.count)

print("Se removio \(customerProvider())")
print("Se removio \(customerProvider())")
print(customers.count)

UserDefaults.standard.set("true", forKey: "Key") //Bool
var sdas = UserDefaults.standard.bool(forKey: "Key")
print(sdas)
