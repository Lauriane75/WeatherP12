//
//  AppDelegate.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var context: Context!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = .purple

        let client = HTTPClient()
        let stack = CoreDataStack(modelName: "weather",
                                  type: .prod)
        context = Context(client: client, stack: stack)
        appCoordinator = AppCoordinator(appDelegate: self,
                                        context: context,
                                        stack: stack)
        appCoordinator?.start()
        return true
    }
}
