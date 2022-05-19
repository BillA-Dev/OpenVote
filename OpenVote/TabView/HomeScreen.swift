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


struct item{
    var amount: String
    var description: String
}
struct HomeScreen: View {
    @State var selection: Int = 0
    
    @State var color = [Color.red, Color.blue, Color.orange, Color.black, Color.gray, Color.green]
    
    @State var nameOfPerson: String = "Null"
    
    
    @State var arrOfRect: [rectangle] = []
    
    
    
    
    
    @State var dictOfNames: [String: [String: [item]]] = [:]
    
    
    
   
    
    var body: some View {
        
        VStack{
            Text("Good Morning, \(nameOfPerson)").onTapGesture {
                URLSession.shared.dataTask(with: URL(string: "https://house-stock-watcher-data.s3-us-west-2.amazonaws.com/data/all_transactions.json")!){data, response, error in
                    do{
                       
                        var dict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                        for l in dict! {
                            
                            //Needed Info
                            let x = l as! [String: AnyObject]
                            let rep = x["representative"] as! String
                            let discDate = x["disclosure_date"] as! String
                            let amount = x["amount"] as! String
                            var desc = "NULL"
                            if x["asset_description"] is NSNull{
                            desc = "Null"
                            }else{
                            desc = x["asset_description"] as! String
                            }
                            
                            
                            if dictOfNames[rep] != nil{
                                if dictOfNames[rep]![discDate] != nil{
                                    dictOfNames[rep]![discDate]!.append(item(amount: amount, description: desc))
                                }else{
                                    dictOfNames[rep] = [discDate : [item(amount: amount, description: desc)]]
                                }
                            }else{
                                dictOfNames[rep] = [discDate : [item(amount: amount, description: desc)]]
                            }
                            
                            
                        
                           
                        }
                    }catch{
                        fatalError("FAILED")
                    }
                }.resume()
                
               
                
            }
            
            customTabBar(arrOfRect: $arrOfRect)
            //        TabView(selection: $selection){
            //            ForEach(0...5, id:\.self){ x in
            //
            //                rectangle(color: color[x]).tag(x)
            //            }
            //
            //
            //        }.tabViewStyle(PageTabViewStyle())
                .onAppear {
                    
                    if let name = UserDefaults.standard.string(forKey: "privateUserName"){
                        nameOfPerson = name
                    }
                    
                   
                    for x in 0...5{
                        print("IS THIS WORKING")
                        arrOfRect.append(rectangle(color: color[x]))
                        
                    }
                    
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
                    
                    
                    
                    
                    
                }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
