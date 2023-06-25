//
//  RegisterView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        VStack{
            HeaderView(title: "Register", subTitle: " New Furnitures", angle: -15, background: .orange)
            
           
            
        }
        Form{
            TextField("Full Name",text :$viewModel.name)
                .textFieldStyle(DefaultTextFieldStyle())
            TextField("Email Adress",text :$viewModel.email)
                .textFieldStyle(DefaultTextFieldStyle())
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)
            SecureField("password",text :$viewModel.password)
                .textFieldStyle(DefaultTextFieldStyle())
            TDButton(title: "create a account", background: .green){
                //creat function
                viewModel.register()
            }
            .padding()
            
        }
        .offset(y:-50)
        Spacer()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
