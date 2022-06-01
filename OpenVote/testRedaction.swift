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
    @State var gradient = LinearGradient(gradient: Gradient(colors: [Color.black, Color.red]), startPoint: .leading, endPoint: .trailing)
    
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

extension View{
    func skeletonLoading(isLoadingDone: Binding<Bool> = Binding.constant(true)) -> some View{
        return customRedaction(isApiDoneLoading: isLoadingDone){
            self
        }
    }
}
struct testRedaction: View {
    var body: some View {
        VStack{
            
            
            Text("Skeleton Loading Display").font(.largeTitle).padding()
            
            Text("Without Skeleten Loading").padding()
            VStack{
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }.padding()
            
            Text("With Skeleton Loading").padding()
           
                
                VStack{
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    
                }.padding().skeletonLoading()
                
            
        }
    }
}

struct testRedaction_Previews: PreviewProvider {
    static var previews: some View {
        testRedaction()
    }
}
