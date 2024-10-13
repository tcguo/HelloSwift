//
//  LLStackScrollViewController.swift
//  HelloSwift
//
//  Created by gtc on 2023/10/19.
//

import UIKit

class LLStackScrollViewController: TCBaseViewController {

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    lazy var contentView = UIView()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.frame = view.bounds
        
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalTo(view.bounds.size.width)
//        }
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(view.bounds.size.width)
        }
        
        for i in 0...10 {
            let view = UIView()
            if i%2 == 0 {
                view.backgroundColor = .red
            } else {
                view.backgroundColor = .blue
            }
            stackView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.height.equalTo(150)
            }
        }
    }

}
