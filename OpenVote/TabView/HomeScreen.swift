//
//  HomeScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI



struct rectangle: View{
    var color: Color
    var body: some View{
        Rectangle().frame(height: 200).padding().foregroundColor(color)
    }
}
struct HomeScreen: View {
    @State var selection: Int = 0
    
    @State var color = [Color.red, Color.blue, Color.orange, Color.black, Color.gray, Color.green]
    var body: some View {
        TabView(selection: $selection){
            ForEach(0...5, id:\.self){ x in
                
                rectangle(color: color[x]).tag(x)
            }
            
            
        }.tabViewStyle(PageTabViewStyle())
            .onAppear {
               
                //Schedule Timer
                 
                Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { Timer in
                    withAnimation(Animation.easeIn(duration: 4.0)){
                        
                        if selection == 2{
                            selection = 0
                        }else{
                            selection += 1
                        }
                        Timer.tolerance = 0.2
                    //print(selection)
                    }
                }
                    
                    
                    
                    
                
            }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
