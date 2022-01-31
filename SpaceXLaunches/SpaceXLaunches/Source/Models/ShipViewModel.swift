//
//  ShipViewModel.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 31.01.2022.
//

import Foundation

class ShipsViewModel: Hashable {
    
    //MARK: - Variables
    private var id = UUID()
    var ships: Ships
    
    //MARK: - Init Function
    init(ships: Ships) {
        self.ships = ships
    }
    
    //MARK: - Hashable Conformance Functions
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: ShipsViewModel, rhs: ShipsViewModel) -> Bool {
      lhs.id == rhs.id
    }
}
