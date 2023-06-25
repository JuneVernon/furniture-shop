[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/sHz1bMKn)
Please go under edit and edit this file as needed for your project.  There is no seperate documentation needed.

# Project Name - athula furniture
# Student Id - it20069568
# Student Name - sharli june vernan

#### 01. Brief Description of Project - This project is an online furniture shop where users can register and login to buy and sell furniture items. Users can add their own furniture items to the system for sale, and other users can browse and purchase the available items. It provides a platform for users to engage in furniture buying and selling activities.
#### 02. Users of the System - Sellers,Customers,Administrators
#### 03. What is unique about your solution -Integrating map-based address selection and seamless furniture upload process for enhanced user experience.
#### 04. Differences of Assignment 02 compared to Assignment 01

"Assignment 02" used SwiftUI for the user interface and integrated Firebase for features such as authentication, image uploading, and map integration, while "Assignment 01" utilized UIKit and Core Data.
#### 05. Briefly document the functionality of the screens you have (Include screen shots of images)

e.g. The first screen is used to capture a photo and it will be then processed for identifying the landmarks in the photo.

![Screen 1](Resources/screen01.png)  
login(Resources/screen01.png)
register(Resources/screen2.png)
signle furniture(Resources/screen8.png)
mapadress(Resources/screen7.png)
profiledetils(Resources/screen6.png)
 furniturelist(Resources/screen4.png)
 mapadress(Resources/screen7.png)
addnewfurniture(Resources/screen3.png)
registeruser(Resources/screen2.png)
login(Resources/screen1.png)







#### 06. Give examples of best practices used when writing code
Structuring Code: The code is structured into separate files for each component, making it easier to manage and maintain.
Separation of Concerns: The code follows the MVVM (Model-View-ViewModel) pattern, separating the data model (Furniture), the view model 
Encapsulation: The use of @Published property wrappers in the view model allows for easy observation and binding of the properties, improving data encapsulation.
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

e.g The code below uses consistant naming conventions for variables, uses structures and constants where ever possible. (Elaborate a bit more on what you did)

```
  struct User {
    let firstName: String
    let lastName: String
    let age: Int
    let email: String?
    
    init(firstName: String, lastName: String, age: Int, email: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
    }
    
    func sendEmail(to recipient: String, subject: String, message: String) {
        guard let email = self.email else {
            print("Cannot send email. No email address on file.")
            return
        }
        
        // Code to send email goes here
        print("Sending email to \(recipient) from \(email) with subject: \(subject)")
        print("Message: \(message)")
    }
}
```

#### 07. UI Components used
Text
Form
TextField
DatePicker
Button
Alert
VStack
ImagePicker
MapView
e.g. The following components were used in the Landmark Identify App

#### 08. Testing carried out
func save() {
    guard canSave else {
        return
    }
    
    guard let uId = Auth.auth().currentUser?.uid else {
        return
    }
    
    let newId = UUID().uuidString
    let newItem = Furniture(
        id: newId,
        title: title,
        description: description,
        price: Double(price) ?? 0.0,
        dueDate: dueDate.timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false,
        imageURL: nil,
        location: location
    )
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let imageRef = storage.reference().child("users/\(uId)/todos/\(newId).jpg")
    
    if let imageData = image?.jpegData(compressionQuality: 0.8) {
        let uploadTask = imageRef.putData(imageData, metadata: nil) { [self] (metadata, error) in
            if let error = error {
                // Handle the upload error
                print("Image upload error:", error.localizedDescription)
                // Show an alert or perform other error handling actions
                
                return
            }
            
            guard let _ = metadata else {
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    // Handle the download URL retrieval error
                    print("Download URL retrieval error:", error.localizedDescription)
                    // Show an alert or perform other error handling actions
                    
                    return
                }
                
                guard let downloadURL = url else {
                    return
                }
                
                var newItemWithImage = newItem
                newItemWithImage.imageURL = downloadURL.absoluteString
                
                db.collection("users")
                    .document(uId)
                    .collection("todos")
                    .document(newId)
                    .setData(newItemWithImage.asDictionary())
            }
        }
        
        uploadTask.observe(.progress) { [self] snapshot in
            guard let progress = snapshot.progress else {
                return
            }
            
            self.uploadProgress = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
        }
    } else {
        // Handle the image data conversion error
        print("Image data conversion error")
        // Show an alert or perform other error handling actions
    }
}
Test the image upload process by providing valid and invalid image data. Ensure that the progress updates correctly during the upload.





#### 09. Documentation 

(a) Design Choices
Model-View-ViewModel (MVVM) 

(b) Implementation Decisions
Firebase Authentication Implementation,Firestore Data Structure,Firestore Integration,Image Handling and Firebase Storage Integration
(c) Challenges
Handling Image Uploads

#### 10. Additional iOS Library used
uikit,mapkit,FirebaseStorage,FirebaseFirestore


#### 11. Reflection of using SwiftUI compared to UIKit
SwiftUI offers a declarative and modern approach to building user interfaces compared to the imperative nature of UIKit, simplifying UI development.
Reflection of using SwiftUI compared to UIKit

#### 12. Reflection General
Learning and adopting SwiftUI
Challenges that you faced in doing the assingment (other than know technical issues of getting hold of a proper Mac machine).
How would have approached this Assignment differently

  

