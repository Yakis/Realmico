//
//  List.swift
//  Realmico
//
//  Created by Mugurel Moscaliuc on 17/02/2022.
//

import Foundation
import RealmSwift

class ItemList: Object, Identifiable {
    
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var name: String = ""
    // A list can have many items
    @Persisted var items: List<Item>
}


class Item: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var amount: Double = 0
    @Persisted var type: String?
    // No backlink to list -- one-directional relationship
}
