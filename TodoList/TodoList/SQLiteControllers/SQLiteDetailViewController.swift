//
//  SQLiteDetailViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class SQLiteDetailViewController: UIViewController {

    @IBOutlet weak var loadImgView: UIImageView!
    @IBOutlet weak var tvTodoList: UITextView!
    
    var receivedSeq: Int = 0
    var receivedImage: UIImage?
    var receivedContent: String = ""
    
    var uploadImage: UIImage? = UIImage(systemName: "plus.app.fill")    // 업로드 할 이미지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImgView.image = receivedImage
        tvTodoList.text = receivedContent
//        print(receivedContent)
//        print("받았냐")
    }
    
    @IBAction func btnLoadImg(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        let alert = UIAlertController(title: "이미지 선택", message: "", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "앨범에서 선택", style: .default, handler: {ACTION in
            self.present(imagePicker, animated: true)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)

    }   // btnLoadImg
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        let seq = receivedSeq
        let content = tvTodoList.text ?? receivedContent
        let viewstatus = 1
        let donestatus = 0
        
        if !content.trimmingCharacters(in: .whitespaces).isEmpty{
            let updateModel = SQLiteQueryModel()
            let result = updateModel.updateAction(seq: seq, imagefile: uploadImage, content: content, viewstatus: viewstatus, donestatus: donestatus)            
            
//            print("수정값 : \(content)\nseq : \(receivedSeq)\nimagefile: \(uploadImage)")
            
            if result {
                let resultAlert = UIAlertController(title: "결과", message: "수정 완료 되었습니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "네 알겠습니다", style: .default, handler: {ACTION in
                        self.navigationController?.popViewController(animated: true)
                    }
                )
                resultAlert.addAction(okAction)
                present(resultAlert, animated: true)
            } else {
                let failAlert = UIAlertController(title: "실패", message: "오류가 발생했습니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                failAlert.addAction(okAction)
                present(failAlert, animated: true)
            }   // if - alert

        }
        
    }   // btnUpdate
    
    @IBAction func btnDelete(_ sender: UIButton) {
        let deleteModel = SQLiteQueryModel()
        let result = deleteModel.deleteAction(seq: receivedSeq)
        
        if result {
            let resultAlert = UIAlertController(title: "삭제", message: "삭제 되었습니다.", preferredStyle: .actionSheet)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true)
        } else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true)
        }
    }   // btnDelete
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}   // SQLiteDetailViewController

extension SQLiteDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            loadImgView.image = selectedImage   // 사용자 화면에서 보이는 이미지
            uploadImage = selectedImage     // DB에 입력할 이미지
        }
        dismiss(animated: true, completion: nil)

    }   // didFinishPickingMediaWithInfo
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }   // imagePickerControllerDidCancel
    
}   // UIImagePickerControllerDelegate, UINavigationControllerDelegate

