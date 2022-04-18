//
//  searchBar.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI

struct searchBar: View{
    
    @EnvironmentObject var searchQuery: GlobalVariables
    //This is in the enviorment on the firstPage
    
    //Maybe make this update dunamically, by adding a binding to the serach query
    
    //Edit var from here
    @State var text = ""
    
    
    
    var body: some View{
        ZStack{
            Rectangle().cornerRadius(8).frame(height: 40).padding(.horizontal).foregroundColor(Color(red: 248/255, green: 248/255, blue: 248/255))
            HStack{
                Spacer()
                Image(systemName: "magnifyingglass").padding()
                TextField("Search for a name", text: $searchQuery.searchText).onSubmit {
                    //                   searchQuery.searchText = text
                    //                    print(searchQuery.searchText)
                    
                    //Filter var here
                    
                    //Searching is broken.
                    
                    
                }
                ZStack{
                    Circle().frame(width: 20, height: 20).padding().foregroundColor(Color.gray)
                    Button(action:{
                        searchQuery.searchText = ""
                        text = ""
                    }){
                        Image(systemName: "xmark").resizable().frame(width: 10, height: 10).padding().foregroundColor(Color.white)
                    }
                }
                Spacer()
            }
            //Maybe keep this, idk
        }.padding(.horizontal)
    }
}
struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar()
    }
}
