//
//  SQLiteTableViewController.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class SQLiteTableViewController: UIViewController {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tvListView: UITableView!
    
    var todoLists: [SQLiteDBModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvListView.delegate = self
        tvListView.dataSource = self
        
        let queryModel = SQLiteQueryModel()
        queryModel.delegate = self
        queryModel.createListTable()
//        queryModel.tempInsert()
        queryModel.readValues()
        tvListView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = SQLiteQueryModel()
        queryModel.delegate = self
        queryModel.readValues()
        tvListView.reloadData()
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgSQLiteDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            
            let detailView = segue.destination as! SQLiteDetailViewController
            detailView.receivedSeq = todoLists[indexPath!.row].seq
            detailView.receivedImage = UIImage(data: todoLists[indexPath!.row].imagefile)
            detailView.receivedContent = todoLists[indexPath!.row].content
            print("넘기기 : \(todoLists[indexPath!.row].content)")
        }
    }


}   // SQLiteTableViewController

extension SQLiteTableViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SQLiteTableViewCell

        // Configure the cell...
        cell.imgViewCell.image = UIImage(data: todoLists[indexPath.row].imagefile)
        cell.lblTodoList.text = "\(todoLists[indexPath.row].content)"

        return cell
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(todoLists[indexPath.row].seq)
            // Delete the row from the data source
            let seq = todoLists[indexPath.row].seq
            let deleteModel = SQLiteQueryModel()
            _ = deleteModel.deleteAction(seq: seq)
            SQLiteQueryModel().readValues()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
}   // extension UITableViewDataSource, UITableViewDelegate

extension SQLiteTableViewController: SQLiteQueryModelProtocol{
    func itemDownloaded(items: [SQLiteDBModel]) {
        todoLists = items
        self.tvListView.reloadData()
    }
    
    
}   // extension SQLiteQueryModelProtocol
