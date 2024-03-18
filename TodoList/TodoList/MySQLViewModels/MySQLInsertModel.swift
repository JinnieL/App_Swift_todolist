//
//  MySQLInsertModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

class MySQLInsertModel{
    var urlPath = "http://localhost:8080/insert"      // 스프링 컨트롤러 확인하기!
    
//    func insertItems(userid: String, imagefilename: String, content: String) -> Bool{
    func insertItems(content: String) -> Bool{
        var result:Bool = true
//        let urlAdd = "?userid=Jinnie&imagefilename=pikachu-3.jpg&content=\(content)&viewstatus=1&donestatus=0"
        let urlAdd = "?userid=Jinnie&content=\(content)&viewstatus=1&donestatus=0"
        urlPath = urlPath + urlAdd
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url: URL = URL(string: urlPath)!
        
        DispatchQueue.global().async {
            do{
                _ = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    result = true
                }
            }catch{
                print("Failed to insert data")
                result = false
            }
        }
        return result
    }
}
