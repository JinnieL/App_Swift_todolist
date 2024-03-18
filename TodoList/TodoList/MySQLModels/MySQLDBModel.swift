//
//  DBModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

struct DBModel{
    var seq: Int
    var userid: String
//    var imagefilename: String
    var content: String
    var viewstatus: Int
    var donestatus: Int
//    var insertdate: String
    
//    init(seq: Int, userid: String, imagefilename: String, content: String, viewstatus: Int, donestatus: Int) {
//        self.seq = seq
//        self.userid = userid
//        self.imagefilename = imagefilename
//        self.content = content
//        self.viewstatus = viewstatus
//        self.donestatus = donestatus
//    }
    
    init(seq: Int, userid: String, content: String, viewstatus: Int, donestatus: Int) {
        self.seq = seq
        self.userid = userid
        self.content = content
        self.viewstatus = viewstatus
        self.donestatus = donestatus
    }

}
