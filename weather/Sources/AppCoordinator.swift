//
//  AppCoordinator.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Properties
    
    private unowned var appDelegate: AppDelegate
    
    private let context: Context
    
    private var mainCoordinator: MainCoordinator?
    
    private let stack: CoreDataStack
    
    // MARK: - Initializer
    
    init(appDelegate: AppDelegate, context: Context, stack: CoreDataStack) {
        self.appDelegate = appDelegate
        self.context = context
        self.stack = stack
    }
    
    // MARK: - Start
    
    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()
        
        // to stop running while testing
        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }
        
        showMain()
    }
    
    // MARK: - Private
    
    private func showMain() {
        mainCoordinator = MainCoordinator(presenter: appDelegate.window!, context: context, stack: stack)
        mainCoordinator?.start()
    }
}
