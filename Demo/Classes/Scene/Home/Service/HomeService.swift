//
//  HomeService.swift
//  Demo
//
//  Created by djiang on 1/12/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import RxSwift

class HomeService: NetworkService {
    func hello(name: String, completion: @escaping (Result<HomeResponse, NetworkError>) -> Void) {
        provider.request(MultiTarget(HomeApi.hello(param: name)), type: HomeResponse.self, completion: completion)
    }
}
