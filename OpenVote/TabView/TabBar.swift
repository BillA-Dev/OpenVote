//
//  TabBar.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI


struct itemOfTabBar: View{
    @EnvironmentObject var controller: mainController
    
    
    
    var imageName: String
    
    var page: pages
    
    init(imageName: String, page: pages){
        self.imageName = imageName
        self.page = page
    }
    var body: some View{
        HStack{
            Spacer()
            Button(action:{
                controller.currentPage = page
            }){
                
                
                
                Rectangle().frame(width: 50, height: 50).foregroundColor(controller.currentPage == page ? Color(red: 223/255, green: 82/255, blue: 82/255) : Color(red: 32/255, green: 39/255, blue: 75/255)).cornerRadius(8).overlay{
                    
                    Image(imageName).resizable().aspectRatio(contentMode: .fit).offset(x: imageName == "homepage" ? 1 : 0).padding(7)
                    //The homepage is wierd
                }
                
            }
            Spacer()
        }
    }
}
struct tabBar: View{
    @State var color = Color(red: 248/255, green: 248/255, blue: 248/255)
    var body: some View{
        //Make thid dynamic
        
        HStack{
            //Fix the page selection
            itemOfTabBar(imageName: "homepage", page: .home).padding(.bottom).shadow(radius: 5)
            itemOfTabBar(imageName: "candidateview", page: .canView).padding(.bottom).shadow(radius: 5)
            itemOfTabBar(imageName: "graphview", page: .graphView).padding(.bottom).shadow(radius: 5)
            itemOfTabBar(imageName: "recentactivity", page: .activity).padding(.bottom).shadow(radius: 5)
            itemOfTabBar(imageName: "pacview", page: .PAC).padding(.bottom).shadow(radius: 5)
            
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/10).background(
            color
            
                .mask(RoundedRectangle(cornerRadius: 20).padding(.top, -8).foregroundColor(color)).background(
                    VStack(spacing: 0){
                        LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                            .opacity(0.8).blur(radius: 5).frame(height: UIScreen.main.bounds.height/10).mask(RoundedRectangle(cornerRadius: 20).padding(.top, -8)).offset(y: 6)
                    }
                )
        )
        
        
        /*
         background(
         
         //Shadow fix credits: https://stackoverflow.com/questions/68765679/swiftui-how-to-show-shadow-only-on-top-side
         Color.gray
         .shadow(color: Color.black, radius: 2, x: 0, y: 0)
         .mask(Rectangle().padding(.top, -20))
         )
         */
        
    }
}
