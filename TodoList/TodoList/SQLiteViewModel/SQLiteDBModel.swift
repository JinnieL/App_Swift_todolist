//
//  SQLiteDBModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import Foundation

struct SQLiteDBModel{
    var seq: Int
    var imagefile: Data
    var content: String
    var viewstatus: Int
    var donestatus: Int
//    var insertdate: String

    init(seq: Int, imagefile: Data, content: String, viewstatus: Int, donestatus: Int) {
        self.seq = seq
        self.imagefile = imagefile
        self.content = content
        self.viewstatus = viewstatus
        self.donestatus = donestatus
    }
    
}
