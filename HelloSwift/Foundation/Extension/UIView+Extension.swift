//
//  UIView+Extension.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import UIKit
import SwifterSwift

extension AQWrapper where Base: UIView {
    
    // aq.addImage(image)
    func addImage(image: UIImage) {
        let imgView = UIImageView()
        imgView.image = image
        base.addSubview(imgView)
    }
    
    // aq.addSubviews([view1, view2, ...])
    func addSubviews(_ views: [UIView]) {
        base.addSubviews(views)
    }

    // aq.addSubviews(view1, view2, ...)
    func addSubviews(_ views: UIView...) {
        base.addSubviews(views)
    }
    
}
