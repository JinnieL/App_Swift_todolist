//
//  FireBaseUpdateModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/10.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseUpdateModel{
    let db = Firestore.firestore()
    
    func updateItems(documentId: String, imageUrl: UIImage?, content: String, viewstatus: Bool, donestatus: Bool) -> Bool {
        var status: Bool = true
        
        // 이미지가 nil이거나 이미지 데이터를 얻을 수 없으면 업로드하지 않음
        if let image = imageUrl, let imageData = image.jpegData(compressionQuality: 0.5) {
            // Firebase Storage에 이미지 업로드
            let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
            storageRef.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                }
                
                storageRef.downloadURL { (url, error) in
                    if let imageUrl = url?.absoluteString {
                        self.db.collection("todolist").document(documentId).updateData([
                            "content": content,
                            "imagefile": imageUrl, // 이미지 URL을 Firestore에 저장
                            "viewstatus": viewstatus,
                            "donestatus": donestatus
                        ]){error in
                            if error != nil{
                                status = false
                            }else{
                                status = true
                            }
                        }
                        
                    }
                    
                }
            }
        }
        return status
    }    // updateItems
}

