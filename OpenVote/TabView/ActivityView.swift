//
//  ActivityView.swift
//  OpenVote
//
//  Created by 90310148 on 4/1/22.
//https://blckbirds.com/post/custom-tab-bar-in-swiftui/


//https://blckbirds.com/post/how-to-create-a-search-bar-with-swiftui/
//Fix this


import SwiftUI
import UIKit


struct people: Identifiable{
    var id = UUID()
    var name: String
    var pacInfo: String
    var date: String
    var party: String
    var amount: String
    var district: String
}

class filteration{
    
    static var originalArr: [people] = []
    
}

class screenController{
    static var activityPage = recentActivityView()
    static var homePage = HomeScreen()
    static var emptyView = EmptyView()
}

enum pages: String{
    
    case home, canView, graphView, activity, PAC
}

class mainController: ObservableObject{
    @Published var currentPage: pages = .activity
    //Current page
}


struct ActivityView: View {
    @StateObject var pageNav = mainController()
    
    @EnvironmentObject var globalVar: GlobalVariables
    
    var body: some View {
        
        ZStack{
            
            VStack {
         
                switch pageNav.currentPage{
                case .home:
                    screenController.homePage
                    Spacer()
                case .canView:
                    screenController.emptyView
                    Spacer()
                case .graphView:
                    screenController.emptyView
                    Spacer()
                case .activity:
                    screenController.activityPage
                case.PAC:
                    screenController.emptyView
                    Spacer()
                }
                
                tabBar().background(
                    Color.white.mask(
                        RoundedRectangle(cornerRadius: 20).padding(.top, -8)
                    ).shadow(radius: 8)
                )
                    .blur(radius: globalVar.isShowingInfoScreen ? 3 : globalVar.isShowingFilterScreen ? 3 : 0)
                    .disabled(globalVar.isShowingInfoScreen || globalVar.isShowingFilterScreen)
                
            }
        }
        
        
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(pageNav)
        
    }
    
    struct ActivityView_Previews: PreviewProvider {
        static var previews: some View {
            
            ActivityView()
                .previewDevice("iPhone 11")
            
            
        }
    }
}
