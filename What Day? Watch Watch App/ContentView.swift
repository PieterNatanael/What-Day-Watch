//
//  ContentView.swift
//  What Day? Watch Watch App
//
//  Created by Pieter Yoshua Natanael on 14/05/24.
//



import SwiftUI

// Main view of the app
struct ContentView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    @State private var showExplain = false

    var body: some View {
        VStack {
            header // Header section
            datePickers // Date pickers section
            formattedDateText // Formatted date display
        }
        .padding()
        .sheet(isPresented: $showExplain) {
            ShowExplainView(onConfirm: { showExplain = false })
        }
    }
    
    // Header section with title and info button
    private var header: some View {
        HStack {
            Text("What Day?")
                .font(.title3)
            Spacer()
            Button(action: { showExplain = true }) {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    // Date pickers for day, month, and year selection
    private var datePickers: some View {
        HStack {
            Picker("Day", selection: $selectedDay) {
                ForEach(1...daysInMonth(year: selectedYear, month: selectedMonth), id: \.self) { day in
                    Text(String(format: "%02d", day)).tag(day)
                }
            }
            .frame(width: 40)
            .clipped()
            
            Picker("Month", selection: $selectedMonth) {
                ForEach(1...12, id: \.self) { month in
                    Text(String(format: "%02d", month)).tag(month)
                }
            }
            .frame(width: 50)
            .clipped()
            
            Picker("Year", selection: $selectedYear) {
                ForEach(1800...2300, id: \.self) { year in
                    Text(yearFormatted(year: year))
                        .font(.footnote)
                        .tag(year)
                }
            }
            .frame(width: 60)
            .clipped()
        }
    }
    
    // Display the formatted date based on user selection
    private var formattedDateText: some View {
        Text(getFormattedDate(year: selectedYear, month: selectedMonth, day: selectedDay))
            .font(.headline)
    }
    
    // Helper function to format the year
    private func yearFormatted(year: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? "\(year)"
    }
    
    // Helper function to calculate the number of days in a given month and year
    private func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents), let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30 // Default to 30 if date calculation fails
    }
    
    // Helper function to format the selected date as a string
    private func getFormattedDate(year: Int, month: Int, day: Int) -> String {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy EEEE"
            return dateFormatter.string(from: date)
        }
        return "Invalid date" // Fallback message if date calculation fails
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// View that explains ads and app functionality
struct ShowExplainView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                sectionHeader(title: "Ads & App Functionality")
//                Image("threedollar")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .cornerRadius(25)
//                    .clipped()
                
                appCardsSection
                
                sectionHeader(title: "App Functionality")
                Text("""
                • Users can scroll to choose a date.
                • The app displays the corresponding day of the week for the selected date.
                • It can show results for dates ranging from the year 1800 to 2300.
                """)
                .font(.caption2)
                .multilineTextAlignment(.leading)
                .padding()
                
                Spacer()
                
                Button("Close") {
                    onConfirm()
                }
                .font(.title3)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .padding()
            .cornerRadius(15.0)
            .padding()
        }
    }
    
    // Helper function for section headers
    private func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.title3.bold())
            Spacer()
        }
        .padding(.bottom, 5)
    }
    
    // Section containing app cards ads with descriptions
    private var appCardsSection: some View {
        VStack {
            AppCardView(imageName: "sos", appName: "SOS Light", appDescription: "SOS Light is designed to maximize the chances of getting help in emergency situations.", appURL: "https://apps.apple.com/app/s0s-light/id6504213303")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "takemedication", appName: "Take Medication", appDescription: "Just press any of the 24 buttons, each representing an hour of the day, and you'll get timely reminders to take your medication. It's easy, quick, and ensures you never miss a dose!", appURL: "https://apps.apple.com/id/app/take-medication/id6736924598")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "Announce the time every 30 seconds, no more guessing and checking your watch, for time-sensitive tasks.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "worry", appName: "Worry Bin", appDescription: "A place for worry.", appURL: "https://apps.apple.com/id/app/worry-bin/id6498626727")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Designed to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
            Divider().background(Color.gray)
            
//            AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
//            Divider().background(Color.gray)
            
            AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
            Divider().background(Color.gray)
            
            AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
            Divider().background(Color.gray)
        }
    }
}

// View representing a card with ads information
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption2)
            }
            .frame(alignment: .leading)
            
            Spacer()
            
            Button(action: {
                openURL(appURL)
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

// Helper function to open URLs
func openURL(_ urlString: String) {
    if let url = URL(string: urlString) {
        WKExtension.shared().openSystemURL(url)
    }
}








/*

//great but try to improve

import SwiftUI

struct ContentView: View {
    @State private var selectedYear = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    @State private var showExplain: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text("What Day?")
                    .font(.title3)
                Spacer()
                Button(action: {
                    showExplain = true
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                .buttonStyle(PlainButtonStyle())
            }
            HStack {
                Picker("Day", selection: $selectedDay) {
                    ForEach(1...daysInMonth(year: selectedYear, month: selectedMonth), id: \.self) { day in
                        Text(String(format: "%02d", day)).tag(day)
                    }
                }
                .frame(width: 40)
                .clipped()
                
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(String(format: "%02d", month)).tag(month)
                    }
                }
                .frame(width: 50)
                .clipped()
                
                Picker("Year", selection: $selectedYear) {
                    ForEach(1800...2300, id: \.self) { year in
                        Text(yearFormatted(year: year))
                            .font(.footnote)
                            .tag(year)
                    }
                }
                .frame(width: 60)
                .clipped()
                
             
                
                
            }
            
            Text(getFormattedDate(year: selectedYear, month: selectedMonth, day: selectedDay))
                .font(.headline)
        }
        .sheet(isPresented: $showExplain) {
            ShowExplainView(onConfirm: {
                showExplain = false
            })
        }
        .padding()
    }
    
    func yearFormatted(year: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? "\(year)"
    }
    
    func daysInMonth(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents), let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }
    
    func getFormattedDate(year: Int, month: Int, day: Int) -> String {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy EEEE"
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShowExplainView: View {
    var onConfirm: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        Text("Ads & App functionality")
                            .font(.title3.bold())
                        Spacer()
                    }
                    ZStack {
                        Image("threedollar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(25)
                            .clipped()
    //                        .onTapGesture {
    //                            openURL("https://b33.biz/three-dollar/")
    //                        }
                    }
                    // App Cards
                    HStack {
                        Text("Three Dollar Apps")
                            .font(.caption.bold())
                            .padding()
                        Spacer()
                    }
                    Divider().background(Color.gray)

                    VStack {
                        AppCardView(imageName: "bodycam", appName: "BODYCam", appDescription: "Record videos effortlessly and discreetly.", appURL: "https://apps.apple.com/id/app/b0dycam/id6496689003")
                        Divider().background(Color.gray)
                        // Add more AppCardViews here if needed
                        // App Data
                     
                        
                        AppCardView(imageName: "timetell", appName: "TimeTell", appDescription: "It will tell the time every 30 seconds—just listen, no more guessing or checking your watch—for time-sensitive tasks, workouts, and mindfulness exercises.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "worry", appName: "Worry Bin", appDescription: "A place for worry.", appURL: "https://apps.apple.com/id/app/worry-bin/id6498626727")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "loopspeak", appName: "LOOPSpeak", appDescription: "Type or paste your text, play in loop, and enjoy hands-free narration.", appURL: "https://apps.apple.com/id/app/loopspeak/id6473384030")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "insomnia", appName: "Insomnia Sheep", appDescription: "Design to ease your mind and help you relax leading up to sleep.", appURL: "https://apps.apple.com/id/app/insomnia-sheep/id6479727431")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "dryeye", appName: "Dry Eye Read", appDescription: "The go-to solution for a comfortable reading experience, by adjusting font size and color to suit your reading experience.", appURL: "https://apps.apple.com/id/app/dry-eye-read/id6474282023")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "iprogram", appName: "iProgramMe", appDescription: "Custom affirmations, schedule notifications, stay inspired daily.", appURL: "https://apps.apple.com/id/app/iprogramme/id6470770935")
                        Divider().background(Color.gray)
                        
                        AppCardView(imageName: "temptation", appName: "TemptationTrack", appDescription: "One button to track milestones, monitor progress, stay motivated.", appURL: "https://apps.apple.com/id/app/temptationtrack/id6471236988")
                        Divider().background(Color.gray)
                    
                    }
                    Spacer()

                
                }
                .padding()
                .cornerRadius(15.0)
                .padding()
               
                HStack {
                    Text("App Functionality")
                        .font(.title3.bold())
                    Spacer()
                }
                
               Text("""
               • Users can scroll to choose a date.
               • The app displays the corresponding day of the week for the selected date.
               • It can show results for dates ranging from the year 1800 to 2300.
               """)
               .font(.caption2)
               .multilineTextAlignment(.leading)
               .padding()
               
               Spacer()

               Button("Close") {
                   // Perform confirmation action
                   onConfirm()
               }
               .font(.title3)
               .padding()
               .cornerRadius(25.0)
               .padding()
           }
           .padding()
           .cornerRadius(15.0)
           .padding()
        }
    }
}


// MARK: - App Card View
struct AppCardView: View {
    var imageName: String
    var appName: String
    var appDescription: String
    var appURL: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text(appName)
                    .font(.title3)
                Text(appDescription)
                    .font(.caption2)
            }
            .frame(alignment: .leading)
            
            Spacer()
            Button(action: {
                openURL(appURL)
            }) {
                Text("Try")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// Helper function to open URLs on watchOS
func openURL(_ urlString: String) {
    if let url = URL(string: urlString) {
        WKExtension.shared().openSystemURL(url)
    }
}

*/
