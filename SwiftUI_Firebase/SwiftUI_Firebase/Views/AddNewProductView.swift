//
//  AddNewPreductView.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import SwiftUI

struct AddNewProductView: View {
    @Binding var isPresented: Bool
    @State private var addNewProductViewModel = AddNewProductViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Enter the name", text: self.$addNewProductViewModel.name)
                    TextField("Enter the description", text: self.$addNewProductViewModel.description)
                    TextField("Enter the code", text: self.$addNewProductViewModel.code)
                    PriceField(value: self.$addNewProductViewModel.price)
                }
            }
            .navigationBarTitle("New Product", displayMode: .inline)
            .navigationBarItems(leading: Button(action: dismiss){
                Text("Cancel").foregroundColor(.red)
            }, trailing: Button(action: saveProduct) {
                Text("Add").foregroundColor(.blue)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("The product could not be saved"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
    
    private func saveProduct() {
        self.showAlert = false
        let productSaved = self.addNewProductViewModel.saveNewProduct()
        
        if productSaved {
            self.isPresented = false
        } else {
            self.showAlert = true
        }
    }
    
    private func dismiss() {
        self.isPresented = false
    }
}

struct AddNewProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductView(isPresented: .constant(false))
    }
}
