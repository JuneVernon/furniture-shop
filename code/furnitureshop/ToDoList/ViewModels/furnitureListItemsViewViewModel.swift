//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//


import FirebaseAuth
import FirebaseFirestore
import Foundation

class furnitureListItemsViewViewModel : ObservableObject{
    
    init(){}
    
    func toggleIsDone(item : Furniture){
        var itemCopy =  item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else{
        return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
}
