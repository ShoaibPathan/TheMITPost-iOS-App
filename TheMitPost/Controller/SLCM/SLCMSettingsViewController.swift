//
//  SLCMSettingsViewController.swift
//  TheMitPost
//
//  Created by Harshavardhan K on 26/09/19.
//  Copyright © 2019 Harshavardhan K. All rights reserved.
//

import UIKit

import Lottie
import NotificationBannerSwift
import Locksmith

class SLCMSettingsViewController: UIViewController {
    
    
    @IBOutlet var settingLabel: UILabel!
    @IBOutlet var biometricTypeLabel: UILabel!
    @IBOutlet weak var biometricSwitch: UISwitch!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet var lottieSettingsView: AnimationView!
    
    @IBOutlet var biometricLottieView: AnimationView!
    @IBOutlet var jumboLottieView: AnimationView!
    
    @IBOutlet weak var topThingView: UIView!
    
    var biometricLabel: UILabel?
    
    @IBAction func biometricSwitchAction(_ sender: UISwitch) {
        
        if sender.isOn {
            print("Switch on")
            UserDefaults.standard.set(true, forKey: "biometricEnabled")
            biometricLabel?.text = "Face ID Enabled"
            
        } else {
            UserDefaults.standard.set(false, forKey: "biometricEnabled")
            print("Switch off")
            biometricLabel?.text = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    //MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 20
        self.topThingView.layer.cornerRadius = 8
        
        mode()
        
        lottieSettingsView.play()
        biometricLottieView.play()
        jumboLottieView.play()
        
        if UserDefaults.standard.bool(forKey: "biometricEnabled") {
            biometricSwitch.setOn(true, animated: true)
            
        } else {
            biometricSwitch.setOn(false, animated: true)
        }
       
        guard let _ = UserDefaults.standard.string(forKey: DEFAULTS.REGISTRATION) else {
            logoutButton.isEnabled = false
            return
        }
        
        print("settings controller loaded")
        
        
        
    }
    
    //MARK: UI THEME
    func mode() {
        
        biometricTypeLabel.textColor = .secondaryLabel
        
        if traitCollection.userInterfaceStyle == .dark {
            
            view.backgroundColor = .background
            lottieSettingsView.backgroundColor = .background
            biometricLottieView.backgroundColor = .foreground
            jumboLottieView.backgroundColor = .background
            settingLabel.backgroundColor = .background
            biometricTypeLabel.backgroundColor = .foreground
            
        } else {
            
            view.backgroundColor = .white
            lottieSettingsView.backgroundColor = .white
            biometricLottieView.backgroundColor = .white
            jumboLottieView.backgroundColor = .white
            settingLabel.backgroundColor = .white
            biometricTypeLabel.backgroundColor = .white
            
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13, *) {
            mode()
        }
    }

}
