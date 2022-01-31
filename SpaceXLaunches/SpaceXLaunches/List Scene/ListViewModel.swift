//
//  ListViewModel.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 30.01.2022.
//

import Combine
import Apollo

class ListViewModel {
    
    @Published var items = [LaunchViewModel]()
    
    private var queryOffset: Int = 0
    
    func fetchLaunchList() {
        Network.shared.apollo.fetch(query: LaunchesQuery(offset: queryOffset)) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let graphQLResult):
                    if let launchConnection = graphQLResult.data?.launchesPast {
                        let nonNilItems = launchConnection.compactMap({$0})
                        let newItems = nonNilItems.map { item in
                            return LaunchViewModel(launchesPast: item)
                        }
                        self.items.append(contentsOf: newItems)
                        self.queryOffset += newItems.count
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
            }
        }
    }
}
