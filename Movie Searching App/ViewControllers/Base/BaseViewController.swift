//
//  BaseViewController.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 20.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default);
            navigationBar.shadowImage = UIImage();
            navigationBar.tintColor = UIColor.black;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HideNavigationBar(true);
        AddNotificationsForKeyboard();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    public func HideNavigationBar(_ isHidden: Bool) {
        self.navigationController?.navigationBar.isHidden = isHidden;
    }
    
    func AddNotificationsForKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: Target Actions
    
    @objc final func KeyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            KeyBoardIsShown(keyboardHeight: keyboardHeight)
        }
    }
    
    @objc final func KeyboardWillHide(_ notification: Notification) {
        KeyBoardIsHidden()
    }
    
    // Methods to be overriden when viewcontroller has TextFields
    public func KeyBoardIsShown(keyboardHeight: CGFloat) {}
    public func KeyBoardIsHidden() {}
}
