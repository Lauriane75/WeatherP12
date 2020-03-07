//
//  SelectCityViewController.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    // MARK: - Properties

    var viewModel: SelectCityViewModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)

        navigationBarCustom()

        elementCustom()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    deinit {
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
     }

    // MARK: - Private Functions

    private func bind(to viewModel: SelectCityViewModel) {
        viewModel.titleText = { [weak self] text in
            self?.titleLabel.text = text
        }
        viewModel.cityText = { [weak self] text in
            self?.cityLabel.text = text
        }
        viewModel.cityPlaceHolder = { [weak self] text in
        self?.cityTextField.placeholder = text
        }
        viewModel.countryText = { [weak self] text in
            self?.countryLabel.text = text
        }
        viewModel.countryPlaceHolder = { [weak self] text in
            self?.countryTextField.placeholder = text
        }
        viewModel.addText = { [weak self] text in
            self?.addButton.setTitle(text, for: .normal)
        }
    }

    // MARK: - View actions

    @IBAction func didPressAddButton(_ sender: Any) {
        guard let city = cityTextField.text?.lowercased() else { return }
        print(city)
        guard let country = countryTextField.text?.lowercased() else { return }
        print(country)
        viewModel.didPressAddCity(nameCity: city, country: country)
    }

    // MARK: - Private Files

    func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.alpha = 0.0
    }

    func elementCustom() {
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.cornerRadius = 15
        cityTextField.layer.cornerRadius = 15
        countryTextField.layer.cornerRadius = 15
    }

    /// HideKeyBoard from textField
    @objc private func hideKeyBoard() {
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        addButton.resignFirstResponder()
    }

    fileprivate func settingNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillChange(notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height

        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -(keyboardHeight/2)
        } else {
            view.frame.origin.y = 0
        }
    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyBoard()
        return true
    }
}
