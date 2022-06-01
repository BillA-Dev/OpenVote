//
//  HomeScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI
import Network
 







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
    
    
    
    
    @State var chartStyleDark = ChartStyle(backgroundColor: Color.white, accentColor: Colors.openvoteBlue, secondGradientColor: Colors.openvoteBlue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Colors.openvoteGray)
    
    @State var redeactedChartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Colors.redactedGray, secondGradientColor: Colors.redactedGray, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Colors.openvoteGray)
    
    
    
    
    @State var defualtCarousel = ["Hon. Nancy Pelosi", "Hon. Adam B. Schiff", "Hon. Marjorie Taylor Greene", "Hon. Matt Gaetz"]
    
    
    @State var hour = Int(Calendar.current.component(.hour, from: Date()))
    
    var body: some View {
        
        //Half Finished HomeScreen
        
        
        VStack{
            
            if hour > 4 && hour < 12{
                Text("Good Morning, \(nameOfPerson).").font(.title).bold()
            }else if hour > 12 && hour < 17{
                Text("Good Afternoon, \(nameOfPerson).").font(.title).bold()
            }else{
                Text("Good Evening, \(nameOfPerson).").font(.title).bold()
            }
            
            HStack{
                Text("Trading Summary").foregroundColor(Color(hexString: "1F274B"))
                Text("/ Major Figures").foregroundColor(Color(hexString: "C2C2C2")).padding(-5)
            }
            
            if globalVar.stockDataDoneLoading{
                TabView(selection: $selection){
                    
                    
                    
                    ForEach(Array(zip(defualtCarousel.indices, defualtCarousel)), id: \.0){ index, name in
                        BarChartView(data: ChartData(values: getChartData(personOfInterest: name)), title: "\(name) (Contributions)", style: chartStyleDark, form: ChartForm.large, cornerImage: Image("OpenVoteIcon"), valueSpecifier: "%.0f", animatedToBack: true).overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Colors.openvoteGray, lineWidth: 2)).frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/6).padding(20).tag(index)
                                
                    }.frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/6).padding(20)
                    
                    
                    
                    
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width/1.25, height: UIScreen.main.bounds.height/4.5).padding(20)
                
                
            }else{
                
                BarChartView(data: ChartData(values: [("q1", 3), ("q1", 7), ("q1", 4), ("q1", 7), ("q1", 5), ("q1", 5)]), title: "Person (Contributions)", style: redeactedChartStyle, form: ChartForm.large, valueSpecifier: "%.0f", animatedToBack: true)
                    .skeletonLoading()
                    .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Colors.openvoteGray, lineWidth: 2)).frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/6.5).padding(25)
                
            }
            
            HStack{
                Text("Trading Summary").foregroundColor(Color(hexString: "1F274B"))
                Text("/ How it works").foregroundColor(Color(hexString: "C2C2C2")).padding(-5)
            }
            //Main Screen
            Image("Group 28")
            // RoundedRectangle(cornerRadius: 17).frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/6.5).foregroundColor(Color(hexString: "f8f8f8")).overlay{
               // RoundedRectangle(cornerRadius: 17).stroke(lineWidth: 4).frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/6.5).foregroundColor(Color(hexString: "efefef"))
            // }
            
            
           
            VStack(alignment: .leading){
                HStack{
                    
                    Image("illustration-placeholder").resizable().aspectRatio(contentMode: .fit).overlay{
                        Image("dataComeFromImage").resizable().padding().aspectRatio(contentMode: .fit)
                    }.padding()
                    VStack(alignment: .leading){
                        Text("Where does this data come from?").font(.system(size: 14)).bold()
                        Text("The Stock Trading Congresional Knowledge (STOCK) Act requires U.S representatives to publicly file and disclose any financial transaction within 45 days of occurence").font(.system(size: 11))
                    }.padding()
                }
                HStack{
                    
                    Image("illustration-placeholder-square").resizable().aspectRatio(contentMode: .fit).overlay{
                        Image("Group").resizable().padding().aspectRatio(contentMode: .fit)
                    }.padding()
                    VStack(alignment: .leading){
                        Text("What does this data mean?").font(.system(size: 14)).bold()
                        Text("The graphs show the number of quarterly transactions (purchase/sales) for several representatives").font(.system(size: 11))
                    }.padding()
                }
                
            }
            
            
        }.onAppear {
            
            if let name = UserDefaults.standard.string(forKey: "privateUserName"){
                nameOfPerson = name
            }
            
            
            //                    for x in 0...5{
            //                        print("IS THIS WORKING")
            //                        arrOfRect.append(rectangle(color: color[x]))
            //
            //                    }
            
            //Schedule Timer
            
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { Timer in
                withAnimation(Animation.easeIn(duration: 5)){
                    
                    if selection == defualtCarousel.count{
                        selection = 0
                    }else{
                        selection += 1
                    }
                    Timer.tolerance = 0.2
                    //print(selection)
                }
            }
            
            
            
            
            
        }
        
    }
    
    func getChartData(personOfInterest: String) -> [(String, Int)]{
        
        var chartData: [(String, Int)] = []
        
        
        for date in Array(globalVar.dictOfNames[personOfInterest]!.keys).sorted(by: { $0.stringToDate().compare($1.stringToDate()) == .orderedAscending })
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
                        chartData[index].1 += globalVar.dictOfNames[personOfInterest]![date]!.count
                    }
                }else{
                    chartData.append(("Q1 | \(year)", globalVar.dictOfNames[personOfInterest]![date]!.count))
                }
                
                
            }else if (4<=month&&6>=month){
                
                if chartData.contains(where: {$0.0 == "Q2 | \(year)"}){
                    if let index = chartData.firstIndex(where: {$0.0 == "Q2 | \(year)"}){
                        chartData[index].1 += globalVar.dictOfNames[personOfInterest]![date]!.count
                    }
                }else{
                    chartData.append(("Q2 | \(year)", globalVar.dictOfNames[personOfInterest]![date]!.count))
                }
                
                
                
            }else if (7<=month&&9>=month){
                
                if chartData.contains(where: {$0.0 == "Q3 | \(year)"}){
                    if let index = chartData.firstIndex(where: {$0.0 == "Q3 | \(year)"}){
                        chartData[index].1 += globalVar.dictOfNames[personOfInterest]![date]!.count
                    }
                }else{
                    chartData.append(("Q3 | \(year)", globalVar.dictOfNames[personOfInterest]![date]!.count))
                }
                
                
                
            }else{
                if chartData.contains(where: {$0.0 == "Q4 | \(year)"}){
                    if let index = chartData.firstIndex(where: {$0.0 == "Q4 | \(year)"}){
                        chartData[index].1 += globalVar.dictOfNames[personOfInterest]![date]!.count
                    }
                }else{
                    chartData.append(("Q4 | \(year)", globalVar.dictOfNames[personOfInterest]![date]!.count))
                }
                
                
            }
            
        }
        
        return chartData
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
