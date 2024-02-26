import SwiftUI

struct splash: View {
   
    @State private var isActive: Bool = false
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            if isActive {
                track()
            } else {
                ZStack {
                    Image("icon3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .scaleEffect(scale)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        self.scale = 4
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        splash()
    }
}
