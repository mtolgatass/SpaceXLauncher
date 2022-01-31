//
//  ListViewController.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel = ListViewModel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    lazy var datasource: ListSceneTableDataSource = {
        let datasource = ListSceneTableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.missionName
            cell.detailTextLabel?.text = model.launchDate
            return cell
        })
        
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        viewModel.fetchLaunchList()
        
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        var snapshot = datasource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.items, toSection: 0)
        datasource.apply(snapshot)
    }
    
}
