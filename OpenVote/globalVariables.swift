//
//  globalVariables.swift
//  OpenVote
//
//  Created by 90310148 on 3/18/22.
//

import Foundation

struct item{
    var amount: String
    var description: String
}


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
    
    
    
    
    //Test this on Core Data
    @Published var HouseLegislatorName: [String] = []
    
    
    
    
    
    
    
    @Published var userName: String = ""
    
    
    //[name: [date: [ammount]]
    
    
    
    @Published var dictOfNames: [String: [String: [item]]] = [:]
    
    
    
    
    @Published var stockDataDoneLoading: Bool = false
    
    func getStockData(completed: @escaping (_:Bool) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: "https://house-stock-watcher-data.s3-us-west-2.amazonaws.com/data/all_transactions.json")!){ data, response, error in
                do{
                    
                  
                    let dict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
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
                        
                        DispatchQueue.main.async {
                            
                        
                        if self.dictOfNames[rep] != nil{
                            if self.dictOfNames[rep]![discDate] != nil{
                                self.dictOfNames[rep]![discDate]!.append(item(amount: amount, description: desc))
                            }else{
                                self.dictOfNames[rep]![discDate] = [item(amount: amount, description: desc)]
                            }
                        }else{
                            self.dictOfNames[rep] = [discDate : [item(amount: amount, description: desc)]]
                        }
                        
                        }
                    
                       
                    }
                    completed(true)
                }catch{
                    fatalError("FAILED")
                }
            }.resume()
            
           
            
    }
    
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
                print(response)
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
        r = URLRequest(url: url)
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
