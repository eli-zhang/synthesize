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
    let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mainColor
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
