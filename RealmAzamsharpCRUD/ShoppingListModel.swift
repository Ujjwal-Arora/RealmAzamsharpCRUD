//
//  ShoppingList.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 04/01/25.
//

import Foundation

import RealmSwift

class ShoppingListModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id : ObjectId
    @Persisted var title : String
    @Persisted var address : String
    
    @Persisted var items : List<ShoppingItemModel> = List<ShoppingItemModel>()
    
    override class func primaryKey() -> String? {
        "id"
    }
    
}
