//
//  progressCircle.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import SwiftUI

struct progressCircle: View {
    
    @State var color: Color
    init(enterColor c: Color){
        color = c
    }
    var body: some View{
        Circle().frame(width: 15, height: 15).foregroundColor(color).padding(8)
    }
    
}

struct progressCircle_Previews: PreviewProvider {
    static var previews: some View {
        progressCircle(enterColor: Color.blue)
    }
}
