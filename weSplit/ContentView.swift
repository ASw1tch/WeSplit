//
//  ContentView.swift
//  weSplit
//
//  Created by Anatoliy Petrov on 27.11.22..
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPersentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelected = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelected
        let grandAmount = Double(checkAmount + tipAmount)
        let finalResult = grandAmount / peopleCount
        
        return finalResult
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField ("Enter Amount", value: $checkAmount, format:
                                    .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<15) {
                            Text("\($0) people")
                        }
                        
                    }
                    
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPersentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                        
                    
                    
                    
                } header: {
                    Text ("How much tip do you want to leave")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        
                } header: {
                    
                    Text("Total per person")
                        .bold()
                    
                        
                }.foregroundColor(tipPercentage == 0 ? .red : .black )
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
