//
//  ToDoListView.swift
//  iOSToDo
//
//  Created by Thassio Costa on 31/10/22.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.title, ascending: true)],
        animation: .default)
    private var toDos: FetchedResults<ToDo>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(toDos) { toDo in
                    NavigationLink(destination: Text(toDo.title!).font(.largeTitle).padding()) {
                        Text(toDo.title!)
                            .lineLimit(1)
                    }
                }.onDelete(perform: deleteToDos)
            }
            .navigationTitle("iOS ToDo")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: AddToDoView()) {
                        Label("Add Item", systemImage: "plus.circle.fill")
                    }
                }
            }
        }
        
    }
    
    private func deleteToDos(offsets: IndexSet) {
        withAnimation {
            offsets.map { toDos[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
