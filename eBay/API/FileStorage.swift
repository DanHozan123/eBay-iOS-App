//
//  FileStorage.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import UIKit
import FirebaseStorage




enum FImagePath: String {
    case profileImages
    case productImages
}

class FileStorage {
    
    static let shared = FileStorage()
        
    private init() {}
    
    // MARK: - Upload Image
    
    func uploadImageToFirebase(image: UIImage, imagePath: FImagePath, completion: @escaping (String) -> Void) {
        let filename = "\(UUID().uuidString).jpg"
        let imageRef = Storage.storage().reference().child("\(FImagePath.profileImages)/\(filename)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        imageRef.putData(imageData) { (metadata, error) in
            guard let _ = metadata else {
                print("ERROR: Error uploading image.", error?.localizedDescription ?? "ERROR: Unknown error.")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("DEBUG: Error getting download URL.", error?.localizedDescription ?? "ERROR: Unknown error.")
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    
}
