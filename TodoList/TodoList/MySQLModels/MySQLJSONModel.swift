//
//  JSONModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation
struct TodoViewList: Codable{
    let viewList: [TodoListJSON]
}

struct TodoListJSON: Codable{
    var seq: Int
    var userid: String
//    var imagefilename: String
    var content: String
    var viewstatus: Int
    var donestatus: Int
//    var insertdate: String
}
