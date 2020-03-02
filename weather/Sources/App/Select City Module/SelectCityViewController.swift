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

        navigationBarCustom()

        elementCustom()

        bind(to: viewModel)
        viewModel.viewDidLoad()
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

    @IBAction func didPresCityTextField(_ sender: Any) {
    }

    @IBAction func didPressCountryTextField(_ sender: Any) {

    }

    @IBAction func didPressAddButton(_ sender: Any) {
        guard let city = cityTextField.text else { return }
        guard let country = countryTextField.text else { return }
        viewModel.didSelectCity(nameCity: city, country: country)
    }

    // MARK: - Private Files

    func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.alpha = 0.0
    }

    func elementCustom() {
        //        cityButtons.forEach {
        //            $0?.layer.borderWidth = 1
        //            $0?.layer.borderColor = UIColor.white.cgColor
        //            $0?.layer.cornerRadius = 15
        //        }
    }
}
