//
//  EditProductView.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    var product: Product
    
    @State private var showAlert = false
    @State private var editProductViewModel = EditProductViewModel()
    
    var body: some View {
        Form {
            Section() {
                TextField("Enter the name", text: self.$editProductViewModel.name)
                TextField("Enter the description", text: self.$editProductViewModel.description)
                TextField("Enter the code", text: self.$editProductViewModel.code)
                PriceField(value: $editProductViewModel.price)
            }
            .navigationBarTitle("Edit product", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: updateProduct) {
                Text("Save").foregroundColor(.blue)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("The product couldn't be updated"),
                      dismissButton: .default(Text("Dismiss")))
            }
        }
    }
    
    init(product: Product) {
        self.product = product
        self.editProductViewModel.setProduct(product: product)
    }
    
    private func updateProduct() {
        showAlert = false
        
        if editProductViewModel.updateProduct() {
            self.presentationMode.wrappedValue.dismiss()
        } else {
            showAlert = true
        }
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(product: Product(userId: "1", name: "Product1", description: "desc", code: "cod", price: 0.0))
    }
}
