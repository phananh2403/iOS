//
//  ViewController.swift
//  ToDoListWithCoreData
//
//  Created by MACBOOK PRO on 24/09/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // core data
    // khai bao 1 csdl
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /*
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     =
     
     let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
     let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
     (core data)
     */
    @IBOutlet weak var tableView: UITableView!
    
    private var todoListItemArr = [ToDoListItem]() // array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My ToDO List"
        getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        // tạo nút + bên phải màn hình
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    // action của nút add bên phải màn hình
    @objc private func didTapAdd() {
        let alertOfAddNewItem = UIAlertController(title: "New Item", message: "Enter new Item!", preferredStyle: .alert)
        alertOfAddNewItem.addTextField(configurationHandler: nil)
        alertOfAddNewItem.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]_ in
            guard let field = alertOfAddNewItem.textFields?.first, let text = field.text,!text.isEmpty else {
                return
            }
            self?.createItem(name: text)
        }))
        self.present(alertOfAddNewItem, animated: true, completion: nil)
    }
    
    // UITableView delegate & dataSource method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListItemArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textOfRow = todoListItemArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = textOfRow.name
        //cell.textLabel?.text = String(describing: model.createAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertWhileClickOnRow = UIAlertController(title: "Edit", message: nil , preferredStyle: .actionSheet)
        let todoItemPerRow = todoListItemArr[indexPath.row]
        alertWhileClickOnRow.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertWhileClickOnRow.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            
            let alertWhileClickEdit = UIAlertController(title: "Edit item", message: "Do you want edit?", preferredStyle: .alert)
            alertWhileClickEdit.addTextField(configurationHandler: nil)
            alertWhileClickEdit.textFields?.first?.text = todoItemPerRow.name
            alertWhileClickEdit.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self]_ in
                guard let field = alertWhileClickEdit.textFields?.first, let newName = field.text,!newName.isEmpty else {
                    return
                }
                self?.updateItem(selectedItem: todoItemPerRow, newName: newName)
            }))
            self.present(alertWhileClickEdit, animated: true, completion: nil)
            
        }))
        alertWhileClickOnRow.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(selectedItem:todoItemPerRow)
        }))
        
        self.present(alertWhileClickOnRow, animated: true, completion: nil)
    }
    // core data
    func getAllItems() {
        do {
            todoListItemArr = try context.fetch(ToDoListItem.fetchRequest())
            // cơ chế động bộ ở Main DispatchQueue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            //print("Error")
        }
        
    }
    func createItem(name: String) {
        let newTodoItem = ToDoListItem(context: context)
        newTodoItem.name = name
        newTodoItem.createAt = Date()
        
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    func deleteItem(selectedItem: ToDoListItem) {
        context.delete(selectedItem)
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
    func updateItem(selectedItem: ToDoListItem,newName: String) {
        selectedItem.name = newName
        do {
            try context.save()
            getAllItems()
        } catch {
            
        }
    }
 
}

