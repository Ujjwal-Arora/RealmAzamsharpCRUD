//
//  ContentView.swift
//  RealmAzamsharp
//
//  Created by Ujjwal Arora on 03/01/25.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedResults(ShoppingListModel.self) var shoppingLists
    
    @State private var isPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                if shoppingLists.isEmpty{
                    Text("No shopping lists!")
                }
                
                List{
                    ForEach(shoppingLists,id: \.id) { shoppingList in
                        NavigationLink {
                            ShoppingListItemsView(shoppingList: shoppingList)
                        } label: {
                            VStack{
                                Text(shoppingList.title)
                                Text(shoppingList.address)
                                    .opacity(0.3)
                            }
                        }

                        
                    }
                    .onDelete(perform: $shoppingLists.remove)
                }
            }
            .navigationTitle("Realm Grocery App")
            .sheet(isPresented: $isPresented, content: {
                AddShoppingListView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
