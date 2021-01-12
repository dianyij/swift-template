//
//  LoginViewController.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
        view.setTitle(R.string.localization.loginLoginButtonTitle(), for: .normal)
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
        
//        let left = PublishSubject<String>()
//        let center = PublishSubject<String>()
//        let right = PublishSubject<String>()
//
//        let observable = Observable.combineLatest([left, center, right]) { strings in
////            strings.joined(separator: " ")
//            "\(strings)"
//        }
//
//    _ = observable.subscribe(onNext: { value in print(value) })
//
//        print("> Sending a value to Left")
//        left.onNext("Hello,")
//        print("> Sending a value to Right")
//        right.onNext("world")
//        print("> Sending another value to Right")
//        right.onNext("RxSwift")
//        print("> Sending another value to Right")
//        right.onNext("Have a good day,")
//        left.onCompleted()
//        right.onCompleted()
//
        
//        enum Weather {
//            case cloudy
//            case sunny
//        }
//        let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
//        let right = Observable.of("Lisbon", "Copenhagen", "London")
//        let observable = Observable.zip(left, right) { weather, city in
//            return "It's \(weather) in \(city)"
//        }
//        _ = observable.subscribe(onNext: { value in
//            print(value)
//        })
       
        let seq = PublishSubject<Int>()
        let a = seq.map { (i) -> Int in
            print("MAP---\(i)")
            return i * 2
        }
        .share(replay: 1, scope: .forever)
        
        _ = a.subscribe(onNext: { (num) in
            print("--1--\(num)")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        seq.onNext(1)
        seq.onNext(2)

        _ = a.subscribe(onNext: { (num) in
            print("--2--\(num)")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        seq.onNext(3)
        seq.onNext(4)
        
        _ = a.subscribe(onNext: { (num) in
            print("--3--\(num)")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        seq.onCompleted()
        
    }
}
