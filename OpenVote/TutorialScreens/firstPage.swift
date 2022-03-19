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
    
    var body: some View {
        VStack{
//            HStack{
//                Spacer()
//                HStack{
//                Text("Skip").foregroundColor(Color(red: 0.035, green: 0.098, blue: 0.159)).bold()
//                Image(systemName: "arrow.right").foregroundColor(darkBlue)
//                }.padding(.horizontal)
//            }
            ZStack{
                Rectangle().aspectRatio(1, contentMode: .fit).cornerRadius(5).padding(50).shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 5).cornerRadius(5).foregroundColor(Color(red: 0.8666666666666667, green: 0.9176470588235294, blue: 0.9529411764705882)).overlay{
                    
                    Image(systemName: "photo").resizable()
                        .foregroundColor(Color.gray).frame(width: 50, height: 50).padding().aspectRatio(1.0, contentMode: .fit)
                    //Probably add image ilogo here
                }
            }
            
            Text("Welcome to OpenVote.").font(.title).fontWeight(.bold).foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0)).padding(.bottom).font(Font.custom("AvenirLTStd-Black", size: 17))
            Text("Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum.").padding([.leading, .trailing], 40)
            
            HStack{
                Spacer()
//
//                Circle().frame(width: 15, height: 15).foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0)).padding(8)
//                Circle().frame(width: 15, height: 15).foregroundColor(Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)).padding(8)
//                Circle().frame(width: 15, height: 15).foregroundColor(Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)).padding(8)
//                Circle().frame(width: 15, height: 15).foregroundColor(Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)).padding(8)
                progressCircle(enterColor: darkBlue)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                
                Spacer()
            }.padding(20)
            HStack{
                Button(action: {
                    clickedIndex.indexClicked = 3
                }){
                Text("Skip").foregroundColor(Color(red: 0.035, green: 0.098, blue: 0.159)).bold()
                }
                Image(systemName: "arrow.right").foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0))
            }.padding()
        }
    }
}

struct firstPage_Previews: PreviewProvider {
    static var previews: some View {
        firstPage()
    }
}
