//
//  UIView + Extension.swift
//  holidayNow
//
//  Created by Евгений on 01.09.2023.
//

import UIKit

extension UIViewController {
    func setupViews(_ view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
