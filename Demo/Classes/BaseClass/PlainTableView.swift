//
//  PlainTableView.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

class PlainTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableFooterView = UIView()
        tableFooterView = UIView()
    }

}
