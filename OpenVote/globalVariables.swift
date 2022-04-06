//
//  globalVariables.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import Foundation

class GlobalVariables: ObservableObject{
    @Published var indexClicked: Int = 0
    @Published var searchText: String = ""
    @Published var nameArr: [String] = []
    @Published var filteredNameArr: [String] = []
    
    
    @Published var tutorialSkipped: Bool = false
}
