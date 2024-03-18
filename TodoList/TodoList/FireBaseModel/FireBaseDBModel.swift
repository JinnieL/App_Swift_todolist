//
//  FireBaseDBModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/10.
//

struct FireBaseDBModel{
    var documentId: String
    var imagefile: String
    var content: String
    var viewstatus: Bool
    var donestatus: Bool
    
    init(documentId: String, imagefile: String, content: String, viewstatus: Bool, donestatus: Bool) {
        self.documentId = documentId
        self.imagefile = imagefile
        self.content = content
        self.viewstatus = viewstatus
        self.donestatus = donestatus
    }
}
