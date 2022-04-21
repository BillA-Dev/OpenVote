//
//  HomeScreen.swift
//  OpenVote
//
//  Created by 90310148 on 4/18/22.
//

import SwiftUI

//https://blckbirds.com/post/charts-in-swiftui-part-1-bar-chart/

struct chartData: Identifiable, Equatable{
    var id = UUID()
    var label: String
    var value: Double
}

struct barCharView:View{
    var title: String
    var legend: String
    var chartColor: Color
    var data: [chartData]
    
    @State var val = 0.0
    
    var maxVal: Double
    
    @State private var touchLocation: CGFloat = 0
    
    
    @State var loc: Int = 0
    
    init(title: String, legend: String, chartColor: Color, data: [chartData]){
        func getMaximumValue() -> Double{
            var max = 0.0
            for x in data{
                if x.value > max{
                    max = x.value
                }
            }
            return max
        }
        
        self.title = title
        self.legend = legend
        self.chartColor = chartColor
        self.data = data
        
        self.maxVal = getMaximumValue()
    }
    
    var body: some View{
        let _ = print(maxVal)
        GeometryReader{geometry in
        VStack{
            VStack(alignment: .leading){
                Text(title).font(.largeTitle)
                Text("Value \(val)").font(.headline)
                
            }
            HStack{
                ForEach(data){ i in
                    
                    barChartCell(height: i.value != maxVal ? i.value/maxVal : 1, color: Color.blue)
                    //Figure out when chart is tounced
                        .animation(.spring(), value: i)
                        .padding(.top)
                        .onChange(of: loc) { newValue in
                            print(loc)
                        }
                }
            }.gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ position in
                print(position.location.x)
                let touchPosition = position.location.x/geometry.frame(in: .local).width
                loc = Int(touchPosition * CGFloat(data.count))
                //print(touchLocation)
                
            })
                        .onEnded({ position in
                //touchLocation = 0
                loc = 0
            })
            )
        }.padding()
        }
    }
    
    
    
}
struct barChartCell: View{
    var height: Double
    var color: Color
    var body: some View{
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .scaleEffect(CGSize(width: 1, height: height), anchor: .bottom)
    }
}

struct HomeScreen: View {
    
    let chartDataArr = [
        chartData(label: "Quarter 1", value: 2000),
        chartData(label: "Quarter 2", value: 3000),
        chartData(label: "Quarter 3", value: 1000),
        chartData(label: "Quarter 4", value: 5000)
    ]
    
    var body: some View {
        Text("TEST")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
