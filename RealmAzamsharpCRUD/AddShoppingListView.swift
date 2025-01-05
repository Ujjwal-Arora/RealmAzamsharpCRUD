//
//  AddShoppingListView.swift
//  RealmAzamsharp
//
//  Created by Ujjwal Arora on 03/01/25.
//

import RealmSwift
import SwiftUI

struct AddShoppingListView: View {
    @State private var title = ""
    @State private var address = ""
    @Environment(\.dismiss) private var dismiss

    @ObservedResults(ShoppingListModel.self) var realmShoppingLists
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Title", text: $title)
                TextField("Address", text: $address)
                Button {
                    let shoppingList = ShoppingListModel()
                    shoppingList.title = title
                    shoppingList.address = address
                    
                    //adding the shopping list to the mongoDB database
                    $realmShoppingLists.append(shoppingList)
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)

                }.buttonStyle(.bordered)
            }
            .navigationTitle("New List")
        }
    }
}

#Preview {
    AddShoppingListView()
}
