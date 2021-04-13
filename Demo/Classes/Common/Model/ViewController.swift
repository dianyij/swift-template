//
//  ViewController.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet
import KakaJSON
import NSObject_Rx

class ViewController: UIViewController {
    
    let isLoading = BehaviorRelay(value: false)
    
    var automaticallyAdjustsLeftBarButtonItem = true
    var navigationTitle = "" { didSet { navigationItem.title = navigationTitle } }
    var emptyDataSetTitle = R.string.localization.commonNoContent()
    var emptyDataSetImage = R.image.empty_content()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    lazy var closeBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: R.image.cancel(),
                                   style: .plain,
                                   target: self,
                                   action: nil)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        
        closeBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        // Observe device orientation change
        NotificationCenter.default
            .rx.notification(UIDevice.orientationDidChangeNotification)
            .subscribe { [weak self] (_) in
                self?.orientationChanged()
            }.disposed(by: rx.disposeBag)
        
        // Observe application did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (_) in
                self?.didBecomeActive()
            }.disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func bindViewModel() { }
    
    func updateUI() { }
    
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    
    func didBecomeActive() {
        self.updateUI()
    }
    
    func adjustLeftBarButtonItem() {
        if navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            navigationItem.leftBarButtonItem = nil
        } else if presentingViewController != nil { // Presented
            navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    func currentViewController() -> String {
        guard let `class` = "\(self)".split(separator: ".").last else {
            return "unknow viewcontroller class"
        }
        return String(`class`)
    }
}

extension ViewController {
    func showError(error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    var inset: CGFloat {
        return 10
    }
    
    func emptyView(height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        return view
    }
}

extension Reactive where Base: ViewController {
    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
        return Binder(base) { view, color in
            view.emptyDataSetImageTintColor.accept(color)
        }
    }
}

extension ViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension ViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
