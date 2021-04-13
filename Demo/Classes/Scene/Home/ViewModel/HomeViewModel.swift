//
//  HomeViewModel.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx

class HomeViewModel: ViewModel {

    let service: HomeService!

    var needReloadTableView: (() -> Void)?
    var needShowError: ((NetworkError) -> Void)?

    private var items: [HomeItem] = []

    override init() {
        self.service = HomeService()
    }

    /// Request repositories
    func requestRepositories() {
        self.service.hello(name: "a") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.items = response.items ?? []
                self.needReloadTableView?()
            case .failure(let error):
                self.needShowError?(error)
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return items.count
    }

    func cellForRowAt(indexPath: IndexPath) -> HomeItem {
        return items[indexPath.row]
    }
}
