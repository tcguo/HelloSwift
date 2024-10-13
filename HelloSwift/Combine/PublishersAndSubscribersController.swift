//
//  PublishersAndSubscribersControllerViewController.swift
//  HelloSwift
//
//  Created by Darius.G on 2022/12/28.
//

import UIKit
import Combine

class HomePublisherViewModel {
    let loginPublisher = Just("abc")
    let titleChangeSubject = PassthroughSubject<String, Never>()
}

class PublishersAndSubscribersController: TCBaseViewController {
    var viewModel = HomePublisherViewModel()

    lazy var titleLabel: UILabel = UILabel(text: "title-001");

    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleLabel?.font = UIFont.pfMedium(size: 22)
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        titleLabel.font = .systemFont(ofSize: 16)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(150)
            make.height.equalTo(30)
        }

        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12.adp())
            make.centerX.equalToSuperview()
            make.width.equalTo(100.adp())
            make.height.equalTo(60.adp())
        }

        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)

        viewModel.loginPublisher.sink { val in
            print("val =" + val)
        }

        viewModel.loginPublisher.sink { val2 in
            print("val2 =" + val2)
        }
        let subscription = viewModel.titleChangeSubject.sink { val in
            self.titleLabel.text = val
        }

        viewModel.titleChangeSubject.send("222")
        viewModel.titleChangeSubject.send("3333")
        let myscripter = Subscribers.Sink<String, Never> { complete in
            if complete == .finished {
                print("completed")
            } else {

            }
        } receiveValue: { val in
            self.titleLabel.text = val
        }

        viewModel.titleChangeSubject.subscribe(myscripter)
        viewModel.titleChangeSubject.subscribe(Subscribers.Sink(receiveCompletion: { com in

        }, receiveValue: { val in
            self.titleLabel.text = "ddd-"+val
        }))
    }

    @objc func loginClick() {
        viewModel.titleChangeSubject.send("1212")
    }
}
