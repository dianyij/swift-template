//
//  ViewController.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Moya
import KakaJSON

class ViewController: UIViewController {

    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }

    let isLoading = false
    var emptyDataSetTitle = R.string.localization.commonNoContent().localized()
    var emptyDataSetImage = R.image.empty_content()
    var emptyDataSetImageTintColor: UIColor = .white

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func currentViewController() -> String {
        guard let `class` = "\(self)".split(separator: ".").last else {
            return "unknow viewcontroller class"
        }
        return String(`class`)
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

extension ViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor
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
        return !isLoading
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
