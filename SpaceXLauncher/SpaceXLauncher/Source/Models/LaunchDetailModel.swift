//
//  LaunchDetailModel.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import Foundation

struct LaunchDetailModel: Hashable {
    var mainDetails: LaunchesListModel
    var launchSiteName: String
    var videoLink: String
    var rocketName: String
    var ships: [ShipModel]
}
