//
//  testRedaction.swift
//  OpenVote
//
//  Created by 90310148 on 5/27/22.
//

import SwiftUI


struct customRedaction<Content: View>: View{
    
    let content: Content
    
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1.2, y: 0)
    
    
    @State var isAnimating = true
    
    
    var isDone: Binding<Bool>
    
    init(isApiDoneLoading: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        isDone = isApiDoneLoading
        
        
    }
    
    var body: some View {
        
        if isDone.wrappedValue{
        ZStack{
            content.redacted(reason: .placeholder)
            
            LinearGradient(colors: [Color(hexString: "d7d7d7"), Color.black], startPoint: startPoint, endPoint: endPoint).blendMode(.screen)
                .onAppear {
                    
                    withAnimation(Animation.linear(duration: 1.4).repeatForever(autoreverses: true)) {
                        startPoint.x = 1
                        
                        
                    }
                    
                    
                    
                }
        }
        }else{
          content
        }
            
        
        
        
        
    }
}


struct customRedactionTwo<Content: View>: View{
    
    let content: Content
    
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 1.2, y: 0)
    
    
    @State var isAnimating = true
   
    
    
    @State var offset: Int = -500
    var isDone: Binding<Bool>
    
    init(isApiDoneLoading: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.content = content()
        isDone = isApiDoneLoading
        
        //CUSTOM  - DO WE REALLY NEED A CUSTOM ONE; I DONT KNOW. 
    }
    
    var body: some View {
        
        if isDone.wrappedValue{
        ZStack{
            content.redacted(reason: .placeholder)
            
            LinearGradient(colors: [Color.black, Color(hexString: "e8e8e8"), Color.black], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0.5, y: 0)).blendMode(.screen).offset(x:CGFloat(offset))
                .onAppear {
                    
                    withAnimation(Animation.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                        startPoint.x = 1
                        offset = 500
                        
                        
                    }
                    
                    
                    
                }
        }
        }else{
          content
        }
            
        
        
        
        
    }
}

extension View{
    func skeletonLoading(isLoadingDone: Binding<Bool> = Binding.constant(true)) -> some View{
        return customRedaction(isApiDoneLoading: isLoadingDone){
            self
        }
    }
    
    func startToEndSkeletenLoading(isLoadingDone: Binding<Bool> = Binding.constant(true)) -> some View{
        return customRedactionTwo(isApiDoneLoading: isLoadingDone) {
            self
        }
    }
}
struct testRedaction: View {
    var body: some View {
        VStack{
            
            
            Text("Skeleton Loading Display").font(.largeTitle).padding()
            
            Text("AutoReverse Skeleton Loading").padding()
            VStack{
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }.padding().skeletonLoading()
            
            Text("Generic Skeleton Loading").padding()
           
                
                VStack{
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    
                }.padding().startToEndSkeletenLoading()
                
            
        }
    }
}

struct testRedaction_Previews: PreviewProvider {
    static var previews: some View {
        testRedaction()
    }
}
