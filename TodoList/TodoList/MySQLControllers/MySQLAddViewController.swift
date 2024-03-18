//
//  MySQLAddViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/26.
//

import UIKit
import Photos
import AVFoundation

class MySQLAddViewController: UIViewController {
    @IBOutlet weak var loadImgView: UIImageView!
    @IBOutlet weak var tfTodoList: UITextField!
    
    let photo = UIImagePickerController()       // 앨범으로 이동하는 컨트롤러
    var imageData: NSData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnLoadImg(_ sender: UIButton) {
        photo.delegate = self
        let alert = UIAlertController(title: "이미지 선택", message: "", preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "앨범에서 선택", style: .default, handler: {ACTION in
            self.openLibrary()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
//        let scode = tfCode.text?.trimmingCharacters(in: .whitespaces)
        let content = tfTodoList.text?.trimmingCharacters(in: .whitespaces)
        
        let insertModel = MySQLInsertModel()
        let result = insertModel.insertItems(content: content!)
        if result {
            let resultAlert = UIAlertController(title: "결과", message: "입력 되었습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true)
        } else {
            print("insert error")
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // ------- functions -------
    func openLibrary(){
        DispatchQueue.main.async {
            self.photo.sourceType = .photoLibrary
            self.photo.allowsEditing = false
            self.present(self.photo, animated: false)
        }
    }
    
    // MARK: - [URL Session Post 멀티 파트 사진 데이터 업로드]
    func requestPOST(){
        
    }


}   // MySQLAddViewController


extension MySQLAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            // [이미지 뷰에 앨범에서 선택한 사진 표시 실시]
            self.loadImgView.image = img as? UIImage
            
            // [이미지 데이터에 선택한 이미지 지정 실시] // jpeg 압축 품질 설정
            self.imageData = (img as? UIImage)!.jpegData(compressionQuality: 0.8) as NSData?
            
            // [멀티파트 서버에 사진 업로드 수행]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // [1초 후에 동작 실시]
                self.requestPOST()
            }
        }
        // [이미지 파커 닫기 수행]
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}

