//
//  UIView+iDo.swift
//  Extend some functions or others for class UIView
//
//  Created by admin on 2019/6/6.
//  Copyright © 2019 Conjur. All rights reserved.
//

import UIKit


//MARK: - Properties
public extension UIView {
    
    /// Get controller
    var controller: UIViewController? {
        get {
            if next is UIViewController {
                return next as? UIViewController
            }
            if next is UIView {
                return (next as? UIView)?.controller
            }
            return nil
        }
    }

    /// A convenience property to set corner radius
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

//MARK: - Constraints
public extension UIView {

    /// Filled to superview with constants
    ///
    /// @constants: The values of top/leading/bottom/trailing constant
    func filled(with constants: CGFloat...) {
        if superview == nil {
            print("The current view must be added to a view before constrained.")
            return
        }
        top(to: superview!, constant: constants.count >= 1 ? constants[0] : 0)
        leading(to: superview!, constant: constants.count >= 2 ? constants[1] : 0)
        trailing(to: superview!, constant:  constants.count >= 3 ? constants[2] : 0)
        bottom(to: superview!, constant:  constants.count >= 4 ? constants[3] : 0)
    }

    /// 顶部约束
    ///
    /// @aView: 顶部约束参考视图, 若为superview则top相对top做约束，否则是相对bottom做约束
    /// @constant: 约束值，默认0
    func top(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if aView == superview {
            topAnchor.constraint(equalTo: aView.topAnchor, constant: constant).isActive = true
        } else {
            topAnchor.constraint(equalTo: aView.bottomAnchor, constant: constant).isActive = true
        }
    }

    /// 左边/头部约束
    ///
    /// @aView: 约束参考视图, 若为superview则leading相对leading做约束，否则是相对trailing做约束
    /// @constant: 约束值，默认0
    func leading(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if aView == superview {
            leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: constant).isActive = true
        } else {
            leadingAnchor.constraint(equalTo: aView.trailingAnchor, constant: constant).isActive = true
        }
    }

    /// 底部约束
    ///
    /// @aView: 约束参考视图, 若为superview则bottom相对bottom做约束，否则是相对top做约束
    /// @constant: 约束值，默认0
    func bottom(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if aView == superview {
            bottomAnchor.constraint(equalTo: aView.bottomAnchor, constant: constant).isActive = true
        } else {
            bottomAnchor.constraint(equalTo: aView.topAnchor, constant: constant).isActive = true
        }
    }

    /// 右边/尾部约束
    ///
    /// @aView: 约束参考视图, 若为superview则trailing相对trailing做约束，否则是相对leading做约束
    /// @constant: 约束值，默认0
    func trailing(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if aView == superview {
            trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: constant).isActive = true
        } else {
            trailingAnchor.constraint(equalTo: aView.leadingAnchor, constant: constant).isActive = true
        }
    }

    /// 宽度约束
    ///
    /// @aView: 宽度与该视图一直
    /// @constant: 宽度约束, 默认0
    func width(equalTo aView: UIView? = nil, multiplier: CGFloat = 1, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let aView = aView {
            widthAnchor.constraint(equalTo: aView.widthAnchor, multiplier: multiplier, constant: constant).isActive = true
        } else {
            widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }

    /// 高度约束
    ///
    /// @aView: 高度与该视图一直
    /// @constant: 宽度约束, 默认0
    func height(equalTo aView: UIView? = nil, multiplier: CGFloat = 1, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let aView = aView {
            heightAnchor.constraint(equalTo: aView.heightAnchor, multiplier: multiplier, constant: constant).isActive = true
        } else {
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }

    /// 横向居中
    ///
    /// @aView: 参考视图
    /// @constant: 约束值，默认0
    func centerX(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: aView.centerXAnchor, constant: constant).isActive = true
    }

    /// 纵向居中
    ///
    /// @aView: 参考视图
    /// @constant: 约束值，默认0
    func centerY(to aView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: aView.centerYAnchor, constant: constant).isActive = true
    }
}

//MARK: - Camera & Album
public extension UIView {
    /// Open camera
    func openCamera(with delegate: IDOMediaImageDelegate?) {
        controller?.openCamera(with: delegate)
    }
    
    /// Open album
    func openAlbum(with delegate: IDOMediaImageDelegate?) {
        controller?.openAlbum(with: delegate)
    }
}

//MARK: - Alert
public extension UIView {
    /// Alert
    ///
    /// @title: The title
    /// @message: The message
    /// @options: The titles for other actions but exclude 'Cancel'
    func alert(with title: String? = nil,
               message: String?,
               options: [String]? = nil,
               handleAction: IDOAlertActionHandler? = nil)
    {
        controller?.alert(with: title, message: message, options: options, handleAction: handleAction)
    }
    
    /// Action Sheet
    ///
    /// @title: The title
    /// @message: The message
    /// @options: The titles for other actions but exclude 'Cancel'
    func actionSheet(with title: String? = nil,
                     message: String? = nil,
                     options: [String]? = nil,
                     handleAction: IDOAlertActionHandler? = nil)
    {
        controller?.actionSheet(with: title, message: message, options: options, handleAction: handleAction)
    }
}
