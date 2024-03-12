//
//  AuthManager.swift
//  zoooomcall
//
//  Created by Neosoft on 11/03/24.
//

import Foundation
import FirebaseAuth

class AuthManager{
    static let shared = AuthManager()
    
    var isSignedIn : Bool{
        return Auth.auth().currentUser != nil
    }
    
    func signIn(email : String, password:String, completion: @escaping(Bool)->Void){
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            if result == nil, error != nil {
                completion(false)
            }
            CallManager.shared.setUp(email: email)
            completion(true)
        }
    }
    func signUp(email : String, password:String, completion: @escaping(Bool)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                CallManager.shared.setUp(email: email)
            }
            completion(error == nil)
            
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
    }
}
