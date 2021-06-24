//
//  NetworkInjected.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 05/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

//Injector has an instance to the concrete class
enum NetworkingInjector {
    static var apiClient = Http.Client(baseURL: Configuration.serverURL,
                                       basePath: Configuration.basePath,
                                       defaultHeaders: ["Accept": "application/json",
                                                        "secret": Configuration.apiToken])
}

// Injected refers to the injector
protocol NetworkingInjected { }

extension NetworkingInjected {
    var apiClient: Http.Client { NetworkingInjector.apiClient }
}

//class ViewController: UIViewController, NetworkingInjected {
//    func fetchCurrentWeather() {
//        apiClient.fetch(...)
//    }
//}
//
//func test() {
//    NetworkingInjector.apiClient = MockAPIClient()
//    let viewController = ViewController()
//    viewController.fetchCurrentWeather()
//}
