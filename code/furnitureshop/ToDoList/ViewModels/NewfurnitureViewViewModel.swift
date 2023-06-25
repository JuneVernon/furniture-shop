//
//  NewItemView.swift
//  ToDoList
//
//  Created by sharli vernan on 2023-06-11.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import Firebase
import FirebaseStorage


class NewfurnitureViewViewModel : ObservableObject{
    @Published var title = ""
    @Published var description = ""
        @Published var price = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var image: UIImage? = nil
        @Published var uploadProgress: Double = 0.0
    @Published var location = ""

        
    init(){}
    
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

        
        var canSave: Bool {
            guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
                return false
            }
            
            guard dueDate >= Date().addingTimeInterval(-86400) else {
                return false
            }
            guard let doublePrice = Double(price), doublePrice >= 0 else {
                        return false
                    }
            
            return true
        }
  }

