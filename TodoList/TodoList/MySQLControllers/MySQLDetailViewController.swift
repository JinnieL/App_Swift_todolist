//
//  MySQLDetailViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/26.
//

import UIKit
import AVFoundation
import Photos

class MySQLDetailViewController: UIViewController {

    @IBOutlet weak var loadImgView: UIImageView!
    @IBOutlet weak var tvTodoList: UITextView!
    
    let photo = UIImagePickerController()       // 앨범으로 이동하는 컨트롤러
    var imageData: NSData? = nil

    var receivedSeq: Int = 0
    var receivedImage: String = ""
    var receivedList: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImgView.image = UIImage(named: receivedImage)
        tvTodoList.text = receivedList
        photo.delegate = self
    }
    
    @IBAction func btnLoadImg(_ sender: UIButton) {
        let alert = UIAlertController(title: "이미지 선택", message: "", preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "앨범에서 선택", style: .default, handler: {ACTION in
            self.openLibrary()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
        
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
//        let code = tfCode.text ?? ""
        let listContent = tvTodoList.text ?? receivedList
        let updateModel = MySQLUpdateModel()
//        updateModel.updateItems(seq: <#T##Int#>, imagefilename: <#T##String#>, content: <#T##String#>, viewstatus: <#T##Int#>, donestatus: <#T##Int#>)
        let result = updateModel.updateItems(seq: receivedSeq, content: listContent)
        if result {
            let resultAlert = UIAlertController(title: "완료", message: "수정이 완료 되었습니다.", preferredStyle: .alert)
            let noAciton = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(noAciton)
            present(resultAlert, animated: true)
        } else {
            let resultAlert = UIAlertController(title: "ERROR", message: "오류가 발생했습니다.", preferredStyle: .alert)
            let noAciton = UIAlertAction(title: "확인", style: .default)
            resultAlert.addAction(noAciton)
            present(resultAlert, animated: true)
        }
        
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        let resultAlert = UIAlertController(title: "삭제", message: "삭제 하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네", style: .default, handler: {ACTION in
            self.deleteAction(self.receivedSeq)
        })
        let noAciton = UIAlertAction(title: "아니오", style: .default)
        
        resultAlert.addAction(okAction)
        resultAlert.addAction(noAciton)
        present(resultAlert, animated: true)
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
    
    func deleteAction(_ seq: Int) {
        let deleteModel = MySQLDeleteModel()
        let result = deleteModel.deleteItem(seq: seq)
        if result {
            let resultAlert = UIAlertController(title: "완료", message: "삭제가 완료 되었습니다.", preferredStyle: .alert)
            let noAciton = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(noAciton)
            present(resultAlert, animated: true)
        }
    }
    
}   // MySQLDetailViewController

extension MySQLDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            // [이미지 뷰에 앨범에서 선택한 사진 표시 실시]
            self.loadImgView.image = img as? UIImage
            
            // [멀티파트 서버에 사진 업로드 수행]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // [1초 후에 동작 실시]
//                let imgUploadModel = ImageUploadModel()
//                imgUploadModel.uploadImage(image: img as! UIImage, imageFileName: <#T##String#>)
            }
        }
        // [이미지 파커 닫기 수행]
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}
