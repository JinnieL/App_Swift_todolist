//
//  MySQLSearchModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

protocol MySQLSearchModelProtocol{
    func itemDownload(items: [DBModel])
}

class MySQLSearchModel{
    var delegate: MySQLSearchModelProtocol!
    var urlPath = "http://localhost:8080/search"
    func downloadItems(searchFor: String){
        let urlAdd = "?searchFor=\(searchFor)"
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
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
                let query = DBModel(seq: todoList.seq, userid: todoList.userid, content: todoList.content, viewstatus: todoList.viewstatus, donestatus:todoList.donestatus)
                locations.append(query)
            }
        }catch{
            print("Fail9: \(error.localizedDescription)")
        }
        DispatchQueue.main.async{
            self.delegate.itemDownload(items: locations)
        }
    }
    
    
}

