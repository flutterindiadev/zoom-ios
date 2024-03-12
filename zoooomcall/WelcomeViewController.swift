//
//  ViewController.swift
//  zoooomcall
//
//  Created by Neosoft on 11/03/24.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    override func loadView() {
        let view = WelcomeView()
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
    }
    

    private func showAccount(){
        let vc = UINavigationController(rootViewController: AccountViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func didTapSignIn(email: String?, password: String?) {
        guard let email, let password else{
            let alert = UIAlertController(title: "Invalid Entry", message: "Please proide valid email/password.", preferredStyle: .alert)
            alert.addAction(.init(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
                AuthManager.shared.signIn(email: email, password: password) { [weak self] done in
                    guard done else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.showAccount()
                    }
                }
        
    }
    
    func didTapSignUp(email: String?, password: String?) {
        guard let email, let password else{
            let alert = UIAlertController(title: "Invalid Entry", message: "Please proide valid email/password.", preferredStyle: .alert)
            alert.addAction(.init(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
                AuthManager.shared.signUp(email: email, password: password) { [weak self] done in
                    guard done else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.showAccount()
                    }
                }
    }
}

