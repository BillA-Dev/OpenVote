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



//Color Extension
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



class filteration{
    
    static var originalArr: [people] = []
    
    static func getMaximumNumber(arr: [people]) -> Int{
        var max = 0
        for x in arr{
            let am = Int(x.amount)!
            if am > max{
                max = am
            }
        }
        return max
    }
    
    
    //SEE WHICH ONE IS FASTER
    static func ammountInRangeFilter(arr: [people]){
        
        ///My own Filteration System
        //        var newArr: [people] = []
        //        for x in arr{
        //            if isInRange(num: Int(x.amount)!, max: 3789){
        //                newArr.append(x)
        //            }
        //        }
        
        
        
        ///Swift Filteration System
        let newArr = arr.filter({
            
            isInRange(num: Int($0.amount)!, max: 3789)
        })
        
        for x in newArr{
            print(x.name)
        }
    }
    
    private static func isInRange(num: Int, max: Int) -> Bool{
        if num >= 0 && num <= max{
            return true
        }else{
            return false
        }
    }
    
    static func partyFilter(arr: [people], party: String) -> [people]{
        let newArr = arr.filter({
            $0.party == party ? true: false
            
        })
        return newArr
        //        for x in newArr{
        //            print(x.name)
        //        }
        //print(newArr)
    }
    
    //SHOULD BE GOOD
    
}



class screenController{
    static var homePage = homePageView()
    
    
    static var secondPage = secondView()
    
    
    static var emptyView = EmptyView()
    
    
    //Info Screen!
    
    
    
    
    
    
    
}


struct ActivityView: View {
    @StateObject var pageNav = mainController()
    
    @EnvironmentObject var globalVar: GlobalVariables
    
    var body: some View {
        
        ZStack{
            
            VStack {
                //Myabe stop creating seperate insancted
                switch pageNav.currentPage{
                case .home:
                    //Rename Home to activity
                    //Renam screenController homePage to activity page
                    //Rename homePageView() to activityView()
                    
                    
                    //Rename this struct ActivityView to Controller!
                    screenController.emptyView
                    Spacer()
                case .canView:
                    screenController.secondPage
                case .graphView:
                    screenController.emptyView
                    Spacer()
                case .activity:
                    screenController.homePage
                    
                    
                    
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





struct secondView: View{
    var body: some View{
        Text("Hello World")
        Spacer()
        Text("Second")
    }
}




struct homePageView: View{
    
    
    
    
    
    
    @State var color = Color(red: 248/255, green: 248/255, blue: 248/255)
    @State var text: String = ""
    
    
    @EnvironmentObject var globalVar: GlobalVariables
    //No observable object fix this!
    //I will use this arr.
    
    
    
    @State var nameArr: [people] = []
    
    //Put his in env
    
    
    @State var numberForm = NumberFormatter()
    
    @State var pacName: [String] = []
    @State var dates: [String] = []
    
    
    @State var isApiDoneLoading: Bool = false
    
    init(){
        UITableView.appearance().backgroundColor = .white
        
        let _ = UIScrollView.ContentInsetAdjustmentBehavior.never
        
        //print(globalVar.nameArr)
        
        //WHY
        numberForm.numberStyle = .currency
        numberForm.maximumFractionDigits = 0
        
        print("Does this work")
        
        
    }
    
    //Connect pacName/nameArr/and other stuff.
    
    var body: some View{
        
        ZStack{
            VStack{
                
                Text("Recent Activity").font(.system(size: 25)).bold().padding([.top, .leading, .trailing])
                
                HStack{
                    
                    //ADD MODALS HERE
                    searchBar()
                    
                    
                    
                    
                    
                    
                    HStack{
                        
                        Button(action:{
                            globalVar.isShowingFilterScreen = true
                        }){
                        
                        Image(systemName: "line.3.horizontal.decrease.circle").resizable().foregroundColor(Color(hexString: "20274B")).frame(width: 30, height: 30)
                        }
                        
                        Button(action:{
                            //Call isPresented here
                            
                            globalVar.isShowingInfoScreen = true
                            //Maybe toggle
                        }){
                            Image(systemName: "info.circle").resizable().foregroundColor(Color(hexString: "20274B")).frame(width: 30, height: 30)
                            
                        }
                    }.padding([.trailing, .top, .bottom])
                    Spacer()
                }
                
                List{
                    ForEach(globalVar.arrayOfPeople.filter({
                        globalVar.searchText.isEmpty ? true: $0.name.contains(globalVar.searchText)
                        
                        
                    })){x in
                        
                        HStack{
                            Circle().frame(width: 55, height: 55).foregroundColor(Color(red: 248/55, green: 248/255, blue: 248/255)).overlay{
                                
                                if isApiDoneLoading{
                                    Image(x.party == "R" ? "republican" : x.party == "D" ? "democratic" :  "independent").resizable().aspectRatio(contentMode: .fit).padding(8)
                                }
                                
                                //The homepage is wierd
                            }
                            //ZAGG
                            
                            //This was it!
                            VStack(alignment: .leading){
                                
                                
                                Text(formatName(name: x.name, party: x.party, district: x.district)).bold().font(.system(size: 15))
                                
                                
                                
                                //PacName
                                
                                //Figure out number formatter DONE
                                
                                Text(x.pacInfo + " / \(numberForm.string(from: NSNumber(value: Int(x.amount) ?? 0)) ?? "NULL")").font(.system(size: 12))
                                
                            }
                            Spacer()
                            
                            //DATE
                            Text(x.date).font(.system(size: 8))
                            
                        }.listRowBackground(Color.white)
                            .listRowSeparator(.hidden)
                        
                    }
                }.redacted(reason: !isApiDoneLoading ? .placeholder: [])
                
                
                
                
                
                    .ignoresSafeArea()
                
                
                
                
                
                
                
                
                
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            isApiDoneLoading = true
                        }
                        filteration.originalArr = globalVar.arrayOfPeople
                    }
                
                    .animation(.easeInOut, value: isApiDoneLoading)
                    .animation(Animation.easeInOut(duration: 2), value: globalVar.isShowingInfoScreen)
                
            }.blur(radius: globalVar.isShowingInfoScreen ? 3 : globalVar.isShowingFilterScreen ? 3 : 0)
                .disabled(globalVar.isShowingInfoScreen || globalVar.isShowingFilterScreen)
                
            
            
            
            //FINALLY!
            //Other Modal here
            CustomModal(isShowing: $globalVar.isShowingInfoScreen, content: informationText()).transition(.slide)
            CustomModal(isShowing: $globalVar.isShowingFilterScreen, content: filterScreen())
            
        }
        
    }
    
    func formatName(name: String, party: String, district: String) -> String{
        
        return "\(repAndSenName(district: district)) \(switchFirstAndLast(name: name)) (\(party)-\(district))"
    }
    func repAndSenName(district: String) -> String{
        
        
        //!distric.isEmpy
       
        if 2 >= 0 && 2 < district.count{
            
            if district[district.index(district.startIndex, offsetBy: 2)] == "S"{
                return "Sen."
            }else if district == "PRES"{
                return "Pres."
            }else{
                print(district[...district.index(district.startIndex, offsetBy: 2)])
                return "Rep."
                
                
            }
        }else{
            print(district)
            return "NULL"
        }
        
        
    }
    
    func switchFirstAndLast(name: String) -> String{
        if !name.isEmpty{
            let lastName = name[...(name.firstIndex(of: ",")!)]
            let firstName = name[name.index(after: name.firstIndex(of: ",")!)...]
            return "\(firstName) \(lastName[...lastName.index(lastName.startIndex, offsetBy: lastName.count-2)])".trimmingCharacters(in: .whitespaces)
        }else{
            print(name)
            return "Anonoymous"
        }
        
    }
    
    
}




struct people: Identifiable{
    var id = UUID()
    var name: String
    var pacInfo: String
    var date: String
    var party: String
    var amount: String
    var district: String
}









enum pages: String{
    
    case home, canView, graphView, activity, PAC
}

class mainController: ObservableObject{
    @Published var currentPage: pages = .activity
    //Current page
}
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


struct searchBar: View{
    
    @EnvironmentObject var searchQuery: GlobalVariables
    //This is in the enviorment on the firstPage
    
    //Maybe make this update dunamically, by adding a binding to the serach query
    
    //Edit var from here
    @State var text = ""
    
    
    
    var body: some View{
        ZStack{
            Rectangle().cornerRadius(8).frame(height: 40).padding(.horizontal).foregroundColor(Color(red: 248/255, green: 248/255, blue: 248/255))
            HStack{
                Spacer()
                Image(systemName: "magnifyingglass").padding()
                TextField("Search for a name", text: $searchQuery.searchText).onSubmit {
                    //                   searchQuery.searchText = text
                    //                    print(searchQuery.searchText)
                    
                    //Filter var here
                    
                    //Searching is broken.
                    
                    
                }
                ZStack{
                    Circle().frame(width: 20, height: 20).padding().foregroundColor(Color.gray)
                    Button(action:{
                        searchQuery.searchText = ""
                        text = ""
                    }){
                        Image(systemName: "xmark").resizable().frame(width: 10, height: 10).padding().foregroundColor(Color.white)
                    }
                }
                Spacer()
            }
            //Maybe keep this, idk
        }.padding(.horizontal)
    }
}
