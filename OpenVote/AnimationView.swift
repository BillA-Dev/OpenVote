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
    
    @EnvironmentObject var globalVar: GlobalVariables
    
    
    
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
                            let _ = DispatchQueue.main.asyncAfter(deadline: .now() + (0.5 + 1.8)){
                                opacity = 1.0
                                logoopacity = 1.0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                                    //IF ALREADY CLICKED IS NOT PRESENTED SKIP
                                    let checked = UserDefaults.standard.bool(forKey: "tutSkipped2")
                                    
                                    if checked{
                                        globalVar.tutorialSkipped = true
                                        //isNotPresented = true
                                    }else{
                                        isNotPresented = true
                                    }
                                    
                                }
                               
                                
                            }
                            
                            
                            
                            
                        }.animation(.easeInOut(duration: 1.8), value: startingOffset)
                        .animation(.easeInOut(duration: 0.9), value: opacity)
                       
                    
                    
                }
                //Lightmode logo
                
                Image("logo").padding().opacity(logoopacity).animation(.easeInOut(duration: 0.9), value: logoopacity)
            }
            
            
            //Change this to true when done
            
            /*
             .sheet(isPresented: $isNotPresented, onDismiss: nil){
             */
        }.sheet(isPresented: $isNotPresented, onDismiss: nil){
            ContentView() //Tutorial View
                .interactiveDismissDisabled(true)
        }
        .onAppear {
            
            DispatchQueue.main.async {
                //This runs API
                globalVar.independentExpend()
                globalVar.getLegislators()
                
            }
        }
        
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
            .previewDevice("iPhone 11")
    }
}
