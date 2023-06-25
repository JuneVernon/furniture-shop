//
//  LoginView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel : ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMassage = ""
    
    init(){
        
    }
    
    func login(){
        guard validate() else{
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    
    private func validate()-> Bool{
        
        errorMassage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            
            errorMassage = "please fill"
            return false
        }
        
        
        guard email.contains("@") && email.contains(".") else{
            errorMassage = " plaese enter valid email"
            return false
            
        }
        
        return true
}
}
