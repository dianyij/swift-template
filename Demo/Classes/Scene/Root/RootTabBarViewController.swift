//
//  RootTabBarViewController.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import RxViewController
import UIKit
import WhatsNewKit

class RootTabBarViewController: UITabBarController {
    var viewModel: RootTabBarViewModel

    init(viewModel: RootTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
        //        tabBar.tintColor = .systemBlue
        //        tabBar.unselectedItemTintColor = .gray
        //        tabBar.barTintColor = .clear
        //        tabBar.shadowImage = UIImage()
        //        tabBar.backgroundImage = UIImage()
    }

    func bindViewModel() {
        let input = RootTabBarViewModel.Input(viewDidAppear: rx.viewDidAppear.mapTo(()))
        let output = viewModel.transform(input: input)
        output.tabBarItems.drive(onNext: { [weak self] items in
            guard let self = self else { return }
            let controllers = items.map {
                $0.viewController(for: self.viewModel.viewModel(for: $0))
            }
            self.setViewControllers(controllers, animated: false)
        }).disposed(by: rx.disposeBag)
    }
}
