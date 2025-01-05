//
//  RealmAzamsharpCRUDApp.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 04/01/25.
//

import SwiftUI

@main
struct RealmAzamsharpCRUDApp: App {
    
    let migrator = Migrator()
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstantBasedLayoutLogUnsatisfied")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
