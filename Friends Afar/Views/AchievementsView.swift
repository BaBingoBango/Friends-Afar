//
//  AchievementsView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/15/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct AchievementsView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    @Binding var getsPresented: Bool
    var doneButton: some View {
        Button(action: {
            self.getsPresented.toggle()
            print(self.getsPresented)
        }) {
                Text("Done")
                    .fontWeight(.bold)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        
                    // NONE
                        if (userData.numRequests == 0 && userData.numResponses == 0 && userData.numInbox == 0) {
                            Text("You don't have any achievements yet!")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                        }
                        
                        
                    // BRONZE
                        if (userData.numRequests >= 1 || userData.numResponses >= 1 || userData.numInbox >= 1) {
                            Text("Bronze")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding([.top, .leading, .trailing])
                        }
                        
                        // Request
                        if (userData.numRequests >= 1) {
                            AchievementView(type: "b", name: "Requester", desc: "You uploaded a Feeling!")
                                .padding(.horizontal)
                        }
                        if (userData.numRequests >= 5) {
                            AchievementView(type: "b", name: "Upload Here Often?", desc: "You uploaded 5 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numRequests >= 10) {
                            AchievementView(type: "b", name: "Requesting Regular", desc: "You uploaded 10 Feelings!")
                                .padding(.horizontal)
                        }
                        
                        // Respond
                        if (userData.numResponses >= 1) {
                            AchievementView(type: "b", name: "Listener", desc: "You responded to a Feeling!")
                                .padding(.horizontal)
                        }
                        if (userData.numResponses >= 5) {
                            AchievementView(type: "b", name: "Good Listener", desc: "You responded to 5 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numResponses >= 10) {
                            AchievementView(type: "b", name: "Great Listener", desc: "You responded to 10 Feelings!")
                                .padding(.horizontal)
                        }
                        
                        // Inbox
                        if (userData.numInbox >= 1) {
                            AchievementView(type: "b", name: "Passerby", desc: "You've received a response!")
                                .padding(.horizontal)
                        }
                        if (userData.numInbox >= 5) {
                            AchievementView(type: "b", name: "Acquaintance", desc: "You've received 5 responses!")
                                .padding(.horizontal)
                        }
                    }
                    VStack(alignment: .leading) {
                    
                    // SILVER
                    if (userData.numRequests >= 50 || userData.numResponses >= 50 || userData.numInbox >= 25) {
                        Text("Silver")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding([.top, .leading, .trailing])
                        
                    }
                        if (userData.numRequests >= 50) {
                            AchievementView(type: "s", name: "Feelings Fanatic", desc: "You uploaded 50 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numResponses >= 50) {
                            AchievementView(type: "s", name: "Active Listener", desc: "You responded to 50 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numInbox >= 25) {
                            AchievementView(type: "s", name: "Friend", desc: "You've received 25 responses!")
                                .padding(.horizontal)
                        }
                        if (userData.numInbox >= 100) {
                            AchievementView(type: "s", name: "Best Friend", desc: "You've received 50 responses!")
                                .padding(.horizontal)
                        }
                    }
                    VStack(alignment: .leading) {
                    
                    // GOLD
                    if (userData.numRequests >= 100 || userData.numResponses >= 100 || userData.numInbox >= 200) {
                        Text("Gold")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding([.top, .leading, .trailing])
                        
                    }
                        if (userData.numRequests >= 100) {
                            AchievementView(type: "g", name: "Feelings Authority", desc: "You uploaded 100 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numResponses >= 100) {
                            AchievementView(type: "g", name: "Listening Lord", desc: "You responded to 100 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numResponses >= 200) {
                            AchievementView(type: "g", name: "Responding Authority", desc: "You responded to 200 Feelings!")
                                .padding(.horizontal)
                        }
                        if (userData.numInbox >= 200) {
                            AchievementView(type: "g", name: "BFF", desc: "You've received 200 responses!")
                                .padding(.horizontal)
                        }
                        if (userData.numInbox >= 500) {
                            AchievementView(type: "g", name: "Popularity Authority", desc: "You've received 500 responses!")
                                .padding(.horizontal)
                        }
                        Text("")
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        .navigationBarTitle("Achievements")
            .navigationBarItems(trailing: doneButton)
        }
    }
}

/*struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView().environmentObject(UserData())
    }
}*/
