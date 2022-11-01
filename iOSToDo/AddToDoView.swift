//
//  AddToDoView.swift
//  iOSToDo
//
//  Created by Thassio Costa on 31/10/22.
//

import SwiftUI

struct AddToDoView: View {
    
    @State var todoTitle = ""
    @FocusState var titleFocus: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField ("Type here...", text: $todoTitle)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .focused($titleFocus)
                .submitLabel(.done)
                .onSubmit {
                    addToDo()
                }
                .padding()
                .toolbar {
                    Button(action: addToDo) {
                        Text("Add to List")
                    }
                }.onAppear {
                    titleFocus = true
                }
            
            Spacer()
        }
    }
    
    private func addToDo() {
        let newToDo = ToDo(context: viewContext)
        newToDo.title = todoTitle
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        todoTitle = ""
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddToDoView()
        }
    }
}
