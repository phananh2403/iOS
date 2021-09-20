//
//  MyNoteView.swift
//  nCovid
//
//  Created by MACBOOK PRO on 18/09/2021.
//

/*
    KHI THOÁT ỨNG DỤNG NHƯNG KHÔNG THỂ LƯU THAY ĐỔI!
 */


import UIKit

class MyNoteView: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    

    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    
    // private var todoItem = ToDoItem.getMockData() - OLD
    private var todoItem = ToDoItem.getMockData()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Ghi chép mùa covid"
        // tạo 1 nút + (add) bên phải,phía trên và gán acction cho nó
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyNoteView.didTapAddItemButton(_:)))
        

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.noteTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if indexPath.row < todoItem.count {
            let item = todoItem[indexPath.row]
            cell.textLabel?.text = item.title
            
            let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark: .none
            cell.accessoryType = accessory
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Ghi chép của tôi"
    }
    
    // nhấn vào 1 row để hiện dấu tích ( có nghĩa là việc nào hoàn thành thì nhấn vào để đánh dấu )
    // method xử lý các event/action khi click vào 1 row trong section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < todoItem.count {
            let item = todoItem[indexPath.row]
            item.done = !item.done
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem){
        // tao 1 alert
        let alert = UIAlertController(title: "Ghi chú mới", message: "Mời nhập ghi chú mới!", preferredStyle: .alert)
        // thêm 1 text field cho alert
        alert.addTextField(configurationHandler: nil)
        // thêm nút cancel
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))
        // thêm nút OK
        alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text {
                self.addNewToDoItem(title: title)
            }
        }))
        // gửi alert đến người dùng
        self.present(alert, animated: true, completion: nil)
    }
    private func addNewToDoItem(title: String){
        // chỉ số của item mới = độ dài của todoItem
        let newIndex = todoItem.count
        // tạo mới 1 item & thêm nó vào list
        todoItem.append(ToDoItem(title: title))
        // thông báo cho table biết 1 row mới được tạo
        noteTable.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    // xoá 1 ghi chú
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < todoItem.count {
            todoItem.remove(at: indexPath.row)
            noteTable.deleteRows(at: [indexPath], with: .top)
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

}
