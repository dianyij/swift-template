//
//  HomeViewModel.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import NSObject_Rx
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class HomeViewModel: ViewModel {
    let service: HomeService!

    var needReloadTableView: (() -> Void)?
    var needShowError: ((NetworkError) -> Void)?

    private var items = [HomeItem]()

    override init() {
        service = HomeService()
    }

    /// Request repositories
    func requestRepositories() {
        service.hello(name: "a") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                print(response)
                self.items = response.items ?? []
                self.needReloadTableView?()
            case let .failure(error):
                self.needShowError?(error)
            }
        }
    }

    func numberOfRowsInSection(section _: Int) -> Int {
        return items.count
    }

    func cellForRowAt(indexPath: IndexPath) -> HomeItem {
        return items[indexPath.row]
    }
}
