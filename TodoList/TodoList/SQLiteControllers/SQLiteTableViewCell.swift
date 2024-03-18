//
//  SQLiteTableViewCell.swift
//  TodoList
//
//  Created by JinYeong Lee on 2023/09/03.
//

import UIKit

class SQLiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewCell: UIImageView!
    
    @IBOutlet weak var lblTodoList: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
