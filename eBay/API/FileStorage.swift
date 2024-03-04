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
    
    // MARK: - Upload Image
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (String) -> Void) {
        let filename = "\(UUID().uuidString).jpg"
        let imageRef = Storage.storage().reference().child("profileImages/\(filename)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("DEBUG: Failed to convert UIImage to data. / FUNC: uploadImageToFirebase()")
            return
        }
        
        
        imageRef.putData(imageData) { (metadata, error) in
            guard let _ = metadata else {
                print("DEBUG: Error uploading image. / FUNC: uploadImageToFirebase() / ERROR:", error?.localizedDescription ?? "FUNC: uploadImageToFirebase() / ERROR: Unknown error")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("DEBUG: Error getting download URL. / FUNC: uploadImageToFirebase() / ERROR: ", error?.localizedDescription ?? "FUNC: uploadImageToFirebase() / ERROR: Unknown error")
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    
}
