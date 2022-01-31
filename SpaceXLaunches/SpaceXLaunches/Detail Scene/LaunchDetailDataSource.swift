//
//  LaunchDetailDataSource.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 31.01.2022.
//

import Foundation
import UIKit

typealias LaunchDetailSceneCollectionDataSource = UICollectionViewDiffableDataSource<MainSection, ShipsViewModel>
typealias LaunchDetailSnapshot = NSDiffableDataSourceSnapshot<MainSection, ShipsViewModel>
