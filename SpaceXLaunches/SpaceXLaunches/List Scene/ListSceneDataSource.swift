//
//  ListSceneDataSource.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 30.01.2022.
//

import UIKit

typealias ListSceneTableDataSource = UITableViewDiffableDataSource<MainSection, LaunchViewModel>
typealias ListSnapshot = NSDiffableDataSourceSnapshot<MainSection, LaunchViewModel>

enum MainSection {
    case main
}

class ListSceneDataSource: ListSceneTableDataSource {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SpaceX Launches"
    }
}
