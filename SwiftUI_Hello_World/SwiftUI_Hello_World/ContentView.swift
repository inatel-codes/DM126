//
//  ContentView.swift
//  SwiftUI_Hello_World
//
//  Created by Alexander Augusto Silva Fernandes on 16/07/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var product = Product(name: "", description: "", code: "", price: 0.0)
    @State private var isCodeValid = true
    @State private var isPriceValid = true
    @State private var isProductSaved = false
    
    private func saveProduct() {
        isProductSaved = isProductValid()
    }
    
    private func isProductValid() -> Bool {
        isCodeValid = product.code.count >= 5
        isPriceValid = product.price >= 0
        
        return isCodeValid && isPriceValid
    }
    
    var body: some View {
        Form {
            ProductCreationView(product: $product, isCodeValid: isCodeValid, isPriceValid: isPriceValid)
            
            Section {
                Button(action: saveProduct) {
                    Text("Save")
                }
            }
            
            if (self.isProductSaved) {
                ProductSavedView(product: self.product)
            }
        }
    }
}

struct ProductCreationView: View {
    @Binding var product: Product
    var isCodeValid: Bool
    var isPriceValid: Bool
    
    var body: some View {
        Section(header: Text("Product")) {
            VStack(alignment: .leading) {
                Text("Name:")
                TextField("Enter the name", text: $product.name)
            }
            
            VStack(alignment: .leading) {
                Text("Description:")
                TextField("Enter the description", text: $product.description)
            }
            
            VStack(alignment: .leading) {
                Text("Code:")
                HStack {
                    TextField("Enter the code", text: $product.code)
                    if (!self.isCodeValid) {
                        Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color.red)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text("Price:")
                PriceField(value: $product.price, isValid: isPriceValid)
            }
        }
    }
}

struct ProductSavedView: View {
    var product: Product
    
    var body: some View {
        Section(header: Text("Product Saved")) {
            Text("Name: \(product.name)")
            Text("Description: \(product.description)")
            Text("Code: \(product.code)")
            Text("Price: \(product.price, specifier: "%.02f")")
        }
    }
}

struct PriceField: View {
    @State private var enteredValue: String = ""
    @Binding var value: Double
    var isValid: Bool
    
    var body: some View {
        HStack {
            TextField("", text: $enteredValue)
            .onReceive(Just(enteredValue)) { typedValue in
                if let newValue = Double(typedValue) {
                    self.value = newValue
                }
            }
            .onAppear(perform: {
                self.enteredValue = String(format: "%.02f", self.value)
            })
            .keyboardType(.decimalPad)
            
            if (self.isValid == false) {
                Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
