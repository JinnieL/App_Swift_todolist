//
//  SQLiteAddViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class SQLiteAddViewController: UIViewController {

    @IBOutlet weak var loadImgView: UIImageView!
    @IBOutlet weak var tfTodoList: UITextField!
    
    var uploadImage: UIImage? = UIImage(systemName: "plus.app.fill")    // 업로드 할 이미지
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
    }   // btnLoadImg -
    
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let content = tfTodoList.text ?? ""
        let viewstatus = 1
        let donestatus = 0
        
        if !content.trimmingCharacters(in: .whitespaces).isEmpty {
            let insertModel = SQLiteQueryModel()
            let result = insertModel.insertAction(imagefile: uploadImage, content: content, viewstatus: viewstatus, donestatus: donestatus)
            
            if result {
                let resultAlert = UIAlertController(title: "결과", message: "입력 되었습니다.", preferredStyle: .alert)
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
    }   // btnAdd - insertAction 후 결과에 따른 alert 창 보여주기
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}   // SQLiteAddViewController

extension SQLiteAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
