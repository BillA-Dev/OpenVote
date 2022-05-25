//
//  HomeScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI



struct rectangle: View{
    var color: Color
    var body: some View{
        Rectangle().frame(height: 200).padding().foregroundColor(color)
    }
}

struct customTabBar: View{
    @Binding var arrOfRect: [rectangle]
    
    @State var indexOfArr: Int = 0
    
    @State var offSetAmmount: CGSize = .zero
    var body: some View{
        HStack{
            if !arrOfRect.isEmpty{
                
                arrOfRect[indexOfArr].offset(offSetAmmount)
            }
        }.onAppear{
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { Timer in
                Timer.tolerance = 0.04
                withAnimation {
                    
                    if indexOfArr == arrOfRect.count - 1{
                        indexOfArr = 0
                    }else{
                        indexOfArr += 1
                    }
                    print(indexOfArr)
                }
            }
            
        }
    }
}

/*
enum quarter: CaseIterable{
    case q42020, q12021, q22021, q32021, q42021, q12022, q22022
}
*/

struct HomeScreen: View {
    @State var selection: Int = 0
    
    @State var color = [Color.red, Color.blue, Color.orange, Color.black, Color.gray, Color.green]
    
    @State var nameOfPerson: String = "Null"
    
    @State var arrOfRect: [rectangle] = []
    
    @State var dictOfNames: [String: [String: [item]]] = [:]
    
    
    @EnvironmentObject var globalVar: GlobalVariables
   
    @State var chartData: [(String, Int)] = []
    
    
    @State var chartStyleDark = ChartStyle(backgroundColor: Color.white, accentColor: Colors.openvoteBlue, secondGradientColor: Colors.openvoteBlue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Colors.openvoteGray)
    
    var body: some View {
        
        VStack{
            
            Text("Hi there, \(nameOfPerson)")
            
                    TabView(selection: $selection){
                        
                       //I know what I have to do however I dont know
                        BarChartView(data: ChartData(values: chartData), title: "Nancy Pelosi (Contributions)", style: chartStyleDark, form: ChartForm.large, cornerImage: Image("OpenVoteIcon"), valueSpecifier: "%.0f", animatedToBack: true).overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Colors.openvoteGray, lineWidth: 2)).padding(10)
                        

                        }
            
            
                    }.tabViewStyle(PageTabViewStyle())
                .onAppear {
                    
                    if let name = UserDefaults.standard.string(forKey: "privateUserName"){
                        nameOfPerson = name
                    }
                    
                   
//                    for x in 0...5{
//                        print("IS THIS WORKING")
//                        arrOfRect.append(rectangle(color: color[x]))
//
//                    }
                    
                    //Schedule Timer
                    
                    
                    //                Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { Timer in
                    //                    withAnimation(Animation.easeIn(duration: 4.0)){
                    //
                    //                        if selection == 2{
                    //                            selection = 0
                    //                        }else{
                    //                            selection += 1
                    //                        }
                    //                        Timer.tolerance = 0.2
                    //                    //print(selection)
                    //                    }
                    //                }
                    
                    
                    
                    
                    
                }.onAppear {
                    
                   
                    for date in Array(globalVar.dictOfNames["Hon. Nancy Pelosi"]!.keys).sorted(by: { $0.stringToDate().compare($1.stringToDate()) == .orderedAscending })
{
                        print(date)
                       
                        var countOfTrans = globalVar.dictOfNames[date]?.count
                        
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        let dateForm = dateFormatter.date(from: date)!
                        
                        //Fix this
                        
                        let month = Double(Calendar.current.component(.month, from: dateForm))
                        
                        
                      
                        
                        
                        
                        let year = String(Calendar.current.component(.year, from: dateForm))
                        
                        if (1<=month&&3>=month){
                            if chartData.contains(where: {$0.0 == "Q1 | \(year)"}){
                                if let index = chartData.firstIndex(where: {$0.0 == "Q1 | \(year)"}){
                                chartData[index].1 += globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count
                                }
                            }else{
                                chartData.append(("Q1 | \(year)", globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count))
                            }
                            
                            
                        }else if (4<=month&&6>=month){
                            
                            if chartData.contains(where: {$0.0 == "Q2 | \(year)"}){
                                if let index = chartData.firstIndex(where: {$0.0 == "Q2 | \(year)"}){
                                chartData[index].1 += globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count
                                }
                            }else{
                                chartData.append(("Q2 | \(year)", globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count))
                            }
                            
                            
                        
                        }else if (7<=month&&9>=month){
                            
                            if chartData.contains(where: {$0.0 == "Q3 | \(year)"}){
                                if let index = chartData.firstIndex(where: {$0.0 == "Q3 | \(year)"}){
                                chartData[index].1 += globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count
                                }
                            }else{
                                chartData.append(("Q3 | \(year)", globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count))
                            }
                            
                            
                           
                        }else{
                            if chartData.contains(where: {$0.0 == "Q4 | \(year)"}){
                                if let index = chartData.firstIndex(where: {$0.0 == "Q4 | \(year)"}){
                                chartData[index].1 += globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count
                                }
                            }else{
                                chartData.append(("Q4 | \(year)", globalVar.dictOfNames["Hon. Nancy Pelosi"]![date]!.count))
                            }
                            
                            
                        }
                        
                    }

                    chartData.removeFirst()
                    chartData.removeFirst()
                    print(chartData)
                    
                    
                }
        }
    }


extension String{
    func stringToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: self)!
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
