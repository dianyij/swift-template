//
//  HomeViewController.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import DZNEmptyDataSet
import KakaJSON
import NSObject_Rx
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class HomeViewController: ViewController {
    var viewModel: HomeViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = R.color.background()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
        configureCell: { _, tv, _, element in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )

    let aView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

    override func viewDidLoad() {
        view.addSubview(aView)
        view.addSubview(tableView)
        aView.backgroundColor = .red
        aView.layer.cornerRadius = 8
        aView.rx.tapGesture().bind { ges in
            print(ges.view?.width ?? 0)
        }.disposed(by: rx.disposeBag)

        viewModel.requestRepositories()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    override func updateViewConstraints() {
        super.updateViewConstraints()

        guard !didSetupConstraints else { return }
        didSetupConstraints = true
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let homeItem = viewModel.cellForRowAt(indexPath: indexPath)
        cell.textLabel?.text = homeItem.name
        return cell
    }
}
