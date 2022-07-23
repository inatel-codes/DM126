//
//  PriceField.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import SwiftUI
import Combine

struct PriceField: View {
    var title: String
    @Binding var value: Double
    @State private var enterdValue: String = ""
    
    var body: some View {
        TextField(title, text: $enterdValue)
            .onReceive(Just(enterdValue)) { typedValue in
                if let newValue = Double(typedValue) {
                    self.value = newValue
                }
            }
            .onAppear(perform: {self.enterdValue = self.value == 0 ? "" : String(format: "%.02f", self.value)})
            .keyboardType(.decimalPad)
    }
}

/* struct PriceField_Previews: PreviewProvider {
    static var previews: some View {
        PriceField()
    }
} */
