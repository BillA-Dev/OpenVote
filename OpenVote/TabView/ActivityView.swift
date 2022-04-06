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






class screenController{
    static var homePage = homePageView()
    static var secondPage = secondView()
    static var emptyView = EmptyView()
    
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
                
                tabBar()
                
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
    
    
    
    @State var nameArr: [[String]] = []
    
    //Put his in env
    
    
    
    @State var pacName: [String] = []
    @State var dates: [String] = []
    
    init(){
        UITableView.appearance().backgroundColor = .white
    
        let _ = UIScrollView.ContentInsetAdjustmentBehavior.never
        
        //print(globalVar.nameArr)
        
        //WHY
        
        
        print("Does this work")
        
        
    }
    
    //Connect pacName/nameArr/and other stuff. 
    
    var body: some View{
       
        VStack{
            Text("Activity").font(.system(size: 25)).bold().padding([.top, .leading, .trailing])
            searchBar()
            
            
            List{
                //COMBINE THIS!
                
                    ForEach(nameArr.filter({
                        globalVar.searchText.isEmpty ? true: $0[0].contains(globalVar.searchText)
                    }), id: \.self){x in
                        
                    HStack{
                        Circle().frame(width: 55, height: 55).foregroundColor(Color(red: 248/55, green: 248/255, blue: 248/255)).overlay{
                            //ASK LUCAS ABOUT THE OTHERS
                            
                            //PARTY
                            Image(x[3] == "R" ? "republican" : x[3] == "D" ? "democratic" :  "independent").resizable().aspectRatio(contentMode: .fit).padding(8)
                            
                            //The homepage is wierd
                        }
                        //ZAGG
                        
                        //This was it!
                        VStack(alignment: .leading){
                         
                            //NAME
                            Text(x[0])
                            
                            //PacName
                            Text(x[1] + " / $\(x[4])").font(.system(size: 12))

                        }
                        Spacer()
                        
                        //DATE
                        Text(x[2]).font(.system(size: 8))

                    }.listRowBackground(Color.white)
                     .listRowSeparator(.hidden)
                
                }
            }
            
            
            .ignoresSafeArea()
            //See if this makes some error
            //Spacer()
        }
        
        .onAppear {
            
            independentExpend()
        }
    }
    
    
    //API FUNC HERE
    func formatDates(date: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return (dateFormatterPrint.string(from: date))
        }else{
            return "null"
        }
        
    }
    func independentExpend(){
        
        print("THIS FUNCTION IS RUNNING")
        //API Should Work
        let url = "http://www.opensecrets.org/api/?method=independentExpend&apikey=94b9a047921d79a4d77286e1b48c2175&output=json"
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            do {
                // make sure this JSON is in the format we expect
                //https://www.advancedswift.com/swift-json-without-swiftyjson/
                //https://stackoverflow.com/questions/25475463/how-to-access-deeply-nested-dictionaries-in-swift
                
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let x = dict["response"]!["indexp"]!! as! NSArray
                for l in x{
                    let dictWithInfo = (l as! NSDictionary)["@attributes"] as! NSDictionary
                    
                    // print(dictWithInfo["candname"] as! String)
                    
                    //let date = formatDates(date: "\(dictWithInfo["date"] as! String)")
                    
                    //Chance pacshort to ammount!
                    nameArr.append(["\(dictWithInfo["candname"] as! String)", "\(dictWithInfo["pacshort"] as! String)", formatDates(date: "\(dictWithInfo["date"] as! String)"), "\(dictWithInfo["party"] as! String)",  "\(dictWithInfo["amount"] as! String)"])
                    
//                    pacName.append("\(dictWithInfo["pacshort"] as! String)")
//                    formatDates(date: "\(dictWithInfo["date"] as! String)")
                    
                }
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
        
        
    }
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
            itemOfTabBar(imageName: "homepage", page: .home).padding(.bottom)
            itemOfTabBar(imageName: "candidateview", page: .canView).padding(.bottom)
            itemOfTabBar(imageName: "graphview", page: .graphView).padding(.bottom)
            itemOfTabBar(imageName: "recentactivity", page: .activity).padding(.bottom)
            itemOfTabBar(imageName: "pacview", page: .PAC).padding(.bottom)
            
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/10).background(
            color
               
                .mask(Rectangle().padding(.top, -8).foregroundColor(color))
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
            Rectangle().cornerRadius(8).frame(height: 45).padding(.horizontal).foregroundColor(Color(red: 248/255, green: 248/255, blue: 248/255))
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
