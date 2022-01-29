//
//  MainScreen.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    @State private var selection = 0
    @State private var showingSettings = false
    @State private var showingAchievements = false
    var navButtons: some View {
        HStack {
        Button(action: {
            self.showingAchievements.toggle()
        }) {
            Image(systemName: "star")
            .foregroundColor(Color.blue)
            .imageScale(.large)
        }.padding(.trailing, 14.0).sheet(isPresented: self.$showingAchievements) {
            AchievementsView(getsPresented: self.$showingAchievements)
            .environmentObject(self.userData)
        }
            Button(action: {
                self.showingSettings.toggle()
            }) {
                Image(systemName: "gear")
                .foregroundColor(Color.blue)
                    .padding(.trailing, 6.0)
                    .imageScale(.large)
            }.sheet(isPresented: self.$showingSettings) {
                SettingsView(getsPresented: self.$showingSettings)
                .environmentObject(self.userData)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .bottomLeading) {
                    TabView(selection: self.$selection) {
                        
                        RequestView()
                            .padding(.top)
                            .environmentObject(self.userData)
                            .tabItem {
                                if self.selection == 0 {
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                        .imageScale(.large)
                                } else {
                                    Image(systemName: "arrowshape.turn.up.right")
                                    .imageScale(.large)
                                }
                        }
                        .tag(0)
                        
                        RespondView(currentFeelings: [Feeling(feeling_text: "Test Text", device_id: "preview", is_healthcare: "0")])
                            .padding(.top)
                            .environmentObject(self.userData)
                        .tabItem {
                            if self.selection == 1 {
                                    Image(systemName: "bubble.left.fill")
                                    .imageScale(.large)
                                } else {
                                    Image(systemName: "bubble.left")
                                    .imageScale(.large)
                                }
                        }
                        .tag(1)
                        
                        InboxView()
                            .padding(.top)
                            .environmentObject(self.userData)
                        .tabItem {
                            if self.selection == 2 {
                                    Image(systemName: "envelope.fill")
                                    .imageScale(.large)
                                } else {
                                    Image(systemName: "envelope")
                                    .imageScale(.large)
                                }
                        }
                        .tag(2)
                    }
                        
                    // Badge View
                    ZStack {
                        Circle()
                            .foregroundColor(Color.red)
                    }
                    .frame(width: 15, height: 15)
                    .offset(x: ( ( 2 * 3.0) - 1 ) * ( geometry.size.width / ( 2 * 3.0 ) ), y: -30)
                    .opacity(self.userData.badgeOpacity)
                    .navigationBarTitle(Text(self.getTitle()), displayMode: .inline)
                    .navigationBarItems(trailing: self.navButtons)
                }
            }
        }.onAppear(perform: {
            // Connect to the server and retrieve an array of responses
            let url = URL(string: "https://virusesarentalive.com/getResponses.php")
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                guard let data = data, error == nil else { print(error!); return }
                let decoder = JSONDecoder()
                var responses = try! decoder.decode([Response].self, from: data)
                
                // Remove responses from the array from blocked IDs
                if !self.userData.blockList.isEmpty {
                    responses.removeAll(where: {
                        self.userData.blockList.contains($0.sender_id)
                    })
                }

                // Check the array for responses for the user
                var newResponses: [Response] = [Response]()
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                    for eachResponse in responses {
                        if eachResponse.device_id == UUID {
                            newResponses.append(eachResponse)
                        }
                    }
                }
                
                // Check to see if the array is empty
                if newResponses.isEmpty {
                    DispatchQueue.main.async {
                        self.userData.badgeOpacity = 0.0
                    }
                } else {
                    DispatchQueue.main.async {
                        self.userData.badgeOpacity = 1.0
                    }
                }
                
            }).resume()
        })
    }
    
    
    func getTitle() -> String {
        if selection == 0 {
            return "Request"
        } else if selection == 1 {
            return "Respond"
        } else {
            return "Inbox"
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen().environmentObject(UserData())
    }
}
