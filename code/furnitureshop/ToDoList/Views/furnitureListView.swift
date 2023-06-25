import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct furnitureListView: View {
    @StateObject var viewModel: furnitureListViewViewModel
    @State var items: [Furniture] = []
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: furnitureListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(items) { item in
                        furnitureListItemsView(item: item)
                            .swipeActions {
                                Button("Delete") {
                                    viewModel.delete(id: item.id)
                                }
                                .tint(.red)
                            }
                    }
                    .listStyle(PlainListStyle())
                }
                .padding()
            }
            .background(Color.black.opacity(0.8)) 
            .navigationTitle("Furnitures List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewIFurnitureView(newItemPresented: $viewModel.showingNewItemView)
            }
            .onAppear {
                fetchData()
            }
        }
    }
    
    private func fetchData() {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                } else {
                    if let documents = snapshot?.documents {
                        items = documents.compactMap { document in
                            try? document.data(as: Furniture.self)
                        }
                    }
                }
            }
    }
}
