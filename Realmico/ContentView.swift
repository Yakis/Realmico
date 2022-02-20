//
//  ContentView.swift
//  Realmico
//
//  Created by Mugurel Moscaliuc on 17/02/2022.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @StateObject var mainVM = MainVM()
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(ItemList.self) var lists
    @State private var showAddListView = false
    @State private var listName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists, id: \._id) { list in
                    NavigationLink(
                        list.name,
                        destination: ListDetailsView(list: list).environmentObject(mainVM)
                    )
                }
                .onDelete {
                    let listToDelete = lists[$0.first!]
                    mainVM.delete(list: listToDelete) {
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddListView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showAddListView) {
                
            } content: {
                VStack {
                    TextField("Enter list's name", text: $listName)
                    Button {
                        let listToSave = ItemList(value: ["name": listName])
                        mainVM.add(list: listToSave, item: nil, completion: {
                            DispatchQueue.main.async {
                                showAddListView = false
                                listName = ""
                            }
                        })
                    } label: {
                        Text("Save")
                    }.buttonStyle(.borderedProminent)
                }.padding()
            }

        }
    }
}
