//
//  ViewController.swift
//  COVID Tracker
//
//  Created by MACBOOK PRO on 01/10/2021.
//

import UIKit

// data of covid cases
class ViewController: UIViewController {

    /*
    - call api
    - viewmodel
    - view: table
    - filter / user pick the state
    - update UI
    */
    private var scope: APICaller.DataScope = .national
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Covid cases"
        createFilterButton()
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getCovidData(for: scope) { result  in
            switch result {
            case .success(let locations):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createFilterButton() {
        let buttonTitle: String = {
            switch scope {
                case .national: return "National"
                case .state(let state): return state.name
            }
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(didTapFilter))
    }
    @objc func didTapFilter() {
        let vc = FilterViewController()
        vc.complesion = { [weak self] state in
            self?.scope = .state(state)
            self?.fetchData()
            self?.createFilterButton()
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

