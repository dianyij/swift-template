//
//  RootTabBarViewController.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxViewController

class RootTabBarViewController: UITabBarController {

    var viewModel: RootTabBarViewModel
    
    init(viewModel: RootTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
    }
    
    func setupUI() {
        view.backgroundColor = R.color.white()
    }

    func bindViewModel() {
        let input = RootTabBarViewModel.Input(viewDidAppear: rx.viewDidAppear.mapTo(()))
        let out = viewModel.transform(input: input)
        out.tabBarItems.drive(onNext: { [weak self] (items) in
            guard let self = self else { return }
            let controllers = items.map {
                $0.viewController(for: self.viewModel.viewModel(for: $0))
            }
            self.setViewControllers(controllers, animated: false)
        }).disposed(by: rx.disposeBag)
    }
}
