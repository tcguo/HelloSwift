//
//  LoginView.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/4.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import NSObject_Rx

class LoginView: UIView {
    
    var viewModel: LoginViewModel!
    var bag: DisposeBag = DisposeBag()
    private var nameField: UITextField = {
        let field = UITextField()
        field.adjustsFontSizeToFitWidth = true
        field.font = .systemFont(ofSize: 15)
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.masksToBounds = true
        return field
    }()
    
    private var btnLogin: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.backgroundColor = .gray
        return btn
    }()
    
    init(frame: CGRect, viewModel: LoginViewModel) {
        super.init(frame: frame)
        setupUI()
        self.viewModel = viewModel
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        // 双向绑定
        self.viewModel.nameChangeDisplay.asObservable().bind(to: nameField.rx.text).disposed(by: rx.disposeBag)
        nameField.rx.text.asObservable().bind(to: viewModel.nameChangeDisplay).disposed(by: bag)
        
        btnLogin.rx.tap.bind(to: viewModel.loginClickRelay).disposed(by: rx.disposeBag)
    }
    
    func setupUI() {
        addSubview(nameField)
        addSubview(btnLogin)
        nameField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        btnLogin.snp.makeConstraints { (make) in
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
    }
    
}

