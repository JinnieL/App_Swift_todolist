//
//  MySQLTableViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/08/26.
//

import UIKit

class MySQLTableViewController: UIViewController {

    @IBOutlet weak var tfSerch: UITextField!
    @IBOutlet weak var tvListView: UITableView!
    
    var todoList: [DBModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvListView.dataSource = self
        tvListView.delegate = self
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readValue()
    }
    
    
    
    @IBAction func btnSerch(_ sender: UIButton) {
        let searchModel = MySQLSearchModel()
        searchModel.delegate = self
        searchModel.downloadItems(searchFor: tfSerch.text!)
    }
    

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgMySQLDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! MySQLDetailViewController
            detailView.receivedSeq = todoList[indexPath!.row].seq
//            detailView.receivedImage = todoList[indexPath!.row].imagefilename
            detailView.receivedList = todoList[indexPath!.row].content
            
        }
    }

    
    // ----------- functions ----------------
    func readValue(){
        let queryModel = MySQLQueryModel()
        queryModel.delegate = self
        queryModel.downloadItems()
    }
    
    func removeAction(seq: Int){
        let deleteModel = MySQLDeleteModel()
        let result = deleteModel.deleteItem(seq: seq)
        if result {
            let resultAlert = UIAlertController(title: "완료", message: "삭제가 완료 되었습니다.", preferredStyle: .alert)
            let noAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                self.readValue()
                self.tvListView.reloadData()
            })
            resultAlert.addAction(noAction)
            present(resultAlert, animated: true)
        } else {
            let resultAlert = UIAlertController(title: "ERROR", message: "오류가 발생했습니다.", preferredStyle: .alert)
            let noAciton = UIAlertAction(title: "확인", style: .default)
            resultAlert.addAction(noAciton)
            present(resultAlert, animated: true)
        }
    }
    

}   // MySQLTableViewController

extension MySQLTableViewController: MySQLQueryModelProtocol{
    func itemDownloaded(items: [DBModel]) {
        todoList = items
        self.tvListView.reloadData()
    }
}

extension MySQLTableViewController: MySQLSearchModelProtocol{
    func itemDownload(items: [DBModel]) {
        todoList = items
        self.tvListView.reloadData()
    }
    

}

extension MySQLTableViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MySQLTableViewCell

        // Configure the cell...
//        cell.imgViewCell.image = UIImage(named: "\(todoList[indexPath.row].imagefilename)")
        cell.lblTodoList.text = "\(todoList[indexPath.row].content)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                removeAction(seq: todoList[indexPath.row].seq)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
    
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 이동할 Item의 복사
        let itemToMove = todoList[fromIndexPath.row]
        // 이동할 Item의 삭제
        todoList.remove(at: fromIndexPath.row)
        // 삭제된 Item의 새로운 위치로 삽입
        todoList.insert(itemToMove, at: to.row)
    }
}

