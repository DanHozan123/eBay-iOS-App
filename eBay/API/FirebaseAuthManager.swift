//
//  AuthentificationService.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
        
    private init() {}
    
    // MARK: - SignIn
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            }
            else if let authResult = authResult {
                UserService.shared.downloadUserFromFirestore(userID: authResult.user.uid) { user in
                    if let user = user {
                        UserService.shared.saveUserLocally(user: user)
                        completion(nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Sign Up
    
    func signUp(email: String, username: String, password: String, avatarIamge: UIImage?, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completion(error)
            } else if let authResult = authResult {
    
                if let avatarIamge = avatarIamge {
                    FileStorage.shared.uploadImageToFirebase(image: avatarIamge, imagePath: FImagePath.profileImages) { url in
                        let user  = User(id: authResult.user.uid, email: email, username: username, avatarLink: url)
                        self.saveUserToFirestoreAndLocally(user: user)
                        completion(nil)
                    }
                }
                else {
                    let user  = User(id: authResult.user.uid, email: email, username: username, avatarLink: "")
                    self.saveUserToFirestoreAndLocally(user: user)
                    completion(nil)
                }
            }
        }
    }
    
    func saveUserToFirestoreAndLocally(user: User){
        UserService.shared.saveUserLocally(user: user)
        UserService.shared.uploadUserToFirestore(user: user)
    }
    
    
    // MARK: -  Sing Out
    func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            
            UserDefaults.standard.removeObject(forKey: "currentUser")
            UserDefaults.standard.synchronize()
            
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }

    

   

    
    
}
