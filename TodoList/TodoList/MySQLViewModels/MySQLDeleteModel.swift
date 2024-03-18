//
//  MySQLDeleteModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

class MySQLDeleteModel{
    var urlPath = "http://localhost:8080/delete"      // spring controller 체크
        
        func deleteItem(seq: Int) -> Bool{
            var result: Bool = true
            let urlAdd = "?seq=\(seq)"
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
                    print("Failed to delete")
                    result = false
                }
            }
            return result
        }
        
    }
