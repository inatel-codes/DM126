//
//  ProductListView.swift
//  SwiftUI_REST_Client
//
//  Created by Alexander Augusto Silva Fernandes on 23/07/22.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject private var productListViewModel = ProductListViewModel()
    @State private var showModal = false
    @State private var showAlert = false
    
    private func reloadProducts() {
        productListViewModel.fetchProducts()
    }
    
    private func showNewProductView() {
        self.showModal = true
    }
    
    private func newProductCompletion(product: Product) {
        self.productListViewModel.products.append(ProductModel(product: product))
    }
    
    private func updateProduct(product: Product) {
        if let productToBeUpdatedIndex = self.productListViewModel.products.firstIndex(where: { $0.id == product.id }) {
            self.productListViewModel.products[productToBeUpdatedIndex] = ProductModel(product: product)
        }
    }
    
    private func deleteProduct(indexSet: IndexSet) {
        showAlert = false
        let productToBeDeleted = self.productListViewModel.products[indexSet.first!]
        
        productListViewModel.deleteProduct(product: productToBeDeleted) { product in
            if let _ = product {
                self.productListViewModel.products.remove(at: indexSet.first!)
            } else {
                showAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.productListViewModel.products, id: \.id) { product in
                    NavigationLink(destination: EditProductView(product: product.product) { product in
                        updateProduct(product: product)
                    }) {
                        HStack {
                            Text(product.name)
                            Spacer()
                            Text(product.code)
                            Spacer()
                            Text(String(format: "$ %.2f", product.price))
                        }
                    }
                }
                .onDelete(perform: self.deleteProduct)
            }
            .navigationBarTitle("Products", displayMode: .inline)
            .navigationBarItems(leading: Button(action: reloadProducts) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color.blue)
            }, trailing: Button(action: showNewProductView) {
                Image(systemName: "plus")
                    .foregroundColor(Color.blue)
            })
            .sheet(isPresented: $showModal) {
                AddNewProductView(isPresented: self.$showModal, completion: newProductCompletion)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("The product could not be deleted"), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

