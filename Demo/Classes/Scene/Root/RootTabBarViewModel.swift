//
//  RootTabBarViewModel.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum TabbarItem: CaseIterable {
    case home
    case profile
}

extension TabbarItem {
    var title: String {
        switch self {
        case .home:
            return "home"
        case .profile:
            return "profile"
        }
    }
    
    var image: UIImage? {
        var imageName: String
        switch self {
        case .home:
            imageName = "home"
        case .profile:
            imageName = "profile"
        }
        return UIImage(named: imageName)
    }
    
    var selectedImage: UIImage? {
        return nil
    }
    
    private func getViewController(with viewModel: ViewModel) -> UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController(viewModel: viewModel as! HomeViewModel)
            return UINavigationController(rootViewController: vc)
        case .profile:
            let vc = ProfileViewController(viewModel: viewModel as! ProfileViewModel)
            return UINavigationController(rootViewController: vc)
        }
    }
    
     func viewController(for viewModel: ViewModel) -> UIViewController {
        let vc = getViewController(with: viewModel)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
        return vc
    }
}

class RootTabBarViewModel: ViewModel, ViewModelType {
    struct Input {
        var viewDidAppear: Observable<Void>
    }
    
    struct Output {
        var tabBarItems: Driver<[TabbarItem]>
    }
    
    func transform(input: RootTabBarViewModel.Input) -> RootTabBarViewModel.Output {
        let items = input.viewDidAppear
            .map { _ in
                return TabbarItem.allCases
            }
            .asDriver(onErrorJustReturn: [])
        return Output(tabBarItems: items)
    }
    
    func viewModel(for tabBarItem: TabbarItem) -> ViewModel {
        switch tabBarItem {
        case .home:
            return HomeViewModel(dataRepository: dataRepository)
        case .profile:
            return ProfileViewModel(dataRepository: dataRepository)
        }
    }
}