//
//  ContentView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewmodel = ContentViewViewModel()
    


    var body: some View {
 
        if viewmodel.isSignedIn, !viewmodel.currentUsedId.isEmpty{
            accountView
        }else{
            LoginView()
        }
        
    }
    @ViewBuilder
    var accountView: some View{
        TabView{
            furnitureListView(userId: viewmodel.currentUsedId )
                .tabItem{
                    Label("Home" , systemImage: "house")
                }
            usersFurnituresListView(userId: viewmodel.currentUsedId )
                .tabItem{
                    Label("user" , systemImage: "table")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person.fill")
                }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

