//
//  ActivityView.swift
//  OpenVote
//
//  Created by 90310148 on 4/1/22.
//

import SwiftUI
import UIKit

struct ActivityView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = .white
        
        
       
    }
    var body: some View {
        
        //Create my own tabView?
        TabView {
            homeScreenTest()
                .tabItem {
                    
                    
                    Image("home").padding(.top)
                    
                    
                    //                        Text("First Tab")
                    
                }
            Text("")
                .tabItem {
                    Image("person")
                }
            Text("")
                .tabItem {
                    Image("star")
                }
            Text("")
                .tabItem {
                    Image("setting")
                }
            Text("")
                .tabItem {
                    Image("other")
                }
            
            
        }.background(Color.white).shadow(color: Color.black, radius: 2).ignoresSafeArea()
    }
    
    struct ActivityView_Previews: PreviewProvider {
        static var previews: some View {
            ActivityView()
        }
    }
}


struct homeScreenTest: View{
    @State var color = Color(red: 248/255, green: 248/255, blue: 248/255)
    @State var text: String = ""
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        print("Does this work")
       
        
    }
    
    var body: some View {
        
        ZStack{
            color.ignoresSafeArea()
            VStack {
                
                
                Text("Activity").bold().padding([.top, .leading, .trailing]).searchable(text: $text)
                
                List{
                    HStack{
                        Circle().frame(width: 50, height: 50).foregroundColor(Color(red: 229/55, green: 229/255, blue: 229/255))
                        VStack{
                            Text("Name").bold().padding(.horizontal, 1.0)
                            Text("PlaceHolder").padding(.leading, 50.0)
                            
                        }
                    }.listRowBackground(color)
                    
                }
                
                
            }
        }
    }
}
