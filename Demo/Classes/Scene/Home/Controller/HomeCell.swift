//
//  HomeCell.swift
//  Demo
//
//  Created by djiang on 19/05/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import UIKit

private enum Konstants {
    static let defaultAlpha = CGFloat(0.5)
    static let defaultCornerRadius = CGFloat(8)
    static let progressHeight = CGFloat(5)
    static let defaultMargin = CGFloat(8)
}

final class HomeCell: UITableViewCell {
    var onTap: () -> Void = {}
    
    private var didSetupConstraints: Bool = false
    
    private lazy var photoIV: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCell {
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configure() {
        contentView.backgroundColor = .systemGray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Konstants.defaultCornerRadius
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoIV.topAnchor.constraint(equalTo: topAnchor),
            photoIV.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoIV.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoIV.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc
    private func onTap(_ sender: UITapGestureRecognizer) {
        onTap()
    }
}
