//
//  ViewModel.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    let dataRepository: DataRepository
    var disposeBag = DisposeBag()
    
    var page: Int?
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }
    
    deinit {
        logDebug("\(type(of: self)): deinited")
    }
}
