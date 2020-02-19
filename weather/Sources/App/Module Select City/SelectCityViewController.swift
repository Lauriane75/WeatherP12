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
    
    @IBOutlet weak var parisButton: UIButton!

    @IBOutlet weak var lyonButton: UIButton!

    @IBOutlet weak var nantesButton: UIButton!
    
    @IBOutlet weak var barcelonaButton: UIButton!

    @IBOutlet weak var warsawButton: UIButton!

    @IBOutlet weak var amsterdamButton: UIButton!

    @IBOutlet weak var brusselsButton: UIButton!

    @IBOutlet weak var lausanneButton: UIButton!

    @IBOutlet weak var telAvivButton: UIButton!

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

        viewModel.parisText = { [weak self] text in
            self?.parisButton.setTitle(text, for: .normal)
        }

        viewModel.lyonText = { [weak self] text in
            self?.lyonButton.setTitle(text, for: .normal)
        }

        viewModel.nantesText = { [weak self] text in
            self?.nantesButton.setTitle(text, for: .normal)
        }

        viewModel.barcelonaText = { [weak self] text in
            self?.barcelonaButton.setTitle(text, for: .normal)
        }

        viewModel.warsawText = { [weak self] text in
            self?.warsawButton.setTitle(text, for: .normal)
        }

        viewModel.brusselsText = { [weak self] text in
            self?.brusselsButton.setTitle(text, for: .normal)
        }

        viewModel.lausanneText = { [weak self] text in
            self?.lausanneButton.setTitle(text, for: .normal)
        }

        viewModel.telAvivText = { [weak self] text in
            self?.telAvivButton.setTitle(text, for: .normal)
        }
    }
    
    // MARK: - Private Files
    
    func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.alpha = 0.0
    }
    
    func elementCustom() {
        let cityButtons = [parisButton,
                           lyonButton,
                           nantesButton,
                           barcelonaButton,
                           warsawButton,
                           amsterdamButton,
                           brusselsButton,
                           lausanneButton,
                           telAvivButton]

        cityButtons.forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 15
        }
    }
}
