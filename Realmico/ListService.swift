//
//  ListService.swift
//  Realmico
//
//  Created by Mugurel Moscaliuc on 17/02/2022.
//

import Foundation
import RealmSwift

enum ListService {
    
    
    static func add(list: ItemList, item: Item?, completion: @escaping () -> ()) {
        let realm = try! Realm()
        if let specificList = realm.object(ofType: ItemList.self, forPrimaryKey: list._id) {
            if let item = item {
                try! realm.write {
                    specificList.items.append(item)
                    realm.add(specificList, update: .modified)
                    completion()
                }
            }
            try! realm.write {
                realm.add(specificList, update: .modified)
                completion()
            }
        } else {
            try! realm.write {
                realm.add(list)
                completion()
            }
        }
        
    }
    
    
    static func delete(list: ItemList, completion: @escaping () -> ()) {
        let realm = try! Realm()
        if let specificList = realm.object(ofType: ItemList.self, forPrimaryKey: list._id) {
            try! realm.write {
                realm.delete(specificList)
            }
        }
    }
    
    
    static func delete(index: IndexSet, list: ItemList, completion: @escaping () -> ()) {
        let realm = try! Realm()
        if let specificList = realm.object(ofType: ItemList.self, forPrimaryKey: list._id) {
            try! realm.write {
                specificList.items.remove(at: index.first!)
                realm.add(specificList, update: .modified)
                completion()
            }
        }
    }
    
    
    static func fetchLists() async throws -> [ItemList] {
        let realm = try! await Realm()
        let result = realm.objects(ItemList.self)
        return result.shuffled()
    }
    
    
}
