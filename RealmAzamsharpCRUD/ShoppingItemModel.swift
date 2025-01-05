//
//  ShoppingItem.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 04/01/25.
//

import Foundation
import RealmSwift

class ShoppingItemModel : Object,Identifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title : String
    @Persisted var quantity : Int
    @Persisted var category : String    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
