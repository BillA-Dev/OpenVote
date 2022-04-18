//
//  HomeScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI

//https://blckbirds.com/post/charts-in-swiftui-part-1-bar-chart/


struct HomeScreen: View {
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Colors.DarkPurple, secondGradientColor: Colors.BorderBlue, textColor: Color.white, legendTextColor: Color.white, dropShadowColor: Color.white )
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
