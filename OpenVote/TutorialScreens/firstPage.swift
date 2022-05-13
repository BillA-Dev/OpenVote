//
//  firstPage.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import SwiftUI

struct firstPage: View{
    
    @EnvironmentObject var clickedIndex: GlobalVariables
    
    @State var darkBlue = Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0)
    @State var gray = Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)
    
    @State var name: String = ""
    var body: some View {
        VStack{

            ZStack{
                Rectangle().aspectRatio(1, contentMode: .fit).cornerRadius(24).padding(50).cornerRadius(24).foregroundColor(Color(hexString: "e5e5ea"))
            }
            HStack{
            Text("Welcome to Open").font(.title).fontWeight(.bold).foregroundColor(Color(hexString: "20274B")).padding(.bottom).font(Font.custom("AvenirLTStd-Black", size: 17))
                Text("Vote").font(.title).fontWeight(.bold).foregroundColor(Color(hexString: "0070C0")).padding(.bottom).font(Font.custom("AvenirLTStd-Black", size: 17)).padding(-8)
            Text(".").font(.title).fontWeight(.bold).foregroundColor(Color(hexString: "20274B")).padding(.bottom).font(Font.custom("AvenirLTStd-Black", size: 17))
            }
            VStack{
            Text("Please enter your name below.").padding([.leading, .trailing], 40)
                Text("(We take privacy seriously, and your information never leavesthis device)").font(Font.custom("AvenirLTStd-Black", size: 9)).padding(5)
                
                TextField("Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding([.horizontal], 60)
                    .padding()
            }
            
            HStack{
                Spacer()

                progressCircle(enterColor: Color(hexString: "20274B"))
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                Circle().frame(width: 22, height: 22).foregroundColor(Color(hexString: "20274B")).padding(8).overlay{
                    Image(systemName: "arrow.right").foregroundColor(Color.white)
                    
                }.onTapGesture {
                    //Save name to globalVar
                    clickedIndex.userName = name
                    print(clickedIndex.userName)
                    withAnimation {
                        clickedIndex.indexClicked = 1
                    }
                    
                    
                }
                Spacer()
            }.padding(20)
            Spacer()
//            HStack{
//                Button(action: {
//                    clickedIndex.indexClicked = 3
//                }){
//                Text("Skip").foregroundColor(Color(red: 0.035, green: 0.098, blue: 0.159)).bold()
//                }
//                Image(systemName: "arrow.right").foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0))
//            }.padding()
        }
    }
}

struct firstPage_Previews: PreviewProvider {
    static var previews: some View {
        firstPage()
    }
}
