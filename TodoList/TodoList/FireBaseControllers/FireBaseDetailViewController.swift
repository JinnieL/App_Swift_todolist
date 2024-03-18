//
//  FireBaseDetailViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class FireBaseDetailViewController: UIViewController {

    @IBOutlet weak var loadImgView: UIImageView!
    @IBOutlet weak var tvTodoList: UITextView!
    
    var receiveDocumentId = ""
    var receiveContent = ""
    var receivePhoto = ""
    var receiveViewstatus = true
    var receiveDonestatus = false
    var updatePhoto: UIImage? = UIImage(systemName: "photo.artframe") // 수정된 이미지 넣기용
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: receivePhoto) {
            // 백그라운드 큐에서 데이터 다운로드 작업 실행
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    // 데이터 다운로드 및 이미지 생성이 성공하면 UI 업데이트
                    DispatchQueue.main.async {
                        self.loadImgView.image = image
                        self.updatePhoto = image
                    }
                } else {
                    // 데이터 다운로드 또는 이미지 생성 중 오류 발생 시 처리
                    print("Failed to download image.")
                }
            }
        }


        tvTodoList.text = receiveContent

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoadImg(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        let content = tvTodoList.text ?? ""
        let viewstatus = receiveViewstatus
        let donestatus = receiveDonestatus
        
        if !content.trimmingCharacters(in: .whitespaces).isEmpty {
            let updateModel = FirebaseUpdateModel()
            
            // 여기서 receiveDocumentId는 수정하려는 todolist의 documentId입니다.
            let result = updateModel.updateItems(documentId: receiveDocumentId, imageUrl: updatePhoto, content: content, viewstatus: viewstatus, donestatus: donestatus)
            
            if result == true {
               // Firebase 작업이 완료될 때까지 2초 동안 대기
               Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                   let resultAlert = UIAlertController(title: "완료", message: "수정 되었습니다.", preferredStyle: .actionSheet)
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
    
    
    @IBAction func btnDelete(_ sender: UIButton) {
        let deleteModel = FireBaseDeleteModel()
        let result = deleteModel.deleteItems(documentId: receiveDocumentId)
        
        if result == true{
            let resultAlert = UIAlertController(title: "삭제", message: "삭제 되었습니다.", preferredStyle: .actionSheet)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true)
        }else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true)
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

}   // FireBaseDetailViewController


extension FireBaseDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
