//
//  homePageView.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI

struct recentActivityView: View{
    
    
    @State var color = Color(red: 248/255, green: 248/255, blue: 248/255)
    @State var text: String = ""
    
    
    @EnvironmentObject var globalVar: GlobalVariables
    
    
    
    
    @State var nameArr: [people] = []
    
    
    
    
    @State var numberForm = NumberFormatter()
    
    @State var pacName: [String] = []
    @State var dates: [String] = []
    
    
    @State var skeletonStillLoading: Bool = true
    
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
                
                Text("Recent Activity").font(.system(size: 25)).bold().padding([.top, .leading, .trailing]).onTapGesture {
                    UserDefaults.standard.delete()
                }
                
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
                                
                                if !skeletonStillLoading{
                                    Image(x.party == "R" ? "republican" : x.party == "D" ? "democratic" :  "independent").resizable().aspectRatio(contentMode: .fit).padding(8)
                                }
                                
                                
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
                    
                    //Bind this with isApi done loading
                }.skeletonLoading(isLoadingDone: $skeletonStillLoading)
                
                
                
                
                
                    .ignoresSafeArea()
                
                
                
                
                
                
                
                
                
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            skeletonStillLoading = false
                        }
                        filteration.originalArr = globalVar.arrayOfPeople
                        
//                        print(globalVar.HouseLegislatorName)
                    }
                
                    .animation(.easeInOut(duration: 4), value: skeletonStillLoading)
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
        let Formname = switchFirstAndLast(name: name)
        return "\(repAndSenName(name: Formname, district: district))\(Formname) (\(party)-\(district))"
    }
    func repAndSenName(name: String, district: String) -> String{
        
        //print(name)
        if globalVar.HouseLegislatorName.contains(name){
          
            
        
        
        if 2 >= 0 && 2 < district.count{
            
            if district[district.index(district.startIndex, offsetBy: 2)] == "S"{
                return "Sen. "
            }else if district == "PRES"{
                return "Pres. "
            }else{
                //print(district[...district.index(district.startIndex, offsetBy: 2)])
                return "Rep. "
                
                
            }
        }else{
            print(district)
            return "NULL "
        }
        }else{
            return ""
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

struct homePageView_Previews: PreviewProvider {
    static var previews: some View {
        recentActivityView()
    }
}
