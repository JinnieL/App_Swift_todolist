//
//  SQLiteQueryModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import Foundation
import SQLite3
import UIKit

protocol SQLiteQueryModelProtocol {
    func itemDownloaded(items: [SQLiteDBModel])
}

class SQLiteQueryModel {
    var delegate : SQLiteQueryModelProtocol!
    var db: OpaquePointer?
    var studentList: [SQLiteDBModel] = []
    var fileURL: URL
    
    init() {
        fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoListSwift.sqlite")
        openDB()
    }   // init
    
    func openDB(){
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                    print("Error opening database")
        }
    }   // openDB
    
    func closeDB(){
        sqlite3_close(db)
    }    // closeDB
    
    func createListTable(){
        let createTodoListTable = "CREATE TABLE IF NOT EXISTS todolist (seq INTEGER PRIMARY KEY AUTOINCREMENT, imagefile BLOB, content TEXT, viewstatus INTEGER, donestatus INTEGER)"
        
        openDB()
        
        // create 정상 작동 여부 확인
        if sqlite3_exec(db, createTodoListTable, nil, nil, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errMSG)")
            return
        } else {
            print("이거 출력되면 만들어진거다")
            print("SQLite Database Path: \(fileURL.path)")
            return
        }
    }   // createListTable
    
//    func tempInsert() {
//        openDB()
//
//        if let image = UIImage(named: "pikachu-3.jpg"), let imageData = image.pngData() {
//            var stmt: OpaquePointer?
//            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
//            let queryString = "INSERT INTO todolist (imagefile, content, viewstatus, donestatus) VALUES (?,?,?,?)"
//
//            if sqlite3_prepare(db, queryString, -1, &stmt, nil) == SQLITE_OK{
//                sqlite3_bind_blob(stmt, 1, (imageData as NSData).bytes, Int32(imageData.count), SQLITE_TRANSIENT)
//                sqlite3_bind_text(stmt, 2, "SQLite CRUD 끝내기", -1, SQLITE_TRANSIENT)
//                sqlite3_bind_int(stmt, 3, 1)
//                sqlite3_bind_int(stmt, 4, 0)
//
//                if sqlite3_step(stmt) == SQLITE_DONE {
//                    print("Image and data inserted successfully")
//                } else {
//                    print("Error inserting image and data: \(String(cString: sqlite3_errmsg(db)))")
//                }
//
//                sqlite3_finalize(stmt)
//            } else {
//                let errMSG = String(cString: sqlite3_errmsg(db)!)
//                print("error preparing insert: \(errMSG)")
//            }
//        } else {
//            print("Image Not Found")
//        }
//
//        closeDB()
//    }   // tempInsert

    func readValues(){
        openDB()
        var locations: [SQLiteDBModel] = []
        let queryString = "SELECT * FROM todolist"
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMSG)")
            return
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let seq = Int(sqlite3_column_int(stmt, 0))
            let imagefile = Data(bytes: sqlite3_column_blob(stmt, 1), count: Int(sqlite3_column_bytes(stmt, 1)))
            let content = String(cString: sqlite3_column_text(stmt, 2))
            
            let viewstatus = Int(sqlite3_column_int(stmt, 3))
            let donestatus = Int(sqlite3_column_int(stmt, 4))
            
            let dbModel = SQLiteDBModel(seq: seq, imagefile: imagefile, content: content, viewstatus: viewstatus, donestatus: donestatus)
            locations.append(dbModel)
        }
        
        DispatchQueue.main.async {
            self.delegate.itemDownloaded(items: locations)
        }
    }   // readValues()
    
    func insertAction(imagefile: UIImage?, content: String, viewstatus: Int, donestatus: Int) -> Bool {
        var result = false
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            var stmt: OpaquePointer?
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            
            if let imageData = imagefile?.pngData() {
                let queryString = "INSERT INTO todolist (imagefile, content, viewstatus, donestatus) VALUES (?,?,?,?)"
                
                sqlite3_prepare(db, queryString, -1, &stmt, nil)
                
                sqlite3_bind_blob(stmt, 1, (imageData as NSData).bytes, Int32(imageData.count), SQLITE_TRANSIENT)
                sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
                sqlite3_bind_int(stmt, 3, 1)
                sqlite3_bind_int(stmt, 4, 0)
                
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("insert successfully")
                    result = true
                    sqlite3_finalize(stmt)
                } else {
                    print("Error inserting image and data: \(String(cString: sqlite3_errmsg(db)))")
                    result = false
                }   // check insert done status
                
            }else{
                print("Error converting image to PNG data")
            }   // check convert image and insert status
        }
        return result
    }   // insertAction
    
    func deleteAction(seq: Int) -> Bool {
        var result = false
        var stmt: OpaquePointer?
        let queryString = "DELETE FROM todolist WHERE seq = ?"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(seq))

            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Delete successful")
                result = true
            } else {
                print("Error deleting data: \(String(cString: sqlite3_errmsg(db)))")
            }
            sqlite3_finalize(stmt)
        } else {
            print("Error preparing delete statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        return result
    }   // deleteAction
    
    func updateAction(seq: Int, imagefile: UIImage?, content: String, viewstatus: Int, donestatus: Int) -> Bool {
        var result = false
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE todolist SET imagefile = ?, content = ?, viewstatus = ?, donestatus = ? WHERE seq = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        if let imageData = imagefile?.pngData() {
            let bytes = [UInt8](imageData)
            let count = Int32(imageData.count)
            
            sqlite3_bind_blob(stmt, 1, bytes, count, SQLITE_TRANSIENT)
        } else {
            // 이미지가 nil인 경우 빈 BLOB 열로 처리
            sqlite3_bind_blob(stmt, 1, nil, 0, SQLITE_TRANSIENT)
        }
        sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(stmt, 3, Int32(viewstatus))
        sqlite3_bind_int(stmt, 4, Int32(donestatus))
        sqlite3_bind_int(stmt, 5, Int32(seq))

        if sqlite3_step(stmt) == SQLITE_DONE {
            print("update successfully")
            result = true
            sqlite3_finalize(stmt)
        } else {
            print("Error updating image and data: \(String(cString: sqlite3_errmsg(db)))")
            result = false
        }   // check update done status
        return result

    }   // updateAction
    
    func searchAction(seq: Int, content: String){
        var locations: [SQLiteDBModel] = []
        let queryString = "SELECT * FROM todolist WHERE seq = ?"
        var stmt: OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMSG = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errMSG)")
            return
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let seq = Int(sqlite3_column_int(stmt, 0))
            let imagefile = Data(bytes: sqlite3_column_blob(stmt, 1), count: Int(sqlite3_column_bytes(stmt, 1)))
            let content = String(cString: sqlite3_column_text(stmt, 2))
            
            let viewstatus = Int(sqlite3_column_int(stmt, 3))
            let donestatus = Int(sqlite3_column_int(stmt, 4))
            
            let dbModel = SQLiteDBModel(seq: seq, imagefile: imagefile, content: content, viewstatus: viewstatus, donestatus: donestatus)
            locations.append(dbModel)
        }
        
        DispatchQueue.main.async {
            self.delegate.itemDownloaded(items: locations)
        }

        
    }   // searchAction

    
}   // SQLiteQueryModel

