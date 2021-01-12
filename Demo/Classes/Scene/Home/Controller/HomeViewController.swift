//
//  HomeViewController.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet
import KakaJSON
import NSObject_Rx

class HomeViewController: ViewController {

    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let aView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    override func viewDidLoad() {
        view.addSubview(aView)
        aView.backgroundColor = .red
        aView.layer.cornerRadius = 8
        aView.rx.tapGesture().bind { ges in
            
            
            print(ges.view?.width ?? 0)
        }.disposed(by: rx.disposeBag)
    }
    
}
