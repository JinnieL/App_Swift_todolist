//
//  MySQLUpdateModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/28.
//

import Foundation

class MySQLUpdateModel{
    var urlPath = "http://localhost:8080/update"
        
    func updateItems(seq: Int, content: String) -> Bool{
//        func updateItems(seq: Int, imagefilename: String, content: String, viewstatus: Int, donestatus: Int) -> Bool 로 바꿔서 해야해!
        var result:Bool = true
//        let urlAdd = "?seq=\(seq)&imagefilename=\(imagefilename)&content=\(content)&viewstatus=\(viewstatus)&donestatus=\(donestatus)"
        let urlAdd = "?seq=\(seq)&content=\(content)"
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
                print("Failed to update")
                result = false
            }
        }
        return result
    }
}



