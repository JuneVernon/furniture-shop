//
//  User.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//

import Foundation


struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined:  TimeInterval
}
