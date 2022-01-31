//
//  LaunchViewModel.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import Foundation

class LaunchViewModel: Hashable {
    
    //MARK: - Variables
    private var id = UUID()
    var launchesPast: LaunchesPast
    
    //MARK: - Private Class Functions
    private func overrideDetailText() {
        if launchesPast.details == nil {
            launchesPast.details = "Detail of this mission could not be provided. Please see the video for additional information."
        }
    }
    
    //MARK: - Init Function
    init(launchesPast: LaunchesPast) {
        self.launchesPast = launchesPast
        overrideDetailText()
    }
    
    //MARK: - Hashable Conformance Functions
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: LaunchViewModel, rhs: LaunchViewModel) -> Bool {
      lhs.id == rhs.id
    }
}
