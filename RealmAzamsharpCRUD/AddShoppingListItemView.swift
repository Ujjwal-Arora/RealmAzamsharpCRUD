//
//  AddShoppingListItemView.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 05/01/25.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemView: View {
    @ObservedRealmObject var shoppingList : ShoppingListModel
    
    var itemToEdit : ShoppingItemModel?
    
    @Environment(\.dismiss) private var dismiss
    
    let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    let data = ["Produce","Fruit","Meat","Condiments","Beverages","Snacks","Dairy"]
    @State private var selectedCategoy: String = ""
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    
    init(shoppingList: ShoppingListModel, itemToEdit: ShoppingItemModel? = nil) {
        self.shoppingList = shoppingList
        self.itemToEdit = itemToEdit
        
        if let itemToEdit {
            _title = State(initialValue: itemToEdit.title)
            _quantity = State(initialValue: String(itemToEdit.quantity))
            _selectedCategoy = State(initialValue: itemToEdit.category)
        }
    }
    var isEditing : Bool{
        itemToEdit == nil ? false : true
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                LazyVGrid(columns: columns) {
                    ForEach(data,id: \.self) { item in
                        Text(item)
                            .padding()
                            .frame(width: 125)
                            .background(selectedCategoy == item ? .orange : .green )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.white)
                            .onTapGesture {
                                selectedCategoy = item
                            }
                    }
                }
                Spacer()
                    .frame(height: 60)
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    if let itemToEdit{
                        update()
                    }else{
                        save()
                    }
                    
                    
                    dismiss()
                    
                } label: {
                    Text(isEditing ? "Update" : "Save")
                        .frame(maxWidth: .infinity,maxHeight: 40)
                }
                .buttonStyle(.bordered)
                .padding(.top)
                Spacer()

            }
            .padding()
            .navigationTitle(isEditing ? "Update Item" : "Add Item")
        }
    }
    //save the item
    private func save(){
        let shoppingItem = ShoppingItemModel()
        shoppingItem.title = title
        shoppingItem.quantity = Int(quantity) ?? 1
        shoppingItem.category = selectedCategoy
        $shoppingList.items.append(shoppingItem)
    }
    //update the item
    private func update(){
        if let itemToEdit{
            do{
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: ShoppingItemModel.self, forPrimaryKey: itemToEdit.id) else { return }
                
                try realm.write {
                    objectToUpdate.title = title
                    objectToUpdate.quantity = Int(quantity) ?? 1
                    objectToUpdate.category = selectedCategoy
                    
                }
            }catch{
                print(error)
            }
        }
    }
}

#Preview {
    AddShoppingListItemView(shoppingList: ShoppingListModel())
}
