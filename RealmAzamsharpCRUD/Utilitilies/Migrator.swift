//
//  Migrator.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 05/01/25.
//

import Foundation
import RealmSwift

class Migrator{
    init(){
        updateSchema()
    }
    
    func updateSchema(){
        let config = Realm.Configuration(schemaVersion : 2){ migration , oldSchemaVersion in
            if oldSchemaVersion < 1{
                // add new fields
                migration.enumerateObjects(ofType: ShoppingListModel.className()) { _, newObject in
                    newObject!["items"] = List<ShoppingItemModel>()
                }
            }
            if oldSchemaVersion < 2 {
                migration.enumerateObjects(ofType: ShoppingItemModel.className()) { _, newObject in
                    newObject!["category"] = ""
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()

    }
}
