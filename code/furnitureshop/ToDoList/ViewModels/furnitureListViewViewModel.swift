//
//  ToDoListView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//
import FirebaseFirestore
import Foundation


class furnitureListViewViewModel : ObservableObject{
    
    @Published var showingNewItemView = false
    private let userId : String
    init(userId:String){
        self.userId = userId
    }
    
    func delete(id:String){
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
