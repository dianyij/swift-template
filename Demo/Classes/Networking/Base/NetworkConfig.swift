//
//  NetworkConfig.swift
//  Demo
//
//  Created by dianyi jiang on 28/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct NetworkKonfigs {
    static let baseURL: URL = URL(string: Konfigs.Network.baseURL)!
    static let timeoutInterval: TimeInterval = 15
    static let contentType: String = "application/json"
}

public class NetworkConfig {
    static func provider() -> MoyaProvider<MultiTarget> {
        let endPointClosure = { (target: TargetType) -> Endpoint in
            let url = target.baseURL.absoluteString + target.path
            let endpoint = Endpoint(url: url,
                                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)
            return endpoint
        }

        let requestClosure = { (endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) in
            do {
                var urlRequest = try endpoint.urlRequest()
                urlRequest.addValue(NetworkKonfigs.contentType, forHTTPHeaderField: "Content-Type")
                urlRequest.timeoutInterval = NetworkKonfigs.timeoutInterval
                closure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }

        let plugins: [PluginType] = {
            let logger = NetworkLoggerPlugin()
            let authorization = AccessTokenPlugin(tokenClosure: { _ in
                return AuthManager.shared.token?.basicToken ?? ""
            })
            return [logger, authorization]
        }()

        return MoyaProvider(endpointClosure: endPointClosure, requestClosure: requestClosure, plugins: plugins)
    }

    static func stubbingProvider() -> MoyaProvider<MultiTarget> {
        return MoyaProvider(stubClosure: { _ in .immediate })
    }
}

extension Observable {
    func authHandler() -> Observable<Element> {
        return self.do(onError: { (error) in
            if let e = error as? MoyaError,
                case let .statusCode(response) = e,
                response.statusCode == 401 {
                AuthManager.removeToken()
            }
        })
    }
}
