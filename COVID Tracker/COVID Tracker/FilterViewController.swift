//
//  FilterViewController.swift
//  COVID Tracker
//
//  Created by MACBOOK PRO on 01/10/2021.
//

import UIKit

class FilterViewController: UIViewController {

    public var complesion: ((State) -> Void)?
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var states: [State] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select State"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchStates()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
        
    }
    
    private func fetchStates() {
        APICaller.shared.getStateList { [weak self] result in
            switch result {
            case .success(let states):
                self?.states = states
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let state = states[indexPath.row]
        complesion?(state)
        dismiss(animated: true, completion: nil)
    }
}
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = states[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = state.name
        return cell
    }
    
    
}
