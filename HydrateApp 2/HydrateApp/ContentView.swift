import UIKit
import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var cups: Int = 0
    @Published var liters: Double = 0
}

struct ContentView: View {
    @State private var text: String = ""
    @State private var waterRequirement: Double = 0
    @State private var cups: Int = 0
    @FocusState private var keyboardFocused: Bool
    @State private var showNeedView: Bool = false
    @State private var isTextEmpty: Bool = true

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 70)
                    .padding(.leading)
                    .offset(x: -25, y: 30)

                Text("iHydrate")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.leading, 1)
                    .padding(.bottom, 30)
                    .offset(y: 35)

                Text("Start with iHydrate to record and track your water intake daily based on your needs and stay hydrated")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundColor(Color.fon)
                    .offset(y: 20)
            }
            .padding()
            .offset(x: 0, y: 50)

            ZStack {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.1))
                    .frame(width: 360, height: 50)
                    .cornerRadius(10)

                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Body Weight")
                            .font(.system(size: 17))
//                            .foregroundColor(.black)
                            .offset(x: 2, y: 18)

                        TextField("Weight", text: $text)
                            .keyboardType(.decimalPad)
                            .foregroundColor(text.isEmpty ? .gray : Color.fon)
                            .offset(x: 20, y: 18)
                    }

                    Text("Kg")
                        .font(.system(size: 17))
                        .offset(x: 50, y: -6)
                }
                .padding()
                .frame(width: 357, height: 44)
                .cornerRadius(3.0)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                        }) {
                            Text("Done")
                        }
                    }
                }
                .cornerRadius(8)
                .padding(.bottom)

                Spacer()
            }
            .offset(x: 0, y: 98)

            Button(action: {
                if let weight = Double(text) {
                    waterRequirement = weight * 30
                    cups = Int(waterRequirement / 0.25)
                    showNeedView.toggle()
                    hideKeyboard()
                }
            }) {
                Text("Calculate Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 55)
                    .background(isTextEmpty ? Color.back : Color.babyblue)
                    .cornerRadius(10)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .offset(x: 0, y: 320)
            .disabled(isTextEmpty)

            Spacer()

            .fullScreenCover(isPresented: $showNeedView) {
                NeedView(cups: $cups, liters: $waterRequirement)
            }

        }
        .padding(.bottom, keyboardFocused ? 0 : 20)
        .onChange(of: text) { newValue in
            isTextEmpty = newValue.isEmpty
        }
    }

    private func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
