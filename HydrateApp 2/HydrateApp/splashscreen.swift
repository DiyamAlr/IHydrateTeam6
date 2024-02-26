import SwiftUI

struct logo: View {
    @State private var isActive: Bool = false
    @State private var scale: CGFloat = 6
    
    var body: some View {
        if isActive
            
        {
            
            ContentView()
            
        }
        else{
            VStack{
                
                ZStack {
                    
                    
                    Image("icon3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 15)
                        .scaleEffect(scale)
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    withAnimation(.easeIn(duration: 3)) {
                        self.scale = 17
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }}
            }}}}
//}
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        logo()
    }
}

