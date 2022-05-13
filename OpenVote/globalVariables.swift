//
//  globalVariables.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import Foundation

class GlobalVariables: ObservableObject{
    @Published var indexClicked: Int = 0
    @Published var searchText: String = ""
    @Published var nameArr: [String] = []
    @Published var filteredNameArr: [String] = []
    
    
    @Published var tutorialSkipped: Bool = false
    
    @Published var arrayOfPeople: [people] = []
    
    @Published var isApiDoneLoading: Bool = false
    
    @Published var isShowingInfoScreen: Bool = false
    
 
    @Published var isShowingFilterScreen: Bool = false
    
    
    @Published var amountValue: Float = 5.0
    
    @Published var sliderAmmount: Float = 1_500_000
    
    
    @Published var HouseLegislatorName: [String] = []
    
    @Published var userName: String = ""
    
    func getLegislators(){
        
        //https://stackoverflow.com/questions/67455466/how-to-add-http-header-in-swiftui-and-how-to-get-data-from-json
        
        
        let apiKey = "TVzFYhCZNQl5znRgQkhZTnyXB2bRPEd5GAIvev77"
        guard var url = URL(string: "https://api.propublica.org/congress/v1/117/house/members.json") else {
                    fatalError("Invalid URL")
        }
        
        var r = URLRequest(url: url)
        r.httpMethod = "GET"
        r.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        URLSession.shared.dataTask(with: r){ data, response, error in
            
            do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let results = dict["results"] as! NSArray
                let members = (results[0] as! NSDictionary)["members"] as! NSArray
                for x in members{
                   let di = x as! NSDictionary
                    DispatchQueue.main.async {
                        self.HouseLegislatorName.append("\(di["first_name"] as! String) \(di["last_name"] as! String)")
                    }
                }
                
            
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            
        }.resume()
        
        url = URL(string: "https://api.propublica.org/congress/v1/117/senate/members.json")!
        URLSession.shared.dataTask(with: r){ data, response, error in
            
            do{
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let results = dict["results"] as! NSArray
                let members = (results[0] as! NSDictionary)["members"] as! NSArray
                for x in members{
                   let di = x as! NSDictionary
                    
                    DispatchQueue.main.async {
                        self.HouseLegislatorName.append("\(di["first_name"] as! String) \(di["last_name"] as! String)")
                    }
                    
                    
                    
                }
                
            
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            
        }.resume()
        
        
    }
    
    
    func independentExpend(){
        
        
            
        
        print("THIS FUNCTION IS RUNNING")
        //API Should Work
        let url = "http://www.opensecrets.org/api/?method=independentExpend&apikey=94b9a047921d79a4d77286e1b48c2175&output=json"
        
        let g = DispatchGroup()
        //https://stackoverflow.com/questions/68431272/swift-wait-until-the-urlsession-finished
        //This is for knowing when API IS DONE LOADING
        
        
        
        g.enter()
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            do {
                
                defer{
                    g.leave()
                }
                // make sure this JSON is in the format we expect
                //https://www.advancedswift.com/swift-json-without-swiftyjson/
                //https://stackoverflow.com/questions/25475463/how-to-access-deeply-nested-dictionaries-in-swift
                
                let dict = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                let x = dict["response"]!["indexp"]!! as! NSArray
                for l in x{
                    let dictWithInfo = (l as! NSDictionary)["@attributes"] as! NSDictionary
                    
               
                    DispatchQueue.main.async {
                        
                    
                    self.arrayOfPeople.append(people(name: dictWithInfo["candname"] as! String, pacInfo: dictWithInfo["pacshort"] as! String, date: self.formatDates(date: dictWithInfo["date"] as! String), party: dictWithInfo["party"] as! String, amount: dictWithInfo["amount"] as! String, district: dictWithInfo["district"] as! String))
                        
                    }

                    
                }
                
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
        
        //TEST
        
        
        g.notify(queue: .main) {
            
        }
        
        
        
        
    }
    
    private func formatDates(date: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return (dateFormatterPrint.string(from: date))
        }else{
            return "null"
        }
        
    }
}
