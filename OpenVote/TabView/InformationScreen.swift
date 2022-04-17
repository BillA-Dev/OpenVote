//
//  InformationScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/13/22.
//

import SwiftUI

struct buttonClicked{
    var filterSystem: String
    var textOfWhatClicked: String
    var isClicked: Bool = false
    
}


struct filterScreen: View{
    @EnvironmentObject var glovalBar: GlobalVariables
    @State var range: Double = log10(5_000_000)/log(10)
    @State var numberForm = NumberFormatter()
    
    @State var party: [Bool] = [true, true, true]
    @State var chamber: [Bool] = [true, true, true]
    
    
    init(){
        numberForm.numberStyle = .currency
        numberForm.maximumFractionDigits = 0
        
    }
    
    var body: some View{
        VStack{
            HStack{
                Button(action:{
                    glovalBar.isShowingFilterScreen = false
                    print("clicked")
                    filterTest()
                    //I will have to work on the filter code; this is actually much harder than it looks
                    //Filter code here
                    
                    UserDefaults.standard.set(party, forKey: "partyArray")
                    UserDefaults.standard.set(chamber, forKey: "chamberArray")
                }){
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color(hexString: "20274B"))
                }.padding()
                Spacer()
                Text("Filter Expenditures")
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(Color(hexString: "20274B"))
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color.clear).padding()
                
            }
            VStack{
                VStack(alignment: .leading){
                    Text("Party")
                        .font(.system(size:16))
                        .bold()
                    HStack{
                        Button(action:{
                            party[0].toggle()
                        }){
                            
                            Text("Democratic")
                                .foregroundColor(Color(hexString: !party[0] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( party[0] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !party[0] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                        }
                        //  Spacer()
                        Button(action:{
                            party[1].toggle()
                        }){
                            Text("Republican")
                                .foregroundColor(Color(hexString: !party[1] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( party[1] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !party[1] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                            
                        }.padding(.horizontal, 5)
                        //Spacer()
                        Button(action:{
                            party[2].toggle()
                        }){
                            Text("3rd")
                                .foregroundColor(Color(hexString: !party[2] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( party[2] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !party[2] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                        }
                        Spacer()
                    }
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Chamber")
                        .font(.system(size:16))
                        .bold()
                    HStack{
                        Button(action:{
                            chamber[0].toggle()
                        }){
                            Text("House")
                                .foregroundColor(Color(hexString: !chamber[0] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( chamber[0] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !chamber[0] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                        }
                        // Spacer()
                        Button(action:{
                            chamber[1].toggle()
                        }){
                            Text("Senate")
                                .foregroundColor(Color(hexString: !chamber[1] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( chamber[1] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !chamber[1] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                        }.padding(.horizontal, 5)
                        //  Spacer()
                        Button(action:{
                            chamber[2].toggle()
                        }){
                            Text("Executive")
                                .foregroundColor(Color(hexString: !chamber[2] ? "9F9FA5" : "ffffff"))
                                .padding(.horizontal)
                                .padding([.top, .bottom], 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10).foregroundColor( chamber[2] ? Color(hexString: "20274B") : Color.clear)
                                    
                                    
                                )
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(Color(hexString: !chamber[2] ? "BAC6D5" : "20274B")))
                                .font(.system(size: 17))  // 1
                                .minimumScaleFactor(0.01)
                        }
                        Spacer()
                    }
                }
        
                VStack(alignment: .leading){
                    Text("Expenditure Amount")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 10)
                    
                    HStack{
                        
                        
                        Text("$0").foregroundColor(Color(hexString: "9F9FA5"))
                        Spacer()
                        Text("$100,000").foregroundColor(Color(hexString: "9F9FA5")).padding([.leading], 48)
                        Spacer()
                        Text("$1,500,000").foregroundColor(Color(hexString: "9F9FA5"))
                        
                        
                    }.padding(.top, 8)
                    
                    
                    
                    Slider(value: $glovalBar.amountValue, in: 0...5).foregroundColor(Color(hexString: "20274B"))
                    
                    HStack(alignment: .bottom) {
                        Text("\(numberForm.string(from: NSNumber(value: glovalBar.amountValue < 2.5 ? (40000 * glovalBar.amountValue) : (560000 * (glovalBar.amountValue - 2.5) + 100000))) ?? "NULL")")
                            .padding(.bottom, 10)
                            .foregroundColor(Color(hexString: "9F9FA5"))

                    }
                    
                    //                        .onTapGesture{
                    //                        print(filteration.getMaximumNumber(arr: glovalBar.arrayOfPeople))
                    //                    }
                }.onChange(of: glovalBar.amountValue) { V in
                    
                    if Float(V) < 2.5 {
                        glovalBar.sliderAmmount = 40000 * V
                    } else {
                        glovalBar.sliderAmmount = 560000 * (V - 2.5) + 100000
                    }
                }
                
                
            }.padding([.horizontal])
        }
        .onAppear{
            
            if let x = UserDefaults.standard.array(forKey: "partyArray"){
                party = x as! [Bool]
            }
            if let x = UserDefaults.standard.array(forKey: "chamberArray"){
                chamber = x as! [Bool]
            }
            
        }
    }
    
    func turn2dinto1d(arr: [[people]]) -> [people]{
        var ar: [people] = []
        for x in arr{
            for j in x{
                ar.append(j)
            }
        }
        return ar
        
        
    }
    
    
    enum partyValues: String, CaseIterable{
        //Find a way to add three, but later
        case D, R, I
    }
    enum chamberValues: String, CaseIterable{
        case House, Senate, Executive
    }
    
    func checkForChamber(district: String, chamber: String) -> Bool{
        var x = ""
        if district[district.index(district.startIndex, offsetBy: 2)] == "S"{
            x = "Senate"
        }else if district == "PRES"{
            x = "Executive"
        }else{
            print(district[...district.index(district.startIndex, offsetBy: 2)])
            x = "House"
        }
        return x == chamber ? true : false
    }
    
    
    
    func filterTest(){
        
        //Optimize function later epecially if statments
        //Money later
        
        
        
        //First check if all are selected
        if chamber.allSatisfy({$0 == true}) && party.allSatisfy({$0 == true}){
            glovalBar.arrayOfPeople = filteration.originalArr
        }else{
            if chamber.allSatisfy({$0 == false}){
                //get party in here with no regard to chamber
                var arr: [[people]] = []
                
                for x in 0..<party.count{
                    if party[x] == true{
                        arr.append(filteration.originalArr.filter({$0.party == partyValues.allCases[x].rawValue}))
                    }
                }
                
                
                //arr.flatMap{$0}
                //Array(arr.joined())
                glovalBar.arrayOfPeople = arr.reduce([], +)
                
            }else{
                //First filter chamber here
                var arr: [[people]] = []
                for x in 0..<chamber.count{
                    if chamber[x] == true{
                        arr.append(filteration.originalArr.filter({
                            checkForChamber(district: $0.district, chamber: chamberValues.allCases[x].rawValue)
                        }))
                    }
                }
                
                
                glovalBar.arrayOfPeople = arr.reduce([], +)
                arr.removeAll()
                //Now check if people are selected as well
                if party.contains(true){
                    
                    for x in 0..<party.count{
                        if party[x] == true{
                            
                            
                            arr.append(glovalBar.arrayOfPeople.filter({$0.party == partyValues.allCases[x].rawValue}))
                        }
                    }
                    glovalBar.arrayOfPeople = arr.reduce([], +)
                }
                
            }
        }
        
        //Filter money here
        //1...7.contains()
        // x ~= 50
        //create number range
        let range = 0...glovalBar.sliderAmmount
        glovalBar.arrayOfPeople = glovalBar.arrayOfPeople.filter({
            range ~= Float($0.amount) ?? 1_500_000
        })
        
    }
}


struct informationText: View{
    
    @EnvironmentObject var glovalBar: GlobalVariables
    
    
    var body: some View{
        VStack{
            HStack{
                Button(action:{
                    glovalBar.isShowingInfoScreen = false
                }){
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color(hexString: "20274B"))
                }.padding()
                Spacer()
                Text("More Information")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(Color(hexString: "20274B"))
                Spacer()
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color.clear).padding()
                
            }
            
            VStack(alignment: .leading){
                
                
                VStack(alignment: .leading){
                    Text("What are independent expenditures?")
                        .bold()
                        .foregroundColor(Color(hexString: "20274B"))
                        .font(.system(size: 15))
                    
                    Text("Independent expenditures are payments that advocate for the election or defeat of a specific candidate. They're not made in coordination with that candidate, and they're typically advertisements.")
                        .font(.system(size: 300))  // 1
                        .minimumScaleFactor(0.01)
                    
                    
                        .foregroundColor(Color(hexString: "20274B"))
                }
                Spacer()
                VStack(alignment: .leading){
                    //<ake this more dynamic I guess
                    Text("Are there limits on independent expenditures?")
                        .bold()
                        .foregroundColor(Color(hexString: "20274B"))
                        .font(.system(size: 15))
                    
                    Text("No, unlimited amounts of money may be spent. Citizens United vs FC (2010) controversially ruled that the free speech clause of the 1st Amendment prohibits restrictions on all independent expenditures. This case has almost singlehandedly fueled the rise of Super PACs.")
                        .font(.system(size: 300))  // 1
                        .minimumScaleFactor(0.01)
                    
                        .foregroundColor(Color(hexString: "20274B"))
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("What are Super PACs?")
                        .bold()
                        .foregroundColor(Color(hexString: "20274B"))
                        .font(.system(size: 15))
                    
                    Text("Unlike typical political action committees (PACs), Super PACs rely on independent expenditures to skirt imits on what they can spend and raise. According to data from OpenSecrets, the top 100 individual Super PAC donors make up just 3.7% of contributors, but they accounted for more than 80% of the total money raised.")
                        .font(.system(size: 300))  // 1
                        .minimumScaleFactor(0.01)
                    
                        .foregroundColor(Color(hexString: "20274B"))
                }
                
            }.padding([.horizontal, .bottom])
        }
    }
}


struct CustomModal<Content: View>: View {
    @Binding var isShowing: Bool
    
    let content: Content
    
    var body: some View {
        
        if isShowing{
            
            ZStack(alignment: .center){
                
                RoundedRectangle(cornerRadius: 20)
                
                    .foregroundColor(Color.white).overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hexString: "20274B"), lineWidth: 2)
                        
                    )
                content
            }.frame(height: UIScreen.main.bounds.width, alignment: .center).padding([.horizontal], 20).padding([.top, .bottom], 90)
            
            //Have no idea - But clipped removes the childViews
                .clipped()
                .shadow(radius: 4)
            
        }
    }
}

#if DEBUG
struct InformationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CustomModal(isShowing: Binding.constant(true), content: Text("Test"))
    }
}
#endif
