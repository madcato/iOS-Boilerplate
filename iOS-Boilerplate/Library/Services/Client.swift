//
//  Client.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 03/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation

extension Http {
class Client {
    private let session: URLSession!
    private let baseURL: URL!
    private let queue = DispatchQueue(label: "ClientHttpQueue")
    private var dataTask: URLSessionDataTask?

    init(baseURL: String, basePath: String, defaultHeaders: [AnyHashable: Any]? = nil) {
        guard let url = URL(string: baseURL)?.appendingPathComponent(basePath) else {
            fatalError("Invalid url or base path: \(baseURL) - \(basePath)")
        }
        self.baseURL = url
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        self.session = URLSession(configuration: configuration)
    }

    /// request data. This is a GET HTTPrequest
    /// - param endpoint: url of the endpoint and the type of the response.
    ///               The response will be decoded to this format
    /// - param completion: this block will be called at the end of the processing, with the resul or the error
    ///
    func request<Response>(_ endpoint: Http.Endpoint<Response>,
                           completion: @escaping (Http.Result<Response>) -> Void) {
        guard dataTask == nil else {
            fatalError("Trying to launch a data task before finising previous.")
        }
        guard endpoint.method == .get else {
            fatalError("This method only handle GET")
        }
        let url = url(path: endpoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let parameters: [String: String?] = endpoint.parameters as? [String: String?] {
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        if let finalQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B") {
            components?.percentEncodedQuery = finalQuery
        }
        let urlRequest = URLRequest(url: components?.url ?? url)
        dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            if let error = error {
                let httpResponse = response as? HTTPURLResponse
                DispatchQueue.main.async {
                    completion(Http.Result.error(httpResponse?.statusCode ?? 0, error.localizedDescription))
                }
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                do {
                    let responseData = try endpoint.decode(data)
                    DispatchQueue.main.async {
                        completion(Http.Result.success(responseData))
                    }
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }

            } else {
                fatalError("Invalid status code")
            }
        }
        dataTask?.resume()
    }

    private func url(path: Http.Path) -> URL {
        baseURL.appendingPathComponent(path)
    }
}
}
