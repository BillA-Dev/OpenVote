//
//  ContentView.swift
//  OpenVote
//
//  Created by 90310148 on 3/17/22.
//

import SwiftUI
struct ContentView: View {
    //Add colors to asset
    //
    @State var indexSelection: Int = 0
    @EnvironmentObject var index: GlobalVariables
    var body: some View {
        VStack{
            TabView(selection: $index.indexClicked){
                firstPage().tag(0)
                secondScreen().tag(1)
                thirdScreen().tag(2)
                fourthScreen().tag(3)
                //secondScreen().tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .onChange(of: index.indexClicked){ x in
            print("Changed \(x)")
        }
    }
}









extension UserDefaults{
    enum Keys: String, CaseIterable{
        case hasDoneTut, privateUserName, tutSkipped2
    }
    func delete(){
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue)}
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
