import SwiftUI

struct NewIFurnitureView: View {
    @StateObject var viewModel = NewfurnitureViewViewModel()
    @Binding var newItemPresented: Bool
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedLocation = ""
    @State private var isShowingMapView = false

    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)

            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Description", text: $viewModel.description)
                                   .textFieldStyle(DefaultTextFieldStyle())
                TextField("Price", text: $viewModel.price)
                                   .textFieldStyle(DefaultTextFieldStyle())
                                   .keyboardType(.decimalPad)

                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())

                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("Select Image")
                }
                .padding()

                Button(action: {
                    isShowingMapView = true
                }) {
                    Text("Select Location")
                }
                .padding()

                Button(action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields and select a due date that is today or newer.")
                )
            }
        }
        .sheet(isPresented: $isShowingMapView, onDismiss: {
            loadLocation()
        }) {
            MapView(selectedLocation: $selectedLocation, isPresented: $isShowingMapView)
        }



        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage)
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        viewModel.image = selectedImage
    }

    func loadLocation() {
        viewModel.location = selectedLocation
    }
}
