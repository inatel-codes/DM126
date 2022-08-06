//
//  ContentView.swift
//  SwiftUI_Firebase
//
//  Created by Alexander Augusto Silva Fernandes on 06/08/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    @ObservedObject private var productListViewModel = ProductListViewModel()
    
    @State private var showModal = false
    @State private var showAlert = false
    
    var body: some View {
        if authenticationViewModel.isLogged {
            NavigationView {
                List {
                    ForEach(self.productListViewModel.products, id: \.id) { product in
                        NavigationLink(destination: EditProductView(product: product.product)) {
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
                .navigationBarItems(leading: Button(action: signOut) {
                    Image(uiImage: Auth.auth().currentUser!.photoURL != nil ? UIImage(data: try! Data(contentsOf: Auth.auth().currentUser!.photoURL!))! : UIImage(systemName: "person.circle")!)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .frame(width: 40, height: 40)
                }, trailing: Button(action: showNewProductView) {
                    Image(systemName: "plus")
                        .foregroundColor(Color.blue)
                })
            }
            .sheet(isPresented: $showModal) {
                AddNewProductView(isPresented: self.$showModal)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("The product could not be deleted"), dismissButton: .default(Text("Dismiss")))
            }
            .onAppear() {
                productListViewModel.fetchProducts()
            }
        } else {
            LoginView()
        }
    }
    
    private func signOut() {
        productListViewModel.clearProducts()
        authenticationViewModel.signOut()
    }
    
    private func showNewProductView() {
        self.showModal = true
    }
    
    private func deleteProduct(indexSet: IndexSet) {
        let productToBeDeleted = self.productListViewModel.products[indexSet.first!]
        
        productListViewModel.deleteProduct(product: productToBeDeleted.product) { result in
            showAlert = !result
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (3rd generation)")
            .previewInterfaceOrientation(.portrait)
    }
}
