import SwiftUI
import UserNotifications

struct Notfiction: View {
    @State private var selectedButtonTimeInterval: TimeInterval?
    @State private var isPressed = false
    @State private var startTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    @State private var endTime = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Notification Preferences")
                
                    .font(.custom("SF Pro", size: 22))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .offset(x: -50, y: -100)
                
                Text("The start and End hour")
                    .font(.custom("SF Pro", size: 17))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .offset(x: -80, y: -40)
                
                Text("Specify the start and end date to receive the notifications ")
                    .font(.custom("SF Pro", size: 13))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.gray)
                    .offset(x: 5, y: -30)
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.g1) // لون الخلفية للمربع الكبير
                        .frame(width: 358, height: 100)
                        .padding()
                        .overlay(
                            VStack {
                                HStack {
                                    Text("Start Time")
                                        .padding(.leading, 30)
                                    Spacer()
                                    DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                    
                                        .background(Color.white)
                                        .cornerRadius(40)
                                        .padding(.trailing, 160)
                                        .padding(.bottom, -8)
                                    
                                }
                                .padding(.top, 10)
                                
                                Divider()
                                    .frame(width: 300)
                                
                                HStack {
                                    Text("End Time")
                                        .padding(.leading, 30)
                                    Spacer()
                                    DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .background(Color.white)
                                        .cornerRadius(40)
                                        .padding(.trailing, 160)
                                        .padding(.bottom, 1)
                                }
                                .padding(.bottom, 10)
                            }
                        )
                    
                    //                Button(action: {
                    //                    // Handle saving the start and end times here
                    //                    print("Start Time: \(formattedTime(date: startTime)), End Time: \(formattedTime(date: endTime))")
                    //                }) {
                    //                    Text("Save")
                    //                        .padding()
                    //                        .background(Color.blue)
                    //                        .foregroundColor(.white)
                    //                        .cornerRadius(8)
                    //                }
                    //                .padding()
                }
                
                //            ZStack{
                //
                //                RoundedRectangle(cornerRadius: 10)
                //                    .fill(Color.gray.opacity(0.1))
                //                    .frame(width: 358, height: 88)
                //                    .padding()
                //                Divider()
                //                    .frame(width: 300)
                //            }
                .offset(x: 5, y: -30)
                
                Text("Notification interval")
                    .font(.custom("SF Pro", size: 17))
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .offset(x: -90, y: 35)
                
                Text("How often would you like to receive notifications within the specified time interval")
                    .font(.custom("SF Pro", size: 13))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.gray)
                    .offset(x: 10, y: 40)
                    .padding()
                
                VStack(spacing: 20) {
                    HStack{
                        IntervalButton(title: "15", timeInterval: 15, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "30", timeInterval: 30, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "60", timeInterval: 60, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "90", timeInterval: 90, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                    }
                    HStack{
                        IntervalButton(title: "2", timeInterval: 120, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "3", timeInterval: 180, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "4", timeInterval: 240, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                        IntervalButton(title: "5", timeInterval: 300, selectedButtonTimeInterval: $selectedButtonTimeInterval)
                    }
                }
                .offset(y: 50)
                
                
                NavigationLink(destination: trackerView()) { // تحديد الوجهة لصفحة Notfiction
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 55)
                        .background(Color.babyblue) // تأكد من تعريف اللون babyblue في مشروعك
                        .cornerRadius(10)
                }
                
                //            Button(action: { (trackerView)()
                //
                //                   }) {
                //                       ZStack {
                //                           RoundedRectangle(cornerRadius: 12)
                //                               .frame(width: 358, height: 50)
                //                               .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
                //                               .foregroundColor(isPressed ? Color.gray : Color.b1)
                //
                //                           Text("Start")
                //                               .font(.custom("SF Pro", size: 17))
                //                               .fontWeight(.regular)
                //                               .lineSpacing(22)
                //                               .kerning(-0.4)
                //                               .multilineTextAlignment(.leading)
                //                               .foregroundColor(Color.white)
                //                       }
                //                   }
                //                   .buttonStyle(PlainButtonStyle())
                //                   .onTapGesture {
                //                       isPressed.toggle()                    }
                .offset(y: 100)
                
            }
            
            
        }
        .navigationBarBackButtonHidden(true)

    }
        
}

struct IntervalButton: View {
    let title: String
    let timeInterval: TimeInterval
    @Binding var selectedButtonTimeInterval: TimeInterval?

    var body: some View {
        Button(action: {
            let timeInMinutes = timeInterval * 60 // تحويل الفاصل الزمني إلى الدقائق
            scheduleNotification(timeInterval: timeInMinutes)
            selectedButtonTimeInterval = timeInterval
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 78, height: 74)
                    .foregroundColor(selectedButtonTimeInterval == timeInterval ? .blue : .g1) // Check if this button's time interval matches the selected one
                VStack {
                    Text(title)
                        .foregroundColor(selectedButtonTimeInterval == timeInterval ? .white : .blue)
                        .font(Font.custom("SF Pro", size: 22))
                        .fontWeight(.bold)
                    if timeInterval < 100 {
                        Text("mins")
                            .foregroundColor(selectedButtonTimeInterval == timeInterval ? .white : .black)
                            .font(Font.custom("SF Pro", size: 13))
                            .fontWeight(.bold)
                    } else {
                        Text("hours")
                            .foregroundColor(selectedButtonTimeInterval == timeInterval ? .white : .black)
                            .font(Font.custom("SF Pro", size: 13))
                            .fontWeight(.bold)
                        
                    }
                }
            }
        }
    }
//    private func formattedTime(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
    //}
}


func scheduleNotification(timeInterval: TimeInterval) {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            let content = UNMutableNotificationContent()
            content.title = "Hydrate"
            content.body = "Don't forget to drink water"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true) // تم تعيين repeats إلى true
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Error adding notification request: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        } else {
            print("Permission denied for notifications")
        }
    }
}

struct Notfiction_Previews: PreviewProvider {
    static var previews: some View {
        Notfiction()
    }
}
