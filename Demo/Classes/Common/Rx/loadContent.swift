//
//  loadContent.swift
//  Demo
//
//  Created by djiang on 24/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

enum FileReadError: Error {
    case fileNotFound, unreadable, encodingFailed
}

extension FileManager {
    func loadContent(from name: String, ofType: String = "json", encoding: String.Encoding = .utf8) -> Single<String> {
        return Single.create { single in
            let disposable = Disposables.create()
            guard let path = Bundle.main.path(forResource: name, ofType: ofType) else {
              single(.error(FileReadError.fileNotFound))
              return disposable
            }
            guard let data = FileManager.default.contents(atPath: path) else {
              single(.error(FileReadError.unreadable))
              return disposable
            }
            guard let contents = String(data: data, encoding: encoding) else {
              single(.error(FileReadError.encodingFailed))
              return disposable
            }
            single(.success(contents))
            return disposable
        }
    }
}
