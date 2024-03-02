//
//  AuthentificationService.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import FirebaseAuth

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
        
    private init() {}
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                // Sign in successful
                completion(.success(user))
            } else if let error = error {
                // Sign in failed
                completion(.failure(error))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
           Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               if let user = authResult?.user {
                   completion(.success(user))
               } else if let error = error {
                   completion(.failure(error))
               }
           }
       }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
           do {
               try Auth.auth().signOut()
               completion(.success(()))
           } catch let signOutError as NSError {
               completion(.failure(signOutError))
           }
       }
    
    func checkIfUserIsSignedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
}
