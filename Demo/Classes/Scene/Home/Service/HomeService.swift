//
//  HomeService.swift
//  Demo
//
//  Created by djiang on 1/12/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import RxSwift

struct Home {
    let name: String
}

protocol HomeServiceType {
    var pages: Observable<[Home]?> { get }

    func getPages(_ api: HomeApi) -> Observable<String>
}

// final class HomeService: HomeServiceType {
//    var pages: Observable<[Home]?>
//    var defaultPages: [Home] = [Home()]
//
//    func getPages(_ api: HomeApi) -> Observable<String> {
//
//    }
//
//    fileprivate let networking = Networking<HomeApi>(plugins: [CookiePlugin()])
//
//
//
// }
