//
//  FireBaseDeleteModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/10.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FireBaseDeleteModel {
    let db = Firestore.firestore()
    
    func deleteItems(documentId: String) -> Bool {
        var status: Bool = true
        
        // documentId에 해당하는 문서를 삭제합니다.
        self.db.collection("todolist").document(documentId).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
                status = false
            } else {
                print("Document deleted successfully.")
                status = true
            }
        }
        return status
    }   // deleteItems()
    
}
