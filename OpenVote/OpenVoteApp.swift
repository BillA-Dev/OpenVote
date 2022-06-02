//
//  OpenVoteApp.swift
//  OpenVote
//
//  Created by 90310148 on 3/17/22.
//
//Once the main activity screen is figured out; reiterate, make it better than work on the animations tutorial and go to that screen


import SwiftUI
import Network



@main
struct OpenVoteApp: App {
    @StateObject var envObj = GlobalVariables()
    let monitor = NWPathMonitor()
    @State var isConnected: Bool = false
    
       
    
  
    
    
    var body: some Scene {
        WindowGroup {
            
            if isConnected{

            if envObj.tutorialSkipped{
                ActivityView()
                    .environmentObject(envObj)

            }else{
                AnimationView()
                .environmentObject(envObj)
            }

            }else{
                Text("Please connect to internet").onAppear {
                    monitor.pathUpdateHandler = { [self] path in
                        if path.status == .satisfied {
                            isConnected = true
                        } else {
                            isConnected = false
                        }


                    }
                    let queue = DispatchQueue(label: "Monitor")
                    monitor.start(queue: queue)
                }
            }

         // testRedaction()
            
           //testCarasel()
          
           
           

          
        }
    }
}
