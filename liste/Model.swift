
//  Model.swift
//  test
//
//  Created by Daniel Riewe on 13.09.16.
//  Copyright © 2016 ddd. All rights reserved.
//

import Foundation



//: Playground - noun: a place where people can play

import UIKit


protocol Bestellbar {
    var name: String { get }
    var preiss: Double { get }
}

protocol Berechenbar {
    var bestellungen: [Bestellung] { get set }
    func summeBestellungen() -> Double
    func trinkGeld(prozent: Int) -> Double
}

extension Berechenbar {
    func summeBestellungen() -> Double {
        let summe = bestellungen.reduce(0.0) { (summ, bestellung) -> Double in
            summ + bestellung.artikel.preiss
        }
        return summe
    }
    
    func trinkGeld(prozent: Int) -> Double {
        let summe = summeBestellungen()
        let trinkGeld = (summe / 100) * Double(prozent)
        let betrag = summe + trinkGeld
        return betrag
    }
}

class Gast {
    let name: String
    var bestellungen: [Bestellung]
    var rechnung: Rechnung {
        let rechnung = Rechnung(bestellungen: bestellungen)
        return rechnung
    }
    
    init(name: String) {
        self.name = name
        self.bestellungen = []
    }
    
    func bestellen(name: String, preiss: Double) {
        let essen = Essen(name: name, preiss: preiss)
        let bestellung = Bestellung(gast: self, artikel: essen)
        bestellungen.append(bestellung)
    }
}

struct Bestellung {
    let gast: Gast
    let artikel: Bestellbar
}

struct Essen: Bestellbar {
    let name: String
    let preiss: Double
}

struct Trinken: Bestellbar {
    let name: String
    let preiss: Double
}

class Tisch {
    var gäste: [Gast]
    var rechnung: Rechnung {
        let bestellungen: [Bestellung] = gäste.flatMap { gast in
            gast.bestellungen
        }
        let rechnung = Rechnung(bestellungen: bestellungen)
        return rechnung
    }
    
    init() {
        self.gäste = []
    }
    
    func addGast(name: String) {
        let gast = Gast(name: name)
        self.gäste.append(gast)
    }
    
    func addGast(gast: Gast) {
        self.gäste.append(gast)
    }
}

struct Rechnung: Berechenbar {
    var bestellungen: [Bestellung] = []
    
    func billPrint() -> String {
        var billTable = ""
        let summe = "Summe: \(getCurrencyString(number: self.summeBestellungen()))"
        let trinkgeld = "+ 10 % Trinkgeld: \(getCurrencyString(number: self.trinkGeld(prozent: 10)))"
        let columnHeadings = [("Nummer", false), ("Gast", false), ("Artikel", false), ("Preiss", false)]
        
        var maxStringLengt: Int {
            var caracterCount = 0
            for bestellung in bestellungen {
                caracterCount = max(caracterCount, bestellung.gast.name.characters.count)
                caracterCount = max(caracterCount, bestellung.artikel.name.characters.count)
                caracterCount = max(caracterCount, getCurrencyString(number: self.summeBestellungen()).characters.count)
            }
            for (heading, _) in columnHeadings {
                caracterCount = max(caracterCount, heading.characters.count)
            }
            return caracterCount + 1
        }
        let tableLength = maxStringLengt * columnHeadings.count + columnHeadings.count - 1
        let tableBorderLine: String = "+\("".padding(toLength: tableLength, withPad: "-", startingAt: 0))+\n"
        var tableRowLine: String {
            let rowLine = String(repeating: "-", count: maxStringLengt)
            return "|\(rowLine.padding(toLength: tableLength, withPad: "|\(rowLine)", startingAt: 0))|\n"
        }
        
        func spacePadding(_ text: String, toLength: Int, reverse: Bool) -> String {
            if reverse {
                let reverseText = String(text.characters.reversed())
                let reversePadding = reverseText.padding(toLength: toLength, withPad: " ", startingAt: 0)
                return String(reversePadding.characters.reversed())
            } else {
                return text.padding(toLength: toLength, withPad: " ", startingAt: 0)
            }
        }
        
        func addTableRow(_ columnValues: [(String, Bool)]) {
            var columnLength = maxStringLengt
            if columnValues.count == 1 {
                columnLength = tableLength
            }
            billTable.append("|")
            for (value, reverse) in columnValues {
                billTable.append(spacePadding(value,toLength: columnLength, reverse: reverse))
                billTable.append("|")
            }
            billTable.append("\n")
        }
        
        billTable.append(tableBorderLine)
        addTableRow(columnHeadings)
        billTable.append(tableRowLine)
        for (index, bestellung) in bestellungen.enumerated() {
            var row: [(String, Bool)] = []
            row.append(("\(index + 1)", false))
            row.append((bestellung.gast.name, false))
            row.append((bestellung.artikel.name, false))
            row.append((getCurrencyString(number: bestellung.artikel.preiss), true))
            addTableRow(row)
        }
        billTable.append(tableRowLine)
        addTableRow([(summe, true)])
        addTableRow([(trinkgeld, true)])
        billTable.append(tableBorderLine)
        print(billTable)
        return billTable
    }
    
    func getCurrencyString(number: Double) -> String {
        if number == 0 {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "de_DE") as Locale!
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let formattedString = formatter.string(for: number)
        return formattedString!
    }
}



