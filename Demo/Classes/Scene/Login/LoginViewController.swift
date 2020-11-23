//
//  LoginViewController.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    
    var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var username: UITextField = {
        let view = UITextField()
        view.placeholder = R.string.localization.loginUsername()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var password: UITextField = {
        let view = UITextField()
        view.placeholder = R.string.localization.loginPassword()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()
    
    lazy var loginBtn: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(R.string.localization.loginLoginBtnTitle(), for: .normal)
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(loginBtn)
        
        username.snp.makeConstraints { m in
            m.left.right.equalToSuperview().inset(16)
            m.top.equalToSuperview().inset(100)
            m.height.equalTo(44)
        }
        
        password.snp.makeConstraints { m in
            m.top.equalTo(username.snp.bottom).offset(30)
            m.left.right.height.equalTo(username)
        }
        
        loginBtn.snp.makeConstraints { m in
            m.top.equalTo(password.snp.bottom).offset(30)
            m.left.right.height.equalTo(username)
        }
    }
    
    override func bindViewModel() {
        
        let input = LoginViewModel.Input(username: username.rx.text.orEmpty,
                                         password: password.rx.text.orEmpty,
                                         loginAction: loginBtn.rx.tap)
        
        let out = viewModel.transform(input: input)
        out.loginBtnEnabled.drive(loginBtn.rx.isEnabled).disposed(by: rx.disposeBag)

//        viewModel.loading.skip(1).asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        
        loginBtn.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] () in
                self?.view.endEditing(true)
            }).disposed(by: rx.disposeBag)
        
//        viewModel.error
//            .map { $0.resolve() }
//            .drive(rx.showError)
//            .disposed(by: rx.disposeBag)
    }
}
