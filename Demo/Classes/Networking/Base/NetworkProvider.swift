//
//  NetworkProvider.swift
//  Demo
//
//  Created by djiang on 12/04/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import Foundation
import Moya

public typealias MultiTarget = Moya.MultiTarget

protocol NetworkingType {
    associatedtype Target: TargetType

    var provider: OnlineProvider { get }

    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}

/// - OnlineProvider
/// Make request to server
final class OnlineProvider {
    fileprivate let online: Bool
    fileprivate let provider: MoyaProvider<MultiTarget>

    init(endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider<MultiTarget>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<MultiTarget>.RequestClosure = MoyaProvider<MultiTarget>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider<MultiTarget>.neverStub,
         session: Session = MoyaProvider<MultiTarget>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Bool = true) {
        self.online = online
        provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }

    /// Request api function  from the given components.
    ///
    /// - Parameters:
    ///     - target: Target API
    ///     - type:  type for encode
    ///     - completion: return value from server
    public func request<T: Codable>(_ target: MultiTarget, type _: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                NSLog("Response = \(response)")
                // When call api success
                if response.statusCode == 200 {
                    guard let results = try? JSONDecoder().decode(T.self, from: response.data) else {
                        // Decode error
                        completion(.failure(NetworkError.parseResponseDataFalse(title: target.path)))
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.success(results))
                    }
                } else {
                    // When call API error
                    DispatchQueue.main.async {
                        let error = NSError(domain: target.path, code: response.statusCode, userInfo: nil)
                        completion(.failure(NetworkError.requestError(title: target.path, message: error.localizedDescription)))
                    }
                }
            case let .failure(error):
                NSLog("error = \(error)")
                let error = NSError(domain: target.path, code: error.errorCode, userInfo: nil)
                completion(.failure(NetworkError.requestError(title: target.path, message: error.localizedDescription)))
            }
        }
    }

    /// Request api function  from the given components.
    ///
    /// - Parameters:
    ///     - target: Target API
    ///     - completion: return value from server
    public func request(_ target: MultiTarget, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    guard let dictionary = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.parseResponseDataFalse(title: target.path)))
                        }
                        return
                    }

                    DispatchQueue.main.async {
                        completion(.success(dictionary))
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = NSError(domain: target.path, code: response.statusCode, userInfo: nil)
                        completion(.failure(NetworkError.requestError(title: target.path, message: error.localizedDescription)))
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.requestError(title: target.path, message: error.localizedDescription)))
                }
            }
        }
    }
}

/// The network layer for call API. we can use test with 'stubbingNetworking' or real API call with 'defaultNetworking'
public struct NetworkProvider: NetworkingType {
    typealias Target = MultiTarget

    let provider: OnlineProvider

    /// Default network  call
    public static func defaultNetworking() -> Self {
        return NetworkProvider(provider: newProvider(plugins))
    }

    /// testing network call
    public static func stubbingNetworking() -> Self {
        return NetworkProvider(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: NetworkProvider.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: true))
    }

    /// actual request api function
    /// - Parameters:
    /// - T: Target API
    /// - type: type for encode
    /// - completion: return value from server
    public func request<T: Codable>(_ target: MultiTarget, type _: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let actualRequest: () = provider.request(target, type: T.self, completion: completion)
        return actualRequest
    }

    /// actual request api function
    /// - Parameters:
    /// - T: Target API
    /// - completion: return value from server
    public func request(_ target: MultiTarget, completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
        let actualRequest: () = provider.request(target, completion: completion)
        return actualRequest
    }
}

extension NetworkingType {
    static func endpointsClosure<T>(_: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if Konfigs.Network.enableNetworkingLogging == true {
            plugins.append(NetworkLoggerPlugin())
        }
        return plugins
    }

    static func endpointResolver() -> MoyaProvider<Target>.RequestClosure {
        return { endpoint, closure in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

private func newProvider(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider {
    return OnlineProvider(endpointClosure: NetworkProvider.endpointsClosure(xAccessToken),
                          requestClosure: NetworkProvider.endpointResolver(),
                          stubClosure: NetworkProvider.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}
