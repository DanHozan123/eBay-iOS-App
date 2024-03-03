//
//  FCollectionReference.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import Foundation
import FirebaseFirestore

enum FCollectionReferance: String {
    case User
}

func FirebaseReference(collectionReferance: FCollectionReferance) -> CollectionReference {
    return Firestore.firestore().collection(collectionReferance.rawValue)
}