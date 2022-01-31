//
//  ShipViewModel.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 31.01.2022.
//

import Foundation

class ShipsViewModel: Hashable {
    private var id = UUID()
    var ships: Ships
    
    init(ships: Ships) {
        self.ships = ships
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: ShipsViewModel, rhs: ShipsViewModel) -> Bool {
      lhs.id == rhs.id
    }
}
