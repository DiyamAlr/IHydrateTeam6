import SwiftUI


struct NeedView: View {
    @Binding var cups: Int
    @Binding var liters: Double
    @State private var isContentViewPresented: Bool = false
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
        VStack() {
            VStack(alignment: .leading) {
                Text("The needed water intake")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.leading, 1)
                    .padding(.bottom, 30)
                    .offset(y: 170)
                
                Text("Your body needs \(String(format: "%.1f", liters)) liters of hydration, which is equivalent to \(cups) cups")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .offset(y: 163)
                
            } .padding(.vertical, 14)
              .padding(.horizontal, 20)
              .padding(.bottom)
            ZStack() {
                Rectangle()
                    .foregroundColor(Color.g1)
                    .frame(width: 171, height: 166)
                    .cornerRadius(10)
                    .offset(x: 95)
                
                Rectangle()
                    .foregroundColor(Color.g1)
                    .frame(width: 171, height: 166)
                    .cornerRadius(10)
                    .offset(x: -95)
                
                HStack {
                    VStack{
                        Image("cup")
                            .resizable()
                            .frame(width: 60, height: 55)
                            .offset(x: -90, y: 40)
                        
                        Text("\(cups) cups")
                            .offset(x: -90, y: 50)
                        
                        
                        Image("water")
                            .resizable()
                            .frame(width: 40, height: 60)
                            .offset(x: 90, y: -65)
                        
                        Text("\(String(format: "%.1f", liters)) L")
                            .offset(x: 90, y: -50)
                    }
                }
            }.offset(x:0,y:180)
           
            Spacer()
            
            NavigationLink(destination: Notfiction()) {
                       Text("Set the notification")
                           .font(.headline)
                           .foregroundColor(.white)
                           .frame(width: 360, height: 55)
                           .background(Color.babyblue) // تأكد من تعريف اللون babyblue في مشروعك
                           .cornerRadius(10)
                   }
                   .padding(.vertical, 14)
                   .padding(.horizontal, 20)
                   .offset(x: 0, y: 150)

                   Spacer()
               }
        .navigationBarBackButtonHidden(true)
            
           }
        
        }
    }


struct NeedView_Previews: PreviewProvider {
    static var previews: some View {
        let cups = 0
        let liters = 0.0
        return ContentView()
            .environmentObject(ContentViewModel())
    }
}


//import SwiftUI
//
//
//struct NeedView: View {
//    @Binding var cups: Int
//    @Binding var liters: Double
//    @State private var isContentViewPresented: Bool = false
//    @EnvironmentObject var viewModel: ContentViewModel
//    
//    var body: some View {
//        NavigationView {
//        VStack() {
//            VStack(alignment: .leading) {
//                Text("The needed water intake")
//                    .font(.system(size: 22))
//                    .fontWeight(.bold)
//                    .padding(.leading, 1)
//                    .padding(.bottom, 30)
//                    .offset(y: 170)
//                
//                Text("Your body needs \(String(format: "%.1f", liters)) liters of hydration, which is equivalent to \(cups) cups")
//                    .font(.system(size: 17))
//                    .fontWeight(.regular)
//                    .foregroundColor(Color.gray)
//                    .offset(y: 163)
//                
//            } .padding(.vertical, 14)
//              .padding(.horizontal, 20)
//              .padding(.bottom)
//            ZStack() {
//                Rectangle()
//                    .foregroundColor(Color.g1)
//                    .frame(width: 171, height: 166)
//                    .cornerRadius(10)
//                    .offset(x: 95)
//                
//                Rectangle()
//                    .foregroundColor(Color.g1)
//                    .frame(width: 171, height: 166)
//                    .cornerRadius(10)
//                    .offset(x: -95)
//                
//                HStack {
//                    VStack{
//                        Image("cup")
//                            .resizable()
//                            .frame(width: 60, height: 55)
//                            .offset(x: -90, y: 40)
//                        
//                        Text("\(cups) cups")
//                            .offset(x: -90, y: 50)
//                        
//                        
//                        Image("water")
//                            .resizable()
//                            .frame(width: 40, height: 60)
//                            .offset(x: 90, y: -65)
//                        
//                        Text("\(String(format: "%.1f", liters)) L")
//                            .offset(x: 90, y: -50)
//                    }
//                }
//            }.offset(x:0,y:180)
//           
//            Spacer()
//            
//            NavigationLink(destination: Notfiction(cups: $cups, liters: $liters)) { // تحديد الوجهة لصفحة Notfiction
//                       Text("Set the notification")
//                           .font(.headline)
//                           .foregroundColor(.white)
//                           .frame(width: 360, height: 55)
//                           .background(Color.babyblue) // تأكد من تعريف اللون babyblue في مشروعك
//                           .cornerRadius(10)
//                   }
//                   .padding(.vertical, 14)
//                   .padding(.horizontal, 20)
//                   .offset(x: 0, y: 150)
//
//                   Spacer()
//               }
//        .navigationBarBackButtonHidden(true)
//            
//           }
//        
//        }
//    }
//
//
//struct NeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        let cups = 0
//        let liters = 0.0
//        return ContentView()
//            .environmentObject(ContentViewModel())
//    }
//}
