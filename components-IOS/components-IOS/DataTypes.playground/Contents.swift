import UIKit

enum TypeDebitCategory {
    case health
    case food
    case entertaiment
}

enum TypeGainCategory {
    case payment
}

class Transaction {
    
    var name: String
    var value: Float
    
    init(name: String, value: Float) {
        self.name = name
        self.value = value
    }
    
}

class Debit: Transaction {
    var typeCategorie: TypeDebitCategory
    init(name: String, value: Float, typeCategorie: TypeDebitCategory) {
        self.typeCategorie = typeCategorie
        super.init(name: name, value: value)
    }
}

class Gain: Transaction {
    var typeCategorie: TypeGainCategory
    init(name: String, value: Float, typeCategorie: TypeGainCategory) {
        self.typeCategorie = typeCategorie
        super.init(name: name, value: value)
    }
}

class Account {
    var amount: Float = 0 {
        // se ejecuto antes de cambiar el valor
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        // se ejecuta cuando la variable se ha modificado
        didSet {
            print("Tenemos nuevo valor", amount)
        }
    }
    var name: String
    var transactions: [Transaction] = []
    
    init(amount: Float, name: String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    func addTransaction(transaction: Transaction) -> Bool{
        
        if transaction is Debit {
            if (amount - transaction.value) < 0 {
                return false
            }
            amount -= transaction.value
        }
        
        if transaction is Gain {
            amount += transaction.value
        }
        transactions.append(transaction)
        return true
    }
    
    @discardableResult
    func debits() -> [Transaction] {
        return transactions.filter({$0 is Debit})
    }
    
    @discardableResult
    func gains() -> [Transaction] {
        return transactions.filter({$0 is Gain})
    }
    
    func transactionsDebitFor(categorie: TypeDebitCategory) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Debit else { return false }
            return transaction.typeCategorie == categorie
        })
    }
    
    func transactionsGainFor(categorie: TypeGainCategory) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Gain else { return false }
            return transaction.typeCategorie == categorie
        })
    }
    
}

struct Person {
    var name: String
    var lastName: String
    var account: Account?
    
    var fullName: String {
        get {
            return "\(name) \(lastName)"
        }
    }
    
    init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }

}
    
    

var accountGeneral = Account(amount: 100000, name: "Bank")
var person = Person(name: "yesid", lastName: "marin")

person.account = accountGeneral

var transactionDisccount: [Transaction] = []

transactionDisccount.append(Debit(name: "Cookies", value: 1_500, typeCategorie: .food))
transactionDisccount.append(Debit(name: "Game Play", value: 70_000, typeCategorie: .entertaiment))
transactionDisccount.append(Debit(name: "Breakfast", value: 20_000, typeCategorie: .food))
transactionDisccount.append(Gain(name: "Payment", value: 200_000, typeCategorie: .payment))
transactionDisccount.forEach({
    print(accountGeneral.addTransaction(transaction: $0))
})

guard let account = person.account else { fatalError() }

print(account.transactions.count)
print(account.transactions[0])
print(account.transactions[1])
print(account.transactions[3])
print("Debits", "\(accountGeneral.debits()[2].name)")
print("Gains", "\(accountGeneral.gains()[0].name)")
print("Food Transaction: \(accountGeneral.transactionsDebitFor(categorie: .entertaiment)[0].name), count: \(accountGeneral.transactionsDebitFor(categorie: .entertaiment).count)")
let asd = account.transactionsDebitFor(categorie: .entertaiment)
accountGeneral.transactionsDebitFor(categorie: .entertaiment).forEach({print($0.name , $0.value)})

var accounts: Float = 1_000_000
let name = "yesid"
let lastname = "marin"
let fullname = "\(name) \(lastname)".capitalized
var isAccountActive = !fullname.isEmpty

accounts += isAccountActive ? 1_000 : 0

print("My name is \(fullname), I have in my account \(account)")

var transactions: [Float] = [20, 50, 1000]
print(transactions)

transactions.count
transactions.isEmpty
transactions.first

transactions.append(12)
print(transactions)


var dailyTransactionMatriz: [[Float]] = [
    [20, 50, 100],
    [],
    [30, 40, 300]
]

dailyTransactionMatriz.first
dailyTransactionMatriz[1]
dailyTransactionMatriz[2][1]

var transactionDictionary: [String : [Float]] = [
    "Lunes": [20, 50, 100],
    "Martes": [],
    "Miercoles": [30, 40, 3000]
]
print(transactionDictionary.keys)
print(transactionDictionary.values)
transactionDictionary.first
accounts -= 400

if accounts > 1_000_000{
    print("Has more of one millon")
} else if accounts > 0  {
    print("Has money")
} else {
    print("Not has nothing")
}

var total: Float = 0

for transaction in transactions {
    total += transaction
}

print(total)

accounts -= total

var total2: Float = 0
for key in transactionDictionary.keys {
    guard let key = transactionDictionary[key]  else { fatalError("Not found day") }
    key.filter({ $0 > 100 })
        .forEach({ total2 += $0 })
}

print(total2)


// Tuplas, reducir for
func accountTotal(forTransactions transactions: [String : [Float]]) -> (total: Float,numTrans: Int){
    var total: Float = 0
    //total += transactions.reduce(0.0, { $0 + $1.value.reduce(0.0, +)})
    for key in transactions.keys {
        guard let value = transactions[key] else { fatalError() }
        total += value.reduce(0.0, +)
    }
    return (total, transactions.count)
}
let accountTotalResult = accountTotal(forTransactions: transactionDictionary)
print(accountTotalResult.total)
print(accountTotalResult.numTrans)


// @discardableResult
@discardableResult
func addTransaction (transactionValue value: Float) -> (isSuccess: Bool, transactionTotal: Float) {
    if (accounts - value) < 0 {
        let transactionTotal = transactions.reduce(0.0, +)
        return (false, transactionTotal)
    }
    transactions.append(value)
    let transactionTotal = transactions.reduce(0.0, +)
    return (true, transactionTotal)
}

let dou = Double(1200000)
let val = Double(781242)
print(dou/val)

let formatters = DateFormatter()
let year = 2004
formatters.dateFormat = "dd/MM/yyyy"
let lear = formatters.date(from: "29/02/\(year)") != nil

let ano = 1998
if ((ano%4 == 0) && ((ano%100 != 0) || (ano%400 == 0))){
    print(true)
}

var vals = [10,2]
vals.sort { (s1,s2) -> Bool in
    s1 > s2
    
}

typealias thin = [String: Any]
var sfii : thin

print(type(of: sfii))

"t".forEach { (char) in
    print(char)
}
func *(lhs: Double, rhs: Int) -> Double {
    return Double(rhs) * lhs
}

let otra:Double = 65.5-0.5*Int(2.30)
let sdsds = [55.0, otra]
print(sdsds.max())
// Obtener ultimo día del mes
guard var startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date()))) else { fatalError() }
guard let sdfd = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else { fatalError()}

print(sdfd)
// Sacar edad
let formatter = DateFormatter()
let birth = "02/06/2033"
let dateNow = Date()
formatter.dateFormat = "dd/MM/yyyy"
guard let birthdate = formatter.date(from: birth) else { fatalError() }
print(birthdate)
let ageComponents = Double(Calendar.current.dateComponents([.day], from: birthdate, to: sdfd).day!)
let age = ageComponents / 365.25
let asds = round(age)
print(age)

guard let sdfds = Calendar.current.date(byAdding: DateComponents(year: 62), to: birthdate) else { fatalError()}

guard let adslsos = Calendar.current.date(byAdding: DateComponents(day: 6128), to: birthdate) else { fatalError()}

print(adslsos)

let calendar = Calendar.current
let date = Date(timeIntervalSince1970:  birthdate.timeIntervalSince1970)
let startOfNow = calendar.startOfDay(for: Date())
let startOfTimeStamp = calendar.startOfDay(for: date)
let components = calendar.dateComponents([.day], from:startOfTimeStamp , to:  startOfNow)
let day = components.day!
if abs(day) < 2 {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.doesRelativeDateFormatting = true
} else if day > 1 {
    print("In \(day) days")
} else {
    print("\(-day/365) days ago")
}

guard let myDOB = Calendar.current.date(from: DateComponents(year: 1998, month: 03, day: 20)) else { fatalError() }
let myAge:Float = Float(Calendar.current.dateComponents([.day], from: myDOB, to: Date()).day!)
let dates = Date()
let years = myAge / 365.25
let asge = "\(years)"
guard let ageFloat = Float(asge) else { fatalError() }
print("Age : \(ageFloat)")


let number = "9000"
let sdfsd = NSNumber(value: Int(number) ?? 0)
let fornarte = NumberFormatter()
fornarte.groupingSeparator = "."
fornarte.numberStyle = .decimal
let formattedNumber = fornarte.string(from: sdfsd)


