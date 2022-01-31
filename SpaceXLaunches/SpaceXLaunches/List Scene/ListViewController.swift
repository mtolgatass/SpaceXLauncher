//
//  ListViewController.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 30.01.2022.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
    
    private var bindings: Set<AnyCancellable> = .init()
    var viewModel: ListViewModel = ListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    lazy var dataSource: ListSceneDataSource = {
        let dataSource = ListSceneDataSource(tableView: tableView, cellProvider: { [weak self] (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = model.launchesPast.missionName
            
            guard let self = self else { return cell }
            if indexPath.row == self.viewModel.items.count - 1 {
                self.viewModel.fetchLaunchList()
            }
            
            return cell
        })
        
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        viewModel.fetchLaunchList()
        
        // Do any additional setup after loading the view.
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        tableView.layer.masksToBounds = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.layer.cornerRadius = 12
        }
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        viewModel.$items.sink { [weak self] result in
            guard let self = self else { return }
            var snapshot = ListSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(result)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }.store(in: &bindings)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.items[indexPath.row]
        let vc = LaunchDetailViewController()
        vc.viewModel = model
        present(vc, animated: true)
    }
}
