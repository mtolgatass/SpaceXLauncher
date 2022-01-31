//
//  LaunchViewModel.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import Foundation

class LaunchViewModel: Hashable {
    private var id = UUID()
    var launchesPast: LaunchesPast
    
    private func overrideDetailText() {
        if launchesPast.details == nil {
            launchesPast.details = "Detail of this mission could not be provided. Please see the video for additional information."
        }
    }
    
    init(launchesPast: LaunchesPast) {
        self.launchesPast = launchesPast
        overrideDetailText()
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: LaunchViewModel, rhs: LaunchViewModel) -> Bool {
      lhs.id == rhs.id
    }
}
