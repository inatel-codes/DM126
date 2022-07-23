//
//  AddNewProductView.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import SwiftUI

struct AddNewProductView: View {
    @Binding var isPresented: Bool
    @State private var addNewProductViewModel = AddNewProductViewModel()
    @State private var showAlert = false
    var completion: (Product) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Enter the name", text: self.$addNewProductViewModel.name)
                    TextField("Enter the description", text: self.$addNewProductViewModel.description)
                    TextField("Enter the code", text: self.$addNewProductViewModel.code)
                    PriceField(title: "Enter the price", value: self.$addNewProductViewModel.price)
                }
            }
            .navigationBarTitle("New product", displayMode: .inline)
            .navigationBarItems(leading: Button(action: dismiss) {
                Text("Cancel").foregroundColor(.red)
            }, trailing: Button(action: saveProduct) {
                Text("Add").foregroundColor(.blue)
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("The product could not be saved"), dismissButton: .default(Text("Dismiss")))
        }
    }
    
    private func dismiss() {
        self.isPresented = false
    }
    
    private func saveProduct() {
        self.showAlert = false
        self.addNewProductViewModel.saveNewProduct { product in
            if let product = product {
                completion(product)
                self.isPresented = false
            } else {
                self.showAlert = true
            }
        }
    }
}

struct AddNewProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductView(isPresented: .constant(false)) { product in
            
        }
    }
}
