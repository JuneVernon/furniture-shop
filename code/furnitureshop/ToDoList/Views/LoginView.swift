//
//  LoginView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import SwiftUI

struct LoginView: View {
  @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationView{
            
        
            VStack{
                HeaderView(title: "Athula Furniture",
                           subTitle: "best furnitures from online",
                           angle: 15,
                           background: Color.yellow)
                           
                         
                
                
                
                Form{
                    if !viewModel.errorMassage.isEmpty{
             Text(viewModel.errorMassage)
                 .foregroundColor(Color.red)
         }
                    TextField("email adress" , text :$viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("password " , text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    TDButton(title: "login", background: .blue){
                        viewModel.login()
                    }
                    .padding()
                    
                }
                .offset(y: -50)
                VStack{
                    Text("New To Here rounf here")
                    NavigationLink("Create Account",destination: RegisterView())
                    
                }
                .padding(.bottom,50)
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
