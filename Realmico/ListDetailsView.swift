//
//  ListDetailsView.swift
//  Realmico
//
//  Created by Mugurel Moscaliuc on 17/02/2022.
//

import SwiftUI
import RealmSwift

struct ListDetailsView: View {
    
    @EnvironmentObject var mainVM: MainVM
    @Environment(\.presentationMode) var presentationMode
    
    var list: ItemList
    @State private var showAddItemView = false
    @State private var itemName = ""
    
    var body: some View {
        VStack {
            Text(list.name)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            List {
                ForEach(list.items, id: \._id) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(String(item.amount))
                    }
                }
                .onDelete {
                    mainVM.delete(index: $0, list: list) {
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddItemView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showAddItemView) {
            
        } content: {
            VStack {
                TextField("Enter item's name", text: $itemName)
                Button {
                    let itemToSave = Item(value: ["name": itemName, "amount": Double.random(in: 0..<20)])
                    mainVM.add(list: list, item: itemToSave, completion: {
                        showAddItemView = false
                        itemName = ""
                    })
                } label: {
                    Text("Save")
                }.buttonStyle(.borderedProminent)
            }.padding()
        }
    }
}

