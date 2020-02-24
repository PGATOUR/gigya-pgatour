//
//  GigyaNss.swift
//  GigyaNss
//
//  Created by Shmuel, Sagi on 08/01/2020.
//  Copyright © 2020 Gigya. All rights reserved.
//

import UIKit
import Flutter
import Gigya

final public class GigyaNss {
    public static var shared = GigyaNss()

    static var dependenciesContainer = Gigya.getContainer()

    // Channels id's
    static var mainChannel = "gigya_nss_engine/method/main"
    static var apiChannel = "gigya_nss_engine/method/api"

    /**
    Show ScreenSet

    - Parameter name:           ScreenSet name.
    - Parameter viewController: Shown view controller.
    */

//    public func showScreenSet(with name: String, viewController: UIViewController) {
//        let screenSetViewController = NativeScreenSetsViewController()
//        let nav = UINavigationController(rootViewController: screenSetViewController)
//
//        viewController.present(nav, animated: true, completion: nil)
//    }

    @discardableResult
    public func load<T: GigyaAccountProtocol>(asset: String, scheme: T.Type) -> BuilderOptions {
        guard let builder = GigyaNss.dependenciesContainer.resolve(ScreenSetsBuilder<T>.self) else {
            GigyaLogger.error(with: GigyaNss.self, message: "`ScreenSetsBuilder` dependency not found.")
        }

        return builder.load(withAsset: asset)
    }

    public func register<T: GigyaAccountProtocol>(scheme: T.Type) {
        GigyaNss.dependenciesContainer.register(service: ScreenSetsBuilder<T>.self) { _ in
            return ScreenSetsBuilder()
        }

        GigyaNss.dependenciesContainer.register(service: NativeScreenSetsViewModel<T>.self) { resolver in
            let loaderHelper = resolver.resolve(LoaderFileHelper.self)

            return NativeScreenSetsViewModel(loaderHelper: loaderHelper!)
        }

        GigyaNss.dependenciesContainer.register(service: NativeScreenSetsViewController<T>.self) { resolver in
            let viewModel = resolver.resolve(NativeScreenSetsViewModel<T>.self)

            return NativeScreenSetsViewController(viewModel: viewModel!)
        }

        GigyaNss.dependenciesContainer.register(service: LoaderFileHelper.self) { _ in
            return LoaderFileHelper()
        }
    }
}
