//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import Foundation


struct Furniture : Codable,Identifiable{
    
    let id:String
    let title:String
    let description: String
        let price: Double
    let dueDate:TimeInterval
    let createdDate: TimeInterval
    var isDone:Bool
    var imageURL: String?
    var location: String?


    
    mutating func setDone(_ state:Bool){
        isDone = state
    }
}
