//
//  HomeViewController.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {

    let aView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    override func viewDidLoad() {
        aView.backgroundColor = .red
        view.addSubview(aView)
        aView.addTapGesture { [weak aView] _ in
            aView?.blink()
        }
    }
}
