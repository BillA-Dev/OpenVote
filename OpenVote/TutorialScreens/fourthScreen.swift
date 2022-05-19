//
//  fourthScreen.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import SwiftUI


//Might make one screen, with an innit for text and image, also clickedIndex value
//For example: tutorialScreen(text: String, clickedIndex: int, image: Image)
struct fourthScreen: View {
    @EnvironmentObject var clickedIndex: GlobalVariables
    
    @State var darkBlue = Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0)
    @State var gray = Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)
    
    
    
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle().aspectRatio(1, contentMode: .fit).cornerRadius(24).padding(50).cornerRadius(24).foregroundColor(Color(hexString: "e5e5ea"))
            }
            
            
            Text("End of Tutorial.").font(.title).fontWeight(.bold).foregroundColor(Color(hexString: "20274B")).padding(.bottom)
            
            Text("Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum.").padding([.leading, .trailing], 40)
            
            HStack{
                Spacer()
                
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: Color(hexString: "20274B"))
                Text("Done").frame(width: 44, height: 44, alignment: .center).foregroundColor(Color(hexString: "8A8A8E")).onTapGesture {
                    //clickedIndex.indexClicked = 3
                    print("Clicked last screen")
                    
                    clickedIndex.tutorialSkipped = true
                   
                    UserDefaults.standard.set(true, forKey: "tutSkipped2")
                    
                    print(clickedIndex.userName)
                    UserDefaults.standard.set(clickedIndex.userName, forKey: "privateUserName")
                    
                    withAnimation {
                        clickedIndex.tutorialSkipped = true
                    }
                }
                
                Spacer()
            }.padding(20)
            Spacer()
        }
    }
    
    
    
}



struct fourthScreen_Previews: PreviewProvider {
    static var previews: some View {
        fourthScreen()
    }
}




