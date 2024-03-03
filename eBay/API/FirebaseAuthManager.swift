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
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func signUp(email: String, username: String, password: String, avatarIamge: UIImage?, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completion(error)
            } else if let authResult = authResult {
    
                if let avatarIamge = avatarIamge {
                    FileStorage.shared.uploadImageToFirebase(image: avatarIamge) { url in
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
        saveUserLocally(user: user)
        saveDataToFirestore(user: user)
    }
    
    
    func saveUserLocally(user: User) {
        let defaults = UserDefaults.standard
        do {
            let userData = try JSONEncoder().encode(user)
            defaults.set(userData, forKey: "currentUser")
        } catch {
            print("DEBUG: Failed to encode user data:", error.localizedDescription)
        }
    }
    
    
    func saveDataToFirestore(user: User) {
        do {
            // Encode the data into JSON
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            
            // Convert the JSON data into a dictionary
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            // Save the dictionary to Firestore
            FirebaseReference(collectionReferance: .User).document(user.id).setData(dictionary ?? [:]) { error in
                if let error = error {
                    print("DEBUG: Error saving data to Firestore: \(error.localizedDescription)")
                }
            }
        } catch {
            print("DEBUG: Error encoding data: \(error.localizedDescription)")
        }
    }
    
    
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
    
    func checkIfUserIsSignedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }


    func currentUser() -> User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.data(forKey: "currentUser") {
                let decoder = JSONDecoder()

                do {
                    let userObject = try decoder.decode(User.self, from: dictionary)
                    return userObject
                } catch {
                    print("DEBUG: Error decoding user form user defaults: ", error.localizedDescription)
                }
            }
        }
        return nil
    }

    
    
}
