//
//  FirestoreDatabase.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 12/6/22.
//

import Foundation


import FirebaseCore
import FirebaseFirestore

class FireStoreDatabase: ObservableObject {
    private let db = Firestore.firestore()
    
    static var shared: FireStoreDatabase = {
        let instance = FireStoreDatabase()
        return instance
    }()
    
    private init() {}
    
    func getCollection(from collectionName : String) -> CollectionReference{
        return db.collection(collectionName)
        // parkingfloor
    }
    func getSubCollection(from collectionName : String) -> Query {
        return db.collectionGroup(collectionName)
            // ParkingFloor -> 6th Floor -> slots
    }
    func getSubCollection(from mainColRef : CollectionReference, to documentID : String, andFrom subCollName : String) -> CollectionReference {
        return mainColRef.document(documentID).collection(subCollName)
            // ParkingFloor -> 6th Floor -> slots
    }
    
}

extension FireStoreDatabase: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
