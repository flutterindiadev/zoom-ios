//
//  CallManager.swift
//  zoooomcall
//
//  Created by Neosoft on 11/03/24.
//

import Foundation
import StreamVideo
import StreamVideoSwiftUI
import StreamVideoUIKit


class CallManager{
    static let shared = CallManager()
    
    struct Constants{
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRGFydGhfQmFuZSIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvRGFydGhfQmFuZSIsImlhdCI6MTcxMDE1MjUwMywiZXhwIjoxNzEwNzU3MzA4fQ.uxnDML90GQb296c_NSfCCxMeZyjAoyWuj2b04Cjd7i4"
    }
    
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var callViewModel: CallViewModel?
    
    struct UserCredentials{
        let user: User
        let token : UserToken
    }
    
    func setUp(email: String){
        setupCallViewModel()
        
        let credential = UserCredentials(user: .guest(email), token: UserToken(rawValue: Constants.userToken))
        
        let video = StreamVideo(apiKey: "7jmnv7x8yuhv", user: credential.user, token: credential.token){
            result in result(.success(credential.token))
        }
        let videoUI = StreamVideoUI(streamVideo: video)
        
        self.video = video
        self.videoUI = videoUI
        
    }
    
    private func setupCallViewModel(){
        guard callViewModel == nil else {return}
        DispatchQueue.main.async {
            self.callViewModel = CallViewModel()
        }
        
    }
    }
    
    

