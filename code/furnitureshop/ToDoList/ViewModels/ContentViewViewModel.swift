//
//  ContentView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import Foundation
import FirebaseAuth

class ContentViewViewModel: ObservableObject{
    
    @Published var currentUsedId:String = ""
    
    private var handler : AuthStateDidChangeListenerHandle?
    
    init(){
        
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUsedId = user?.uid ?? ""

            }
        }
    }
    
    public var isSignedIn: Bool{
        
        return Auth.auth().currentUser != nil
        
    }
}
