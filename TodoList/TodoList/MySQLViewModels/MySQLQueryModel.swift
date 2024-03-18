//
//  QueryModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

protocol MySQLQueryModelProtocol{
    func itemDownloaded(items: [DBModel])
}

class MySQLQueryModel{
    var delegate: MySQLQueryModelProtocol!
//    let urlPath = "http://localhost:8080/ios/Semi_TodoList/list_query_ios.jsp"
    let urlPath = "http://localhost:8080/todolist"
    func downloadItems(){
        let url: URL = URL(string: urlPath)!
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {      // await
                    self.parseJSON(data)
                }
            } catch {
                print("Failed to download data")
            }
        }
    }
    
    func parseJSON(_ data: Data){
        let decoder = JSONDecoder()
        var locations: [DBModel] = []      // JSON 받아서 저장할 모델
    
        do{
            let todoLists = try decoder.decode(TodoViewList.self, from: data)
            for todoList in todoLists.viewList{
//                let query = DBModel(seq: todoList.seq, userid: todoList.userid, imagefilename: todoList.imagefilename, content: todoList.content, viewstatus: todoList.viewstatus, donestatus: todoList.donestatus)
                let query = DBModel(seq: todoList.seq, userid: todoList.userid, content: todoList.content, viewstatus: todoList.viewstatus, donestatus: todoList.donestatus)
                locations.append(query)
            }
        }catch{
            print("Fail9: \(error.localizedDescription)")
        }
        DispatchQueue.main.async{
            self.delegate.itemDownloaded(items: locations)
        }
    }
    
    
}

