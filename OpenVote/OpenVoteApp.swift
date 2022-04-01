//
//  OpenVoteApp.swift
//  OpenVote
//
//  Created by 90310148 on 3/17/22.
//

import SwiftUI

@main
struct OpenVoteApp: App {
    @StateObject var envObj = GlobalVariables()
    var body: some Scene {
        WindowGroup {
            //ContentView().environmentObject(envObj)
            AnimationView()
              .environmentObject(envObj)
            //ActivityView()
        }
    }
}
