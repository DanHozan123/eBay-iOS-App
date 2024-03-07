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
            
            let sortedProducts = products.sorted { $0.timestamp <  $1.timestamp }
            
            completion(sortedProducts)
        }
    }
    
    func addToFavoritesListProduct(thisProduct productId: String, toThisUserFavoritesList uid: String, completion: @escaping (Error?) -> Void) {
        
        FirebaseReference(collectionReferance: .Users).document(uid).collection("favorites").document(productId).setData([:]) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            completion(error)
        }
    }
    
    func checkIfProductIsOnUserFavoritesList(productId: String, userId: String, completion: @escaping(Bool) -> Void) {
        FirebaseReference(collectionReferance: .Users).document(userId).collection("favorites").document(productId).getDocument { snapshot, error in
            guard let snapshotExists = snapshot?.exists else { return }
            completion(snapshotExists)
        }
    }
    
    func deleteProductFromFavoritesList(productId: String, userId: String, completion: @escaping (Error?) -> Void) {
        
        let favoritesRef = FirebaseReference(collectionReferance: .Users).document(userId).collection("favorites").document(productId)
        
        favoritesRef.delete { error in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
            }
            completion(error)
        }
    }
    
    func fetchFavoritesListProducts(currentUserId: String, completion: @escaping ([Product]) -> Void) {
        FirebaseReference(collectionReferance: .Users).document(currentUserId).collection("favorites").getDocuments { querySnapshot, _ in
            guard let querySnapshot = querySnapshot?.documents else { return }
            let productsIds = querySnapshot.map{ $0.documentID }
            self.fetchProductsIDs(ids: productsIds) { products in
                guard let products = products else { return }
                completion(products)
            }
            
        }
    }
    
    
    func fetchProductsIDs(ids: [String], completion:@escaping ([Product]?) -> Void){
        var products = [Product]()
        var count = 0
        ids.forEach { id in
            FirebaseReference(collectionReferance: .Product).document(id).getDocument { documentSnapshot, _ in
                if let product = try? documentSnapshot!.data(as: Product.self) {
                    products.append(product)
                    count += 1
                    if count == ids.count {
                        completion(products)
                    }
                }
            }
        }
        
    }
    
    
}
