//
//  ListView.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 30.01.2022.
//

import UIKit

class ListView: UIView {
    private let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -64)
        ])
        
        tableView.layer.masksToBounds = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.layer.cornerRadius = 12
        }
    }
}
