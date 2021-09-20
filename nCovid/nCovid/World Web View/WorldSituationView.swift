//
//  WorldSituationView.swift
//  nCovid
//
//  Created by MACBOOK PRO on 19/09/2021.
//

import UIKit

class WorldSituationView: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let covidWebView = UIWebView(frame: self.view.bounds)
        covidWebView.loadRequest(URLRequest(url: URL(string: "https://www.worldometers.info/coronavirus/")!))
        self.view.addSubview(covidWebView)
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
