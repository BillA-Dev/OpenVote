//
//  ActivityView.swift
//  OpenVote
//
//  Created by 90310148 on 4/1/22.
//https://blckbirds.com/post/custom-tab-bar-in-swiftui/


//https://blckbirds.com/post/how-to-create-a-search-bar-with-swiftui/
//Fix this


extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}


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
