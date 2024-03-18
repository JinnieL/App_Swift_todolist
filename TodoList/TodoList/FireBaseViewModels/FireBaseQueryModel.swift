//
//  FireBaseQueryModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/10.
//

import Foundation
import Firebase

protocol FireBaseQueryModelProtocol{
    func itemDownloaded(items: [FireBaseDBModel])
}

class FireBaseQueryModel{
    var delegate: FireBaseQueryModelProtocol!
    let db = Firestore.firestore()
    
    func downloadItems(){
        var locations: [FireBaseDBModel] = []
        
        db.collection("todolist")
            .order(by: "content").getDocuments(completion: {(QuerySnapshot, err) in        // 데이터는 쿼리스냅샷에 다 들어있음
                if let err = err{
                    print("Error getting documents: \(err)")
                }else{
                    print("Data is downloaded")
                    for document in QuerySnapshot!.documents{       // 쿼리 스냅샷에 들어있는 데이터를 하나씩 떼어냄?
                        guard let data = document.data()["content"] else {return}       // content가 nil이면 return
                        print("\(document.documentID) => \(data)")
                        let query = FireBaseDBModel(documentId: document.documentID,
                                            imagefile: document.data()["imagefile"] as! String,
                                            content: document.data()["content"] as! String,
                                            viewstatus: document.data()["viewstatus"] as! Bool,
                                            donestatus: document.data()["donestatus"] as! Bool)
                        locations.append(query)
                    }   // for문 -> locations를 delegate에 넣기
                    DispatchQueue.main.async {
                        self.delegate.itemDownloaded(items: locations)      // 프로토콜에 데이터 쌓여 있음 => 테이블에서 가져다 쓰면 됨.
                    }
                }
                
            })

    }
    
    
}
