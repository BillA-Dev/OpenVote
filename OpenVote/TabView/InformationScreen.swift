//
//  InformationScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/13/22.
//

import SwiftUI

struct InformationScreen: View {
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .frame(height: UIScreen.main.bounds.height/1.76, alignment: .center)
            .padding(10)
            .foregroundColor(Color(hexString: "20274B"))
            .overlay{
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(Color.white)
            .frame(height: UIScreen.main.bounds.height/1.8, alignment: .center)
            
            .overlay{
                VStack{
                    HStack{
                        Button(action:{}){
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
                    
                    
                    Spacer()
                    VStack{
                        Text("What are independent expenditures?")
                            .bold()
                            .foregroundColor(Color(hexString: "20274B"))
                            .padding(2)
                        Text("Independent expenditures are payments that advocate for the election or defeat of a specific candidate. They're not made in coordination with that candidate, and they're typically advertisements.")
                            .padding([.horizontal, .bottom], 20)
                            .foregroundColor(Color(hexString: "20274B"))
                    }
                    Spacer()
                    VStack{
                        Text("Are there limits on independent expenditures?")
                            .bold()
                            .foregroundColor(Color(hexString: "20274B"))
                            .padding(2)
                        Text("No, unlimited amounts of money may be spent. Citizens United v. FC (2010) controversially ruled that the free speech clause of the 1st Amendment prohibits restrictions on all independent expenditures. This case has almost singlehandedly fueled the rise of Super PACs.")
                            .padding([.horizontal, .bottom], 20)
                            .foregroundColor(Color(hexString: "20274B"))
                    }
                    Spacer()
                    VStack{
                        Text("What are Super PACs?")
                            .bold()
                            .foregroundColor(Color(hexString: "20274B"))
                            .padding(2)
                        Text("Unlike typical political action committees (PACs), Super PACs rely on independent expenditures to skirt imits on what they can spend and raise. According to data from OpenSecrets, the top 100 individual Super PAC donors make up just 3.7% of contributors, but they accounted for more than 80% of the total money raised.")
                            .padding([.horizontal, .bottom], 20)
                            .foregroundColor(Color(hexString: "20274B"))
                    }
                    
                }
            }.padding()
        }
        
    }
}

struct InformationScreen_Previews: PreviewProvider {
    static var previews: some View {
        InformationScreen()
    }
}
