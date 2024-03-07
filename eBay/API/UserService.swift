//
//  FirebaseUserListener.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    // MARK: - Upload User
    
    func uploadUserToFirestore(user: User) {
        do {
            try FirebaseReference(collectionReferance: .Users).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Download User
    
    func downloadUserFromFirestore(userID: String, completion: @escaping (User?) -> Void) {
        FirebaseReference(collectionReferance: .Users).document(userID).getDocument { document, error in
            if error != nil {
                print(error?.localizedDescription ?? "ERROR: Unknown error")
                return
            } else if let document = document {
                let user = try? document.data(as: User.self)
                completion(user)
            }
        }
    }
    
    // MARK: - Get User Local Memory
    
    func getCurrentUserFromLocalMemory() -> User? {
        if let userData = UserDefaults.standard.data(forKey: "currentUser") {
            do {
                let user = try JSONDecoder().decode(User.self, from: userData)
                return user
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // MARK: - Save User To Local Memory
    
    func saveUserLocally(user: User) {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "currentUser")
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Get Current User Id From Local Memory
    
    func getCurrentUserIdFromLocalMemory() -> String {
        let currentUser = getCurrentUserFromLocalMemory()
        return currentUser?.id ?? ""
    }
    
    
}

