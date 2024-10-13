//
//  RxStudyIndexController.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/1.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import NSObject_Rx
import NSObject_Rx.Swift
import SnapKit

public class Person {
    static let name: String = "12"
    public var sex: Int = 0
}

public enum Week: String {
    static var name: String = "132"
    case Mondeay
    case Tuesday
}


class RxStudyIndexController: TCBaseViewController {

    // MARK: - Property
    var timer: Timer?
    var label: UILabel!
    var me: Person?
    var bottomView: UIView!
    var loginView: LoginView!
    
    lazy var buttonBinder: Binder<String> = Binder(self) { (viewModel, str) in
        print(str)
    }
    
    lazy var bind: BehaviorRelay<String> = BehaviorRelay(value: "212")
    
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.ColorBABABA
        title = mytitle ?? "Rx"
        
        let loginViewModel = LoginViewModel()
        loginView = LoginView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 200), viewModel: loginViewModel)
        view.addSubview(loginView)
        
            
        view.addSubview(self.topView)
        topView.frame = CGRect(x: 0, y: 88, width: kScreenWidth, height: 50)
//
//
//        print("p1 = \(Week.name), p2 = \(Person.name)")
//
//        // Notification
//        NotificationCenter.default.addObserver(self, selector: #selector(login), name:NotificationDefine.LoginSuccess.notifactionName() , object: nil)
        
        view.addSubview(loginBtn)
        
        // target - action
        
//        self.loginBtn.addTarget(self, action: #selector(login2), for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(12.adp())
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100.adp())
            make.height.equalTo(60.adp())
        }
        
//        loginBtn.rx.tap.map{ "12" }.bind(to: buttonBinder).disposed(by: rx.disposeBag)
        loginBtn.rx.tap.map { "12" }.bind(to: loginViewModel.loginClickRelay)
        
        // Delegate
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: self.view.bounds.width, height: 200))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 250)
        scrollView.rx.contentOffset.subscribe { (offset) in
            print("offset= \(offset)")
        }.disposed(by: rx.disposeBag)
        
        scrollView.backgroundColor = UIColor.orange
        
        bottomView = UIView()
        bottomView.backgroundColor = .red
        view.addSubview(bottomView);
        bottomView.snp.makeConstraints { make in
            
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerX.equalToSuperview()
        }
        
        // Tap
        let tap = UITapGestureRecognizer()
        bottomView.addGestureRecognizer(tap)
        tap.rx.event.subscribe { (event) in
            print("tap点中了")
        }.disposed(by: rx.disposeBag)
        
        // KVO
        
        
        self.rxBinder()
        
        
        
        
//        self.crateObservable()
//        self.createObserver()
        
    }
    
    func login3() -> Void {
        print("login3")
    }
    
    @objc func login(_ sender: Any) -> Void {
        
    }
    
    @objc func login2() {
        
    }
    
    
    func rxBinder()  {
        let textfield =  UITextField();
        view.addSubview(textfield)
        textfield.backgroundColor = .red
        textfield.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 100, height: 40));
            make.left.equalToSuperview().offset(20)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "texttext"
        titleLabel.font = UIFont.pfRegular(size: 22)
        titleLabel.textColor = .yellow
        titleLabel.backgroundColor = .gray
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textfield.snp.bottom).offset(10)
            make.height.equalTo(30);
            make.left.equalTo(textfield)
        }
        
        textfield.rx.text.orEmpty.changed.subscribe { (text) in
            print("text=\(text)")
        }.disposed(by: rx.disposeBag)

        textfield.rx.text.bind(to: titleLabel.rx.text).disposed(by: rx.disposeBag)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationDefine.LoginSuccess.notifactionName(), object: nil)
    }
    
    
    
    //:MARK -  Lazy
    var mytitle: String?;
    lazy var topView: UIView = {
        let topview = UIView()
        topview.backgroundColor = .yellow
        return topview
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.textColor = .red
        btn.titleLabel?.font = UIFont.pfMedium(size: 22)
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.masksToBounds = true
        return btn
    }()
    
    

}
