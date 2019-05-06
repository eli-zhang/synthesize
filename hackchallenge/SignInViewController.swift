//
//  SignInViewController.swift
//  hackchallenge
//
//  Created by Michael Behrens on 5/5/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    var appNameLabel: UILabel!
    var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainColor
        GIDSignIn.sharedInstance().uiDelegate = self
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(dismissIfSignedIn), userInfo: nil, repeats: true)
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.signInSilently()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupViews() {
        appNameLabel = UILabel()
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        appNameLabel.textAlignment = .center
        appNameLabel.text = "Synthesize"
        appNameLabel.textColor = .white
        view.addSubview(appNameLabel)
        
        signInButton = GIDSignInButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.style = .wide
        signInButton.colorScheme = .light
        view.addSubview(signInButton)
        
    }
    
    @objc func dismissIfSignedIn() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.signInSilently()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            appNameLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 20),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
}
