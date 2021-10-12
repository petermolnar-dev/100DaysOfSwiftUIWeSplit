//
//  ContentView.swift
//  WeSplit
//
//  Created by Peter Molnar on 11/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipSelection: Double {
        Double(tipPercentages[tipPercentage])
    }
    
    var orderAmount: Double {
        Double(checkAmount) ?? 0
    }
    var tipValue: Double {
        orderAmount / 100 * tipSelection
    }
    
    var grandTotal: Double {
        orderAmount + tipValue
    }
    
    var peopleCount: Double {
        Double(numberOfPeople) ?? 0
    }
    var totalPerPersons: Double {
        var amountPerPerson: Double = 0
        if peopleCount > 0 {
            amountPerPerson = grandTotal / peopleCount
        }
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPersons, specifier: "%.2f")")
                }
                Section(header: Text("Breakdown")) {
                    Text("Original Amount: $\(orderAmount, specifier: "%.2f")")
                    Text("Tip value: $\(tipValue, specifier: "%.2f")")
                    Text("Grand total: $\(grandTotal, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
