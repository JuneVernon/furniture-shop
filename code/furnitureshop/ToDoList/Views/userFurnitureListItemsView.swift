import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct userFurnitureListItemsView: View {
    @StateObject var viewModel = furnitureListItemsViewViewModel()
    let item: Furniture
    @State private var isShowingMapView = false
    @State private var isShowingDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = item.imageURL {
                RemoteImage(url: imageURL)
                    .frame(height: 200) 
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                Text(item.description)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                Text("Rs: \(String(format: "%.2f", item.price))")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)


            }
            
            HStack {
                Button(action: {
                    isShowingMapView = true
                }) {
                    Image(systemName: "map")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(Color(.gray))
                Spacer()

                Button(action: {
                    isShowingDetails = true
                }) {
                    Text("Update")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .shadow(color: Color.white.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .sheet(isPresented: $isShowingMapView) {
            MapView(selectedLocation: .constant(item.location ?? ""), isPresented: $isShowingMapView)
        }
        .sheet(isPresented: $isShowingDetails) {
            usersItemDetailsView(item: item, isShowingDetails: $isShowingDetails)
        }
    }
}
struct usersItemDetailsView: View {
    @State private var isShowingMapView = false
    @State private var isShowingUpdateForm = false

    let item: Furniture
    @Binding var isShowingDetails: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if let imageURL = item.imageURL {
                RemoteImage(url: imageURL)
                    .frame(height: 200)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(Color(.gray))
                
                Text("Description: \(item.description)")
                    .font(.subheadline)
                    .foregroundColor(.black)

                
                Text("Rs: \(String(format: "%.2f", item.price))")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)

            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    isShowingMapView = true
                }) {
                    Image(systemName: "map")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                Button(action: {
                                   isShowingUpdateForm = true
                               }) {
                                   Text("Update")
                                       .font(.headline)
                                       .foregroundColor(.white)
                                       .padding()
                                       .background(Color.blue)
                                       .cornerRadius(10)
                               }
              

              
            }
        }
        .sheet(isPresented: $isShowingMapView) {
            MapView(selectedLocation: .constant(item.location ?? ""), isPresented: $isShowingMapView)
        }
        .sheet(isPresented: $isShowingUpdateForm) {
                   UpdateFormView(item: item, isShowingUpdateForm: $isShowingUpdateForm)
               }
               .padding()
        .padding()
    }
}
struct UpdateFormView: View {
    let item: Furniture
    @Binding var isShowingUpdateForm: Bool

    @State private var updatedTitle = ""
    @State private var updatedDescription = ""
    @State private var updatedPrice: Double = 0.0

    var body: some View {
        VStack {
            TextField("Title", text: $updatedTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $updatedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Price", value: $updatedPrice, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Update") {
                let updatedItem = Furniture(
                                    id: item.id,
                                    title: updatedTitle.isEmpty ? item.title : updatedTitle,
                                    description: updatedDescription.isEmpty ? item.description : updatedDescription,
                                    price: updatedPrice > 0 ? updatedPrice : item.price,
                                    dueDate: item.dueDate,
                                    createdDate: item.createdDate,
                                    isDone: item.isDone,
                                    imageURL: item.imageURL,
                                    location: item.location)
                updateItem(updatedItem)
                
                isShowingUpdateForm = false
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
        }
    }
    private func updateItem(_ updatedItem: Furniture) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID is not available")
            return
        }

        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(updatedItem.id)
            .setData(updatedItem.asDictionary()) { error in
                if let error = error {
                    print("Error updating item: \(error.localizedDescription)")
                } else {
                    print("Item updated successfully")
                }
            }
    }


        
}
