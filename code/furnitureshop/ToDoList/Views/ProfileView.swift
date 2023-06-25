//
//  ProfileView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                if let user = viewModel.user{
                    
                    profile(user:user)
                }else{
                    Text("loading profile....")
                }
            }
            .navigationTitle("profile")
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
    @ViewBuilder
    func profile(user: User)->some View{
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio( contentMode: .fit)
            .foregroundColor(Color.blue)
            .frame(width: 125,height: 125)
            .padding()
        VStack(alignment: .leading){
            HStack{
                Text("name :")
                    .bold()
                Text(user.name)
            }
            .padding()
            HStack{
                Text("email :")
                    .bold()
                Text(user.email)
            }
            .padding()
            HStack{
                Text("member since :")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
        }
        .padding()
        //sign out
        Button("log out"){
            viewModel.logOut()
        }.tint(.red)
            .padding()
        Spacer()
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
