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
                Rectangle().aspectRatio(1, contentMode: .fit).cornerRadius(5).padding(50).shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 5).cornerRadius(5).foregroundColor(Color(red: 0.8666666666666667, green: 0.9176470588235294, blue: 0.9529411764705882)).overlay{
                    
                    Image(systemName: "photo").resizable()
                        .foregroundColor(Color.gray).frame(width: 50, height: 50).padding().aspectRatio(1.0, contentMode: .fit)
                    
                }
            }
            
            Text("End of Tutorial.").font(.title).fontWeight(.bold).foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0)).padding(.bottom)
            Text("Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum.").padding([.leading, .trailing], 40)
            
            HStack{
                Spacer()
                
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: gray)
                progressCircle(enterColor: darkBlue)
                
                Spacer()
            }.padding(20)
            HStack{
                Button(action: {
                    clickedIndex.indexClicked = 3
                    //Test API Here
                    
                   // apiTesting()
                   independentExpend()
                    
                    
                }){
                    Text("Skip").foregroundColor(Color(red: 0.035, green: 0.098, blue: 0.159)).bold()
                }
                Image(systemName: "arrow.right").foregroundColor(Color(red: 0.0, green: 0.4392156862745098, blue: 0.7529411764705882, opacity: 1.0))
            }.padding()
        }
    }
    
  
    func apiTesting(){
        
        
        
        let url = "http://www.opensecrets.org/api/?method=getLegislators&id=MN&apikey=b0f47bbe92e5b258caff59c39549a474&output=json"
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            do {
                // make sure this JSON is in the format we expect
                //https://www.advancedswift.com/swift-json-without-swiftyjson/
                //https://stackoverflow.com/questions/25475463/how-to-access-deeply-nested-dictionaries-in-swift
                
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let x = dict["response"]!["legislator"]!! as! NSArray
                for l in x{
                    let dictWithInfo = (l as! NSDictionary)["@attributes"] as! NSDictionary
                  
                    print(dictWithInfo["firstlast"] as! String)
                    print("     \(dictWithInfo["party"] as! String)")
                    
                }
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
        
        
    }
    
    
    //This was Easy. The View is hard!
    
    func independentExpend(){
        
        
        
        let url = "http://www.opensecrets.org/api/?method=independentExpend&apikey=b0f47bbe92e5b258caff59c39549a474&output=json"
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            do {
                // make sure this JSON is in the format we expect
                //https://www.advancedswift.com/swift-json-without-swiftyjson/
                //https://stackoverflow.com/questions/25475463/how-to-access-deeply-nested-dictionaries-in-swift
                
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let x = dict["response"]!["indexp"]!! as! NSArray
                for l in x{
                    let dictWithInfo = (l as! NSDictionary)["@attributes"] as! NSDictionary
                  
                    print(dictWithInfo["candname"] as! String)
                    print("     \(dictWithInfo["pacshort"] as! String)")
                    
                }
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
        
        
    }
    
    
}



struct fourthScreen_Previews: PreviewProvider {
    static var previews: some View {
        fourthScreen()
    }
}




