//
//  Network.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!)
}
