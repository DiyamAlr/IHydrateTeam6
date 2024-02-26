
//
//  trackerView.swift
//  HydrateApp
//
//  Created by Diyam Alrabah on 03/08/1445 AH.
//

import SwiftUI

struct trackerView: View {
    @State var countLitter = 0.0
    @State var maxLitter = 3.0
    // @Binding var cups: Int
     //@Binding var liters: Double
     @State var isClicked = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var selectedCups: [Int] = []
    //@Binding
    
    
    var body: some View {
        VStack{
            
            Text("Today's Water Intake")
                .foregroundColor(.tintedGray)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .padding(.trailing,200)
                .padding(.top,50)
                .padding(.bottom,-1000)
            TabView{
                
                VStack{
                    Text ("\(countLitter, specifier: "%.2f")/\(maxLitter, specifier: "%.2f")")
                        .font(.largeTitle)
                        .padding(.top,-50)
                        .padding(.trailing,180)
                        .padding(.bottom,50)
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 35)
                            .frame(width: 250, height:250 )
                            .foregroundColor(.skyBlue)
                            .shadow(color:.black.opacity(0.1) ,radius: 10, x: 10, y: 10)
                        Circle()
                            .stroke(lineWidth: 0.34)
                            .frame(width: 225, height:225 )
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading ))
                            .overlay{
                                Circle()
                                    .stroke(.black.opacity(0.1), lineWidth: 2)
                                    .blur(radius: 5)
                                    .mask{
                                        Circle()
                                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.darkBlue,.clear]), startPoint: .topLeading, endPoint:.bottomTrailing ))
                                    }
                            }
                        Circle()
                            .trim(from:0 , to: CGFloat(min(self.countLitter/maxLitter,1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 35,lineCap: .round))
                            .frame(width: 250, height: 250)
                            .rotationEffect(.degrees(-90))
                                                    .overlay(
                                                        emojiOverlay
                                                    )
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.darkBlue,.clear]), startPoint: .topLeading, endPoint:.bottomTrailing ))
                        if abs(countLitter - maxLitter) < 0.001 {
                            Text("🥳")
                                .font(.system(size: 60))
                                .offset(y: 0)
                            
                        }
                    }// ZStack
                        HStack {
                            Button(action: {
                                if self.countLitter > 0.0 {
                                    self.countLitter -= 0.1
                                }                        }) {
                                    Image(systemName: "minus.circle")
                                        .font(.largeTitle)
                                }
                                .tint(.darkBlue)
                                .padding(50)
                            Spacer()
                            Text("\(countLitter, specifier: "%.2f")")
                                .padding(.trailing, 20)
                                .font(.largeTitle)
                               
                            Button(action: {
                                if self.countLitter < maxLitter {
                                    self.countLitter += 0.1
                                }
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.largeTitle)
                            }
                            .tint(.darkBlue)
                            .padding(50)
                        }
                        Text("Swipe right for cups calculating")
                            .foregroundColor(.tintedGray)
                            .multilineTextAlignment(.center)
                            .padding(.top,70)
                            .padding(.bottom,-2000)
                        
                        
                    }//end 0f VStack
                
                    VStack {
                        Text ("**Cups/total**")
                            .font(.largeTitle)
                            .padding(.top,-50)
                            .padding(.trailing,190)
                            .padding(.bottom,40)
                        VStack{
                            ZStack{
//                                RoundedRectangle(cornerRadius: 10)
//                                    .frame(width: 340, height: 400)
//                                    .foregroundColor(.white)
//                                    .offset(CGSize(width: -1, height: -10))
                                HStack{
                                    LazyVGrid(columns: columns){     ForEach(0..<20) { i in
                                        VStack{  Image(systemName: selectedCups.contains(i) ? "drop.fill" : "drop")
                                            
                                                .foregroundColor(.darkBlue)
                                            Text("1 Cup")
                                                .font(.caption2)
                                                .foregroundColor(.tintedGray)
                                        }
                                        .font(.title)
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            if selectedCups.contains(i){
                                                selectedCups.removeAll {$0 == i}
                                            }
                                            else{
                                                selectedCups.append(i)
                                            }
                                            
                                        }
                                    }
                                    }//ForEach
                                }//HStack
                            }//end 0f ZStack
                        } //end of VStack
                        Text("Swipe lift for liters calculating")
                            .foregroundColor(.tintedGray)
                            .multilineTextAlignment(.center)
                            .padding(.top,80)
                            .padding(.bottom,-2000)
                    }//Vstack
                    
                }//TabView
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
            }//VStack
        .navigationBarBackButtonHidden(true)
            
        }
    private func getEmojiForWaterLevel() -> String {
        if countLitter <= 0.0 {
            return "😴"
        } else if countLitter > 0.01 && countLitter < 0.8 {
            return "😃"
        } else if countLitter > 0.8 && countLitter < 1.5 {
            return "😁"
        } else if countLitter > 1.5 && countLitter < 3.0 {
            return "😍"
        } else {
            return " "
        }
    }
    
    private var emojiOverlay: some View {
        GeometryReader { geometry in
            let angle = 360 * (countLitter / maxLitter) - 90
            // Starting angle of the progress bar
            
            // Check if progress is complete and adjust the position accordingly
            let xPosition: CGFloat
            let yPosition: CGFloat
            
            if countLitter >= maxLitter {
                // If progress is complete, position emoji in the center
                xPosition = geometry.size.width / 2
                yPosition = geometry.size.height / 2
            } else {
                // If progress is not complete, position emoji based on angle
                xPosition = geometry.size.width / 2 + (geometry.size.width / 2) * cos(angle * .pi / 180)
                yPosition = geometry.size.height / 2 + (geometry.size.height / 2) * sin(angle * .pi / 180)
            }
            
            return Text(getEmojiForWaterLevel())
                .font(.system(size: 50))
                .position(x: xPosition, y: yPosition)
        }
    }

}

#Preview {
    trackerView()
}

       // .navigationBarBackButtonHidden(true) //VStack
        


//import SwiftUI
//
//struct trackerView: View {
//    @State var countLitter = 0.0
//    @State var maxLitter = 3.0
//    @Binding var cups: Int
//    @Binding var liters: Double
//    @State var isClicked = false
//
//    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
//    @State var selectedCups: [Int] = []
//
//    var body: some View {
//        VStack {
//            Text("Today's Water Intake")
//                .foregroundColor(.tintedGray)
//                .multilineTextAlignment(.leading)
//                .padding(.trailing, 200)
//                .padding(.top, 50)
//                .padding(.bottom, -1000)
//
//            TabView {
//                VStack {
//                    Text("**Liters/total**")
//                        .font(.largeTitle)
//                        .padding(.top, -50)
//                        .padding(.trailing, 180)
//                        .padding(.bottom, 50)
//
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 35)
//                            .frame(width: 250, height: 250)
//                            .foregroundColor(.skyBlue)
//                            .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
//
//                        Circle()
//                            .trim(from: 0, to: CGFloat(min(self.countLitter / self.liters, 1.0)))
//                            .stroke(style: StrokeStyle(lineWidth: 35, lineCap: .round))
//                            .frame(width: 250, height: 250)
//                            .rotationEffect(.degrees(-90))
//                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.darkBlue, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                            .overlay(emojiOverlay)
//
//                        if abs(countLitter - liters) < 0.001 {
//                            Text("🥳")
//                                .font(.system(size: 60))
//                                .offset(y: 0)
//                        }
//                    }
//
//                    HStack {
//                        Button(action: {
//                            if self.countLitter > 0.0 {
//                                self.countLitter -= 0.1
//                            }
//                        }) {
//                            Image(systemName: "minus.circle")
//                                .font(.largeTitle)
//                        }
//                        .tint(.darkBlue)
//                        .padding(50)
//
//                        Spacer()
//
//                        Text("\(countLitter, specifier: "%.2f")")
//                            .padding(.trailing, 20)
//                            .font(.largeTitle)
//                            .foregroundColor(.black)
//
//                        Button(action: {
//                            if self.countLitter < liters {
//                                self.countLitter += 0.1
//                            }
//                        }) {
//                            Image(systemName: "plus.circle")
//                                .font(.largeTitle)
//                        }
//                        .tint(.darkBlue)
//                        .padding(50)
//                    }
//                    Text("Swipe right for cups calculating")
//                        .foregroundColor(.tintedGray)
//                        .multilineTextAlignment(.center)
//                        .padding(.top, 55)
//                        .padding(.bottom, -2000)
//                }
//
//                VStack {
//                    Text("**Cups/total**")
//                        .font(.largeTitle)
//                        .padding(.top, -50)
//                        .padding(.trailing, 190)
//                        .padding(.bottom, 40)
//
//                    VStack {
//                        ZStack {
//                            HStack {
//                                LazyVGrid(columns: columns) {
//                                    ForEach(0..<20) { i in
//                                        VStack {
//                                            Image(systemName: selectedCups.contains(i) ? "drop.fill" : "drop")
//                                                .foregroundColor(.darkBlue)
//                                            Text("1 Cup")
//                                                .font(.caption2)
//                                                .foregroundColor(.tintedGray)
//                                        }
//                                        .font(.title)
//                                        .foregroundColor(.blue)
//                                        .onTapGesture {
//                                            if selectedCups.contains(i) {
//                                                selectedCups.removeAll { $0 == i }
//                                            } else {
//                                                selectedCups.append(i)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//
//                    Text("Swipe lift for liters calculating")
//                        .foregroundColor(.tintedGray)
//                        .multilineTextAlignment(.center)
//                        .padding(.top, 80)
//                        .padding(.bottom, -2000)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//    private var emojiOverlay: some View {
//        GeometryReader { geometry in
//            let progress = self.countLitter / self.liters
//            let angle = 2 * CGFloat.pi * progress - CGFloat.pi / 2
//            let radius = geometry.size.width / 2
//
//            let xPosition = radius * cos(angle) + geometry.size.width / 2
//            let yPosition = radius * sin(angle) + geometry.size.height / 2
//
//            return Text(getEmojiForWaterLevel())
//                .font(.system(size: 50))
//                .position(x: xPosition, y: yPosition)
//        }
//    }
//
//    private func getEmojiForWaterLevel() -> String {
//        if countLitter <= 0.0 {
//            return "😴"
//        } else if countLitter > 0.01 && countLitter < 0.8 {
//            return "😃"
//        } else if countLitter > 0.8 && countLitter < 1.5 {
//            return "😁"
//        } else if countLitter > 1.5 && countLitter < 3.0 {
//            return "😍"
//        } else {
//            return "🥳"
//        }
//    }
//}
//
//struct trackerView_Previews: PreviewProvider {
//    static var previews: some View {
//        trackerView(cups: .constant(0), liters: .constant(2.0))
//    }
//}
