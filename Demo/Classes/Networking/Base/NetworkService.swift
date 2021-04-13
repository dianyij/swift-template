//
//  NetworkService.swift
//  Demo
//
//  Created by djiang on 12/04/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import Foundation

class NetworkService {
    var provider: NetworkProvider!
    
    public init(isTest: Bool = false) {
        provider = isTest ? NetworkProvider.stubbingNetworking() : NetworkProvider.defaultNetworking()
    }
}
