//
//  DetailViewController.swift
//  nCovid
//
//  Created by MACBOOK PRO on 20/09/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(name)
        lbl.text = name
        img.image = UIImage(named: name)
        // Do any additional setup after loading the view.
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
