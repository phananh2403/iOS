//
//  ViewController.swift
//  tableViewSample
//
//  Created by MACBOOK PRO on 14/09/2021.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // khoi tao doi tuong
    struct animalsInfo {
        var name: String
    }
    // khoi tao dictionary gom key: String,Values: doi tuong animalsInfo
    var animals = [String : [animalsInfo]]()
    // tao 1 mang chua key cua dictionary voi kdl: String
    var dataKeys: Array = [String]()
    
//    var animals = [
//        "B": ["Bear", "Black Swan", "Buffalo"],
//        "C": ["Camel", "Cockatoo"],
//        "D": ["Dog", "Donkey"],
//        "E": ["Emu"],
//        "G": ["Giraffe", "Greater Rhea"],
//        "H": ["Hippopotamus", "Horse"],
//        "K": ["Koala"],
//        "L": ["Lion", "Llama"],
    
//        "M": ["Manatus", "Meerkat"],
//        "P": ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
//        "R": ["Rhinoceros"],
//        "S": ["Seagull"],
//        "T": ["Tasmania Devil"],
//        "W": ["Whale", "Whale Shark", "Wombat"]
//    ]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        // dictionary animals gom key:values
        animals = [
            "B" : [
                animalsInfo(name: "Bear"),
                animalsInfo(name: "Black Swan"),
                animalsInfo(name: "Buffalo")
            ],
            "C" : [
                animalsInfo(name: "Camel"),
                animalsInfo(name: "Cockatoo")
            ],
            "D" : [
                animalsInfo(name: "Dog"),
                animalsInfo(name: "Donkey")
            ],
            "E" : [
                animalsInfo(name: "Emu")
            ],
            "G" : [
                animalsInfo(name: "Giraffe"),
                animalsInfo(name: "Greater Rhea")
            ],
            "H" : [
                animalsInfo(name: "Hippopotamus"),
                animalsInfo(name: "Horse")
            ],
            "K" : [
                animalsInfo(name: "Koala")
            ],
            "L" : [
                animalsInfo(name: "Lion"),
                animalsInfo(name: "Llama")
            ]
                
        ]
        dataKeys = (animals as NSDictionary).allKeys as! [String] // gan tat ca cac key cua animals vao mang dataKeys
        print(dataKeys)
        tableView.reloadData()
    }
    // number of section - so luong section
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataKeys.count
    }
    // number row in section - so luong row trong section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = dataKeys[section]
        return animals[sec]?.count ?? 0
    }
    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    // kich thuoc header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 // 50 pixels
    }
    // ten header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // sap xep cac phan tu trong array dataKeys
        dataKeys = dataKeys.sorted()
        return dataKeys[section]
    }
    //Trong mỗi Cell sẽ hiển thị những gì cấu hình trong hàm này
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "myCell")!
        let sec = dataKeys[indexPath.section]
        cell.textLabel?.text = animals[sec]?[indexPath.row].name
        return cell
    }
    /*
     Mỗi cell được xác định bởi giá trị IndexPath, IndexPath bao gồm:
        section: section trong table view mà cell đó thuộc về
        row: chỉ mục của row trong section
    */
    
}

