//
//  MainVM.swift
//  Realmico
//
//  Created by Mugurel Moscaliuc on 17/02/2022.
//

import Foundation
import RealmSwift


final class MainVM: ObservableObject {
    
    
    @Published var currentList: ItemList?
    @Published var lists = [ItemList]()
    
    
    init() {
        fetchLists()
    }
    
    
    
    func add(list: ItemList, item: Item?, completion: @escaping() -> ()) {
        ListService.add(list: list, item: item) {
            completion()
        }
    }
    
    
    func fetchLists() {
        Task {
            lists = try await ListService.fetchLists()
            if currentList == nil {
                currentList = lists.first
            }
        }
    }
    
    
    func delete(list: ItemList, completion: @escaping () -> ()) {
        ListService.delete(list: list) {
            completion()
        }
    }
    
    
    func delete(index: IndexSet, list: ItemList, completion: @escaping () -> ()) {
        ListService.delete(index: index, list: list) {
            completion()
        }
    }
    
}
