//
//  ImageUploadModel.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/29.
//

import Foundation
import UIKit

class ImageUploadModel {
    var image : UIImage?
    let url = URL(string: "https://localhost:8080/uploadImage")!
    
    func uploadImage(image: UIImage, imageFileName: String) {
        // 받은 이미지를 jpeg 데이터로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to JPEG Data")
            return
        }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP Body에 이미지 데이터 추가하기 (NSData?)
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var httpBody = Data()
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(imageFileName)\"\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: \("image/jpg")\r\n\r\n".data(using: .utf8)!)
        httpBody.append(imageData)
        httpBody.append("\r\n".data(using: .utf8)!)
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = httpBody as Data
        
        // URLSession을 사용하여 서버에 요청
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Invaild response")
                return
            }
            print("Status code: \(response.statusCode)")
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }
        task.resume()        
    }
    
}


