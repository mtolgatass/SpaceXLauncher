//
//  ListViewModel.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import Foundation
import Combine

class ListViewModel {
    
    @Published var items = [LaunchesListModel]()
    
    func fetchLaunchList() {
        
        let launches = [LaunchesPast]()
        let launchesListModel : [LaunchesListModel] = launches.compactMap { item in
            return LaunchesListModel(missionName: item.missionName ?? "", launchDate: item.launchDateLocal ?? "")
        }
        items = launchesListModel
    }
}
