//
//  InformationScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/13/22.
//

import SwiftUI


struct filterScreen: View{
    @EnvironmentObject var glovalBar: GlobalVariables
    @State var range: Double = log10(5_000_000)/log(10)
 
    
    var body: some View{
        VStack{
        HStack{
            Button(action:{
                glovalBar.isShowingFilterScreen = false
                
                //Filter code here
            }){
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color(hexString: "20274B"))
            }.padding()
            Spacer()
        Text("Filter")
                .font(.system(size: 30))
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
            HStack{
                Button(action:{}){
                    Text("Democratic").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                }
                Spacer()
                Button(action:{}){
                    Text("Republican").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                }
                Spacer()
                Button(action:{}){
                    Text("3rd").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                }
            }
        }
                
                VStack(alignment: .leading){
                    Text("Chamber")
                    HStack{
                        Button(action:{}){
                            Text("House").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                        }
                        Spacer()
                        Button(action:{}){
                            Text("Senate").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                        }
                        Spacer()
                        Button(action:{}){
                            Text("Executive").foregroundColor(Color(hexString: "9F9FA5")).padding(10).overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(hexString: "BAC6D5")))
                        }
                    }
                }
                VStack(alignment: .leading){
                    Text("Expenditure Amount")
                    HStack{
                       
                        Text("$1").foregroundColor(Color(hexString: "9F9FA5")).padding(10)
                        Spacer()
                        Text("$10,000").foregroundColor(Color(hexString: "9F9FA5")).padding(10)
                        Spacer()
                        Text("$1,000,000").foregroundColor(Color(hexString: "9F9FA5")).padding(10)
                        
                    }
                    
                    
                    
                    Slider(value: $glovalBar.amountValue, in: 0...5)
                        
                    
//                        .onTapGesture{
//                        print(filteration.getMaximumNumber(arr: glovalBar.arrayOfPeople))
//                    }
                }.onChange(of: glovalBar.amountValue) { V in
                    
                    if Float(V) < 2.5 {
                        print(40000 * V)
                    } else {
                        print(560000 * (V - 2.5) + 100000)
                    }
                }
                
                
            }.padding([.horizontal])
        }
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
                   
                Text("Independent expenditures are payments that advocate for the election or defeat of a specific candidate. They're not made in coordination with that candidate, and they're typically advertisements.") .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    
                    
                    .foregroundColor(Color(hexString: "20274B"))
            }
            Spacer()
            VStack(alignment: .leading){
                //<ake this more dynamic I guess
                Text("Are there limits on independent expenditures?")
                    .bold()
                    .foregroundColor(Color(hexString: "20274B"))
                    .font(.system(size: 15))
                    
                Text("No, unlimited amounts of money may be spent. Citizens United vs FC (2010) controversially ruled that the free speech clause of the 1st Amendment prohibits restrictions on all independent expenditures. This case has almost singlehandedly fueled the rise of Super PACs.") .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    
                    .foregroundColor(Color(hexString: "20274B"))
            }
            Spacer()
            VStack(alignment: .leading){
                Text("What are Super PACs?")
                    .bold()
                    .foregroundColor(Color(hexString: "20274B"))
                    .font(.system(size: 15))
                    
                Text("Unlike typical political action committees (PACs), Super PACs rely on independent expenditures to skirt imits on what they can spend and raise. According to data from OpenSecrets, the top 100 individual Super PAC donors make up just 3.7% of contributors, but they accounted for more than 80% of the total money raised.") .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                   
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
