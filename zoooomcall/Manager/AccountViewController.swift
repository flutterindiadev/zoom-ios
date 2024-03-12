//
//  AccountViewController.swift
//  zoooomcall
//
//  Created by Neosoft on 11/03/24.
//

import UIKit
import Combine
import StreamVideo
import StreamVideoSwiftUI
import StreamVideoUIKit

class AccountViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    private var activeCallview:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account"
        view.backgroundColor = .systemGreen
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Join Call", style: .done, target: self, action: #selector(joinCall))
    }
    
    @objc private func signOut(){
        let alert = UIAlertController(title: "Sign out", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        alert.addAction(.init(title: "Sign out", style: .destructive) { _ in
            AuthManager.shared.signOut()
            let vc = UINavigationController(rootViewController: WelcomeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
        present(alert, animated: true)
        
        
    }
    
    @objc private func joinCall(){
        guard let callviewModel = CallManager.shared.callViewModel else {return}
        callviewModel.joinCall(callType: .default, callId: "default_c3b5eb3b-665d-4e79-9264-38515cf024db")
        
        showCallUI()
    }
    
    private func listenForIncomingCalls(){
        guard let callviewModel = CallManager.shared.callViewModel else {return}
        
        callviewModel.$callingState.sink{[weak self] newState in
            switch newState {
            case .incoming (_):
                DispatchQueue.main.async {
                    self?.showCallUI()
                }
            case .idle:
                DispatchQueue.main.async {
                    self?.hideCallUI()
                }
            default:
                break
                
            
                
            }
        }
            .store(in: &cancellables)
    }

    private func showCallUI(){
        guard let callviewModel = CallManager.shared.callViewModel else {return}
        let callVC = CallViewController.make(with: callviewModel)
        view.addSubview(callVC.view)
        
        callVC.view.bounds = view.bounds
        activeCallview = callVC.view
    }
    
    private func hideCallUI(){
        activeCallview?.removeFromSuperview()
    }

}
