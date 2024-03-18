//
//  FireBaseInsertModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/10.
//

import Firebase
import FirebaseStorage
import FirebaseFirestore

struct FireBaseInsertModel{
    let db = Firestore.firestore()
    
    func insertItems(content: String, image: UIImage?, viewstatus: Bool, donestatus: Bool) -> Bool {
        var status: Bool = true

        // 이미지가 nil이거나 이미지 데이터를 얻을 수 없으면 업로드하지 않음
        if let image = image, let imageData = image.jpegData(compressionQuality: 0.2) {
            // Firebase Storage에 이미지 업로드
            let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
            storageRef.putData(imageData, metadata: nil) { (_, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                }

            // 이미지 업로드 성공 후 Firestore에 데이터 추가
            storageRef.downloadURL { (url, error) in
                if let imageUrl = url?.absoluteString {
                    self.db.collection("todolist").addDocument(data: [
                        "content": content,
                        "imagefile": imageUrl, // 이미지 URL을 Firestore에 저장
                        "viewstatus": viewstatus,
                        "donestatus": donestatus,
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
}

}

