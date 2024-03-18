//
//  FireBaseTableViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class FireBaseTableViewController: UIViewController {

    @IBOutlet weak var tfSerch: UITextField!    
    @IBOutlet weak var tvListView: UITableView!
    
    var todoListData: [FireBaseDBModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.delegate = self
        tvListView.dataSource = self
        tvListView.reloadData()
        readValues()
    }

    func readValues(){
        let queryModel = FireBaseQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems()
    }
    
    @IBAction func btnSerch(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}   // FireBaseTableViewController

extension FireBaseTableViewController: UITableViewDelegate, UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoListData.count
    }

    
    // 셀구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFirebaseCell", for: indexPath) as! FireBaseTableViewCell
        
        cell.isEditing = tvListView.isEditing
        
        // FirebaseDBModel에서 imageURL을 가져오기
        
        // 이미지를 다운로드하고 UIImageView에 표시
        let url = URL(string: todoListData[indexPath.row].imagefile)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.imgViewCell.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    cell.imgViewCell.image = UIImage(systemName: "photo.artframe")
                }
            }
        }
        cell.lblTodoList.text = todoListData[indexPath.row].content

        return cell
    }
    
//    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
//        tableView.setEditing(!tableView.isEditing, animated: true)
//    }

    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let documentId = todoListData[indexPath.row].documentId
            let deleteModel = FireBaseDeleteModel()
            _ = deleteModel.deleteItems(documentId: documentId) // _ = 이거는 return값을 안쓸거라서 해놓음
            self.readValues()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    

    // prepare넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetailFireBase"{
            let cell = sender as! UITableViewCell   // 셀인식
            let indexPath = self.tvListView.indexPath(for: cell)  // 몇번째 셀 인식

            let detailView = segue.destination as! FireBaseDetailViewController

            detailView.receiveDocumentId = todoListData[indexPath!.row].documentId
            detailView.receivePhoto = todoListData[indexPath!.row].imagefile
            detailView.receiveContent = todoListData[indexPath!.row].content
            detailView.receiveViewstatus = todoListData[indexPath!.row].viewstatus
            detailView.receiveDonestatus = todoListData[indexPath!.row].donestatus
        }
    }
    
    
    // 테이블 순서 이동하기
//    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        // 이동할 Item의 복사
//        let itemToMove = todoListData[fromIndexPath.row]
//        // 이동할 Item의 삭제
//        todoListData.remove(at: fromIndexPath.row)
//        // 삭제된 Item의 새로운 위치로 삽입
//        todoListData.insert(itemToMove, at: to.row)
        
        
        
        
        // 테이블 뷰 데이터 소스에서 아이템 이동
//          let itemToMove = todoListData.remove(at: fromIndexPath.row)
//          todoListData.insert(itemToMove, at: to.row)
//
//          // Firebase Firestore에서도 아이템 위치 업데이트
//          let db = Firestore.firestore()
//          let itemID = itemToMove.documentId
//          let documentRef = db.collection("todolist").document(itemID)
//          documentRef.updateData([
//              "seq": to.row // 이동한 새로운 위치
//          ]) { error in
//              if let error = error {
//                  print("Error updating document: \(error)")
//              } else {
//                  print("Document updated successfully")
//              }
//          }
//    }
    
} // extension UITableViewDelegate, UITableViewDataSource

extension FireBaseTableViewController: FireBaseQueryModelProtocol{
    func itemDownloaded(items: [FireBaseDBModel]) {
        todoListData = items    // data 넣기
        self.tvListView.reloadData()
//        myActivityIndicator.stopAnimating()
//        myActivityIndicator.isHidden = true // indicator 숨기기
    }
    
}
