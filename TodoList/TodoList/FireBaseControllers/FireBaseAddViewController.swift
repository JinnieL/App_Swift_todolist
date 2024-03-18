//
//  FireBaseAddViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class FireBaseAddViewController: UIViewController {

    @IBOutlet weak var loadImgView: UIImageView!    
    @IBOutlet weak var tfTodoList: UITextField!
    
    var updatePhoto: UIImage? = UIImage(systemName: "photo.artframe") // 수정된 이미지 넣기용
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoadImg(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let content = tfTodoList.text ?? ""
        let viewstatus = true
        let donestatus = false

           
       if !content.trimmingCharacters(in: .whitespaces).isEmpty {
           let insertModel = FireBaseInsertModel()
           let result = insertModel.insertItems(content: content, image: updatePhoto, viewstatus: viewstatus, donestatus: donestatus)
           if result == true {
               // Firebase 작업이 완료될 때까지 2초 동안 대기
               Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                   let resultAlert = UIAlertController(title: "완료", message: "추가 되었습니다.", preferredStyle: .actionSheet)
                   let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                       self.navigationController?.popViewController(animated: true)
                   })
                   resultAlert.addAction(onAction)
                   self.present(resultAlert, animated: true)
               }
           } else {
               let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: .alert)
               let onAction = UIAlertAction(title: "OK", style: .default)
               resultAlert.addAction(onAction)
               present(resultAlert, animated: true)
           }
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

}   // FireBaseAddViewController

extension FireBaseAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            updatePhoto = selectedImage
            loadImgView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
