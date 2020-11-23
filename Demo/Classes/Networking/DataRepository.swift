//
//  DataRepository.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class DataRepository {
    static let shared = DataRepository()
    
    private lazy var apiService: MoyaProvider<MultiTarget> = {
       return NetworkConfig.provider()
    }()
    
    private init() {}
}

//extension DataRepository {
//    func login(username: String, password: String) -> Observable<LoginResponse> {
//        return apiService.rx.request(Account.login(param: ["userIdentity": username, "password": password]).asMultiTarget)
//            .asObservable()
//            .authHandler()
//            .filterSuccessfulStatusAndRedirectCodes()
//            .map(LoginResponse.self)
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
//            .observeOn(MainScheduler.instance)
//    
//    }
//}
