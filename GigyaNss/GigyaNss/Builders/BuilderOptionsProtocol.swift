//
//  BuilderOptionsProtocol.swift
//  GigyaNss
//
//  Created by Shmuel, Sagi on 20/01/2020.
//  Copyright © 2020 Gigya. All rights reserved.
//

import UIKit

public typealias BuilderOptions = ScreenSetsExternalBuilderProtocol & ScreenSetsActionsBuilderProtocol

public protocol ScreenSetsMainBuilderProtocol {
    func load(withAsset asset: String) -> BuilderOptions
}

public protocol ScreenSetsExternalBuilderProtocol {
    func setScreen(name: String) -> BuilderOptions
}

public protocol ScreenSetsActionsBuilderProtocol {
    func show(viewController: UIViewController)
}
