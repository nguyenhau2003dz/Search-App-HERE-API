//
//  SearchMapApp.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 22/5/25.
//

import SwiftUI
import heresdk

@main
struct SearchMapApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
        }
    }
    
    init() {
           observeAppLifecycle()
           initializeHERESDK()
    }
    
    private func observeAppLifecycle() {
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification,
                                               object: nil,
                                               queue: nil) { _ in
            print("App is about to terminate.")
            disposeHERESDK()
        }
    }
    private func initializeHERESDK() {
        let authenticationMode = AuthenticationMode.withKeySecret(accessKeyId: Constants.accessKeyID,
                                                                  accessKeySecret: Constants.accessKeySecret)
        let options = SDKOptions(authenticationMode: authenticationMode)
        do {
            try SDKNativeEngine.makeSharedInstance(options: options)
        } catch let engineInstantiationError {
            fatalError("Failed to initialize the HERE SDK. Cause: \(engineInstantiationError)")
        }
    }
    private func disposeHERESDK() {
        SDKNativeEngine.sharedInstance = nil
    }
}
