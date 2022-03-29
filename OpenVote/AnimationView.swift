//
//  AnimationView.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import SwiftUI

struct AnimationView: View {
    @State var startingOffset = UIScreen.main.bounds.width
    @State var opacity: Double = 0.0
    @State var logoopacity: Double = 0.0
    
    @State var isNotPresented: Bool = false
    
    var body: some View {
       
        ZStack{
            VStack{
                HStack{
                    
                    Image("midLine")
                        .opacity(opacity)
                        .overlay{
                            //Has to go to -(35)
                            //35
                            //                    Image("Circle").offset(x: 35, y: 0)
                            //                    Image("Circle").offset(x: -35, y: 0)
                            
                            
                            Image("Circle").offset(x: startingOffset, y: 0)
                            Image("Circle").offset(x: -startingOffset, y: 0)
                            
                            let _ = DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                startingOffset = 35
                            }
                            let _ = DispatchQueue.main.asyncAfter(deadline: .now() + (0.5 + 1.5)){
                                opacity = 1.0
                                logoopacity = 1.0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                                    isNotPresented = true
                                }
                               
                                
                            }
                            
                            
                            
                            
                        }.animation(.easeIn(duration: 1.5), value: startingOffset)
                        .animation(.easeIn(duration: 0.6), value: opacity)
                       
                    
                    
                }
                //Lightmode logo
                
                Image("logo").padding().opacity(logoopacity).animation(.easeIn(duration: 0.9), value: logoopacity)
            }
        }.sheet(isPresented: $isNotPresented, onDismiss: nil){
            ContentView() //Tutorial View
                .interactiveDismissDisabled(true)
        }
        
        
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
            .previewDevice("iPhone 11")
    }
}
