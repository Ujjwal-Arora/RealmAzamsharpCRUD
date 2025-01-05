//
//  ShoppingListItemsView.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 05/01/25.
//

import SwiftUI
import RealmSwift

struct ShoppingListItemsView: View {
    @ObservedRealmObject var shoppingList : ShoppingListModel
    @State private var selectedItemsIds = [ObjectId]()
    @State private var selectedCategory = "All"
    @State private var isPresented : Bool = false
    
    var items : [ShoppingItemModel]{
        if selectedCategory == "All" {
            return Array(shoppingList.items)
        }else{
            return shoppingList.items.sorted(byKeyPath: "title").filter({$0.category == selectedCategory})
        }
    }
    var body: some View {
        VStack{
            CategoryFilterView(selectedCategory: $selectedCategory)
            if items.isEmpty {
                Text("No items found")
            }
            List{
                ForEach(items){ item in
                    
                    NavigationLink {
                        AddShoppingListItemView(shoppingList: shoppingList,itemToEdit : item)
                    } label: {
                        ShoppingItemCell(item: item, selected: selectedItemsIds.contains(item.id)) { selected in
                            if selected {
                                selectedItemsIds.append(item.id)
                                if let indexToDelete = shoppingList.items.firstIndex(where: {$0.id == item.id}){
                                    $shoppingList.items.remove(at: indexToDelete)
                                }
                            }
                        }
                    }

                }
                .onDelete(perform: $shoppingList.items.remove)
            }
        }
        .navigationTitle(shoppingList.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddShoppingListItemView(shoppingList : shoppingList)
        }
    }
}

#Preview {
    NavigationStack {
        ShoppingListItemsView(shoppingList: ShoppingListModel())
    }
}
