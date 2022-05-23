//
//  OpenVoteApp.swift
//  OpenVote
//
//  Created by 90310148 on 3/17/22.
//
//Once the main activity screen is figured out; reiterate, make it better than work on the animations tutorial and go to that screen


import SwiftUI

@main
struct OpenVoteApp: App {
    @StateObject var envObj = GlobalVariables()
    
    
    var body: some Scene {
        WindowGroup {
            if envObj.tutorialSkipped{
                ActivityView()
                    .environmentObject(envObj)
                    
            }else{
                AnimationView()
                .environmentObject(envObj)
            }
            
            //firstPage()
           // AnimationView()
           // .environmentObject(envObj)
          
           
           

          
        }
    }
}
