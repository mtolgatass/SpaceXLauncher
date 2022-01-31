//
//  Package.swift
//  SpaceXLauncher
//
//  Created by Tolga Taş on 29.01.2022.
//

import PackageDescription

let package = Package(
  name: "RxTestProject",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0"))
  ],
  targets: [
    .target(name: "RxTestProject", dependencies: ["RxSwift", "RxCocoa"])
  ]
)
