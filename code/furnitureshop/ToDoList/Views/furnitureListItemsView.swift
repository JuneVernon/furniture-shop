import SwiftUI
struct furnitureListItemsView: View {
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
                    Text("Buy")
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
            ItemDetailsView(item: item, isShowingDetails: $isShowingDetails)
        }
    }
}
struct ItemDetailsView: View {
    @State private var isShowingMapView = false

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
                    isShowingDetails = false
                }) {
                    Text("Confirm Purchase")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $isShowingMapView) {
            MapView(selectedLocation: .constant(item.location ?? ""), isPresented: $isShowingMapView)
        }
        .padding()
    }
}
