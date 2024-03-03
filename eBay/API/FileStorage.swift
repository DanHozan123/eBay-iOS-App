//
//  FileStorage.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import UIKit
import FirebaseStorage


class FileStorage {
    
    static let shared = FileStorage()
        
    private init() {}
    
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (String) -> Void) {
 
        let storageRef = Storage.storage().reference()
        let filename = "\(UUID().uuidString).jpg"
        let imageRef = storageRef.child("profileImages/\(filename)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("DEBUG: Failed to convert UIImage to data.")
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                print("DEBUG: Error uploading image:", error?.localizedDescription ?? "DEBUG: Unknown error")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("DEBUG: Error getting download URL:", error?.localizedDescription ?? "DEBUG: Unknown error")
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    
}
