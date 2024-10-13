//
//  UIView+RX.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import AssociatedValues
import MBProgressHUD
import NVActivityIndicatorView
import PinLayout

extension Reactive where Base: UIView {
    
    var showLoading: Binder<Bool> {
        return Binder(base) { view, showLoading in
            if showLoading {
                aqLoadingView.startAnimating()
            } else {
                aqLoadingView.stopAnimating()
            }
        }
    }
    
    var hideLoadingWithoutAni: Binder<Bool> {
        return Binder(base) { _, _ in
            aqLoadingView.stopAnimating()
        }
    }
    
    var showToast: Binder<String> {
        let binder: Binder<String> = Binder(base) { view, text in
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .text
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 1)
        }
        return binder
    }
    
    private(set) var aqLoadingView: NVActivityIndicatorView {
        get {
            let indicator: NVActivityIndicatorView = getAssociatedValue(key: "aqLoadingView", object: base) {
                let view = NVActivityIndicatorView(frame: .zero)
                view.type = .lineSpinFadeLoader
                base.addSubview(view)
                return view
            }
            indicator.pin.center().size(CGSize(width: 60, height: 60))
            return indicator
        }
        set {
            set(associatedValue: newValue, key: "aqLoadingView", object: base)
        }
    }
    
}


extension AQWrapper where Base: NSObject {
    func showToast(toast: String, view: UIView = UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first!) {
        Observable.just(toast).bind(to: view.rx.showToast).disposed(by: base.rx.disposeBag)
    }
    
    func showLoading(view: UIView = UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first!) {
        // just 操作符将某一个元素转换为 Observable。
        Observable.just(true).bind(to: view.rx.showLoading).disposed(by: base.rx.disposeBag)
    }
    
    func hideLoading(view: UIView = UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first!) {
        Observable.just(false).bind(to: view.rx.showLoading).disposed(by: base.rx.disposeBag)
    }
}
