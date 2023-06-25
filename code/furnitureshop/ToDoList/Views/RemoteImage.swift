import SwiftUI

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    private var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        imageLoader.loadImage()
    }
}

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func loadImage() {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                }
            }
        }.resume()
    }
}
