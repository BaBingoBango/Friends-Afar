//
//  SettingsView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
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
            Form {
                /*Section(footer: Text("Enabling Healthcare Mode will cause any Feelings you send to be received only by other Healthcare Mode users. Any Feelings you receive will also be from Healthcare Mode users. This feature is intended to support healthcare workers.")) {
                    HStack {
                        Image(systemName: "heart.fill")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Toggle(isOn: $userData.healthcareMode) {
                            Text("Healthcare Mode")
                        }
                    }
                }*/
                Section(header: Text("CONTENT CONTROL"), footer: Text("Tap on a user ID in the list to unblock the user.")) {
                    NavigationLink(destination: FilterSettingView().environmentObject(userData)) {
                        HStack {
                            Image(systemName: "quote.bubble.fill")
                            .resizable()
                            .fixedSize(horizontal: true, vertical: true)
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                            Text("Profanity Filter")
                        }
                    }
                    if !userData.blockList.isEmpty {
                        NavigationLink(destination: BlockListView().environmentObject(userData)) {
                            HStack {
                                Image(systemName: "xmark.octagon.fill")
                                .resizable()
                                .fixedSize(horizontal: true, vertical: true)
                                .clipped()
                                .aspectRatio(contentMode: .fit)
                                Text("Blocked Users")
                            }
                        }
                    } else {
                        NavigationLink(destination: NoBlockView()) {
                                HStack {
                                    Image(systemName: "xmark.octagon.fill")
                                    .resizable()
                                    .fixedSize(horizontal: true, vertical: true)
                                    .clipped()
                                    .aspectRatio(contentMode: .fit)
                                    Text("Blocked Users")
                                }
                            }
                    }
                }
                Section(header: Text("INFORMATION")) {
                    /*NavigationLink(destination:
                        AchievementsView()
                        .environmentObject(userData)
                        .navigationBarTitle(Text("Achievements"))) {
                        HStack {
                            Image(systemName: "star.fill")
                            .resizable()
                            .fixedSize(horizontal: true, vertical: true)
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                            Text("Achievements")
                        }
                    }*/
                    NavigationLink(destination: HelpGuideView().navigationBarTitle(Text("User Guide"))) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .fixedSize(horizontal: true, vertical: true)
                            .clipped()
                            .aspectRatio(contentMode: .fit)
                            Text("User Guide")
                        }
                    }
                    Text("Application Version: 1.0")
                        .foregroundColor(Color.secondary)
                }
            }
        .navigationBarItems(trailing: doneButton)
        .navigationBarTitle(Text("Settings"))
        }.onAppear(perform: {
            UITableView.appearance().separatorColor = .none
        })
            .onDisappear(perform: {
                UITableView.appearance().separatorColor = .clear
                print("hey")
            })
    }
}

/*struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserData())
    }
}*/

struct NoBlockView: View {
    var body: some View {
        VStack {
            Text("You have no blocked users!")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            Spacer()
        }
    }
}
