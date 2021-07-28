//
//  AppDelegate.swift
//  sample-MVP
//
//  Created by Yudai Fujioka on 2021/07/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let vc = UIStoryboard.init(name: "Caluculate", bundle: nil).instantiateInitialViewController() as? ViewController else {
            fatalError()
        }
        
        let window = UIWindow()
        
        let model = Model()
        let presenter = Presenter(view: vc, model: model)
        vc.inhect(presenter: presenter)
        
        let navFirstVC = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navFirstVC
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

