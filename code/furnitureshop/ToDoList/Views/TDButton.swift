//
//  TDButton.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import SwiftUI

struct TDButton: View {
    let title : String
    let background:Color
    let Action: () -> Void
    
    var body: some View {
        Button{
            //action
            Action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        
    }
}

struct TDButton_Previews: PreviewProvider {
    static var previews: some View {
        TDButton(title: "value", background: .pink){
            //action
        }
    }
}
