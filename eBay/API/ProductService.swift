//
//  ProductService.swift
//  eBay
//
//  Created by Dan Hozan on 05.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct ProductData {
    let image: UIImage
    let title: String
    let subtitile: String
    let price: String
    let description: String
}

class ProductService {
    
    static let shared = ProductService()
    
    private init () {}
    
    func uploadProduct(prodcutToUpload product: ProductData) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let productId = UUID()
        
        FileStorage.shared.uploadImageToFirebase(image: product.image, imagePath: FImagePath.productImages) { url in
            let productData = Product(id: productId.uuidString, ownerId: uid, title: product.title, subtitle: product.subtitile, price: Double(product.price)!, description: product.description, productImageLink: url, timestamp: Date())
            do {
                try FirebaseReference(collectionReferance: .Product).document(productId.uuidString).setData(from: productData)
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    func fetchProducts(completion:@escaping ([Product]?) -> Void) {
        
        FirebaseReference(collectionReferance: .Product).getDocuments { querySnapshot, error in
            if let error = error {
                print("ERROR: ",error.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            
            let products = documents.compactMap { queryDocumentSnapshot -> Product? in
                do {
                    return try queryDocumentSnapshot.data(as: Product.self)
                } catch {
                    print("ERROR: ", error.localizedDescription)
                    return nil // Return nil if mapping fails
                }
            }
            
            completion(products)
        }
    }
    
  
}
