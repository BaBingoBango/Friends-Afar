//
//  HelpGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct HelpGuideView: View {
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: IntroGuideView().navigationBarTitle(Text("Introduction"))) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Text("Introduction")
                    }
                }
            }
            Section {
                NavigationLink(destination: RequestGuideView().navigationBarTitle(Text("Uploading Feelings"))) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Text("Uploading Feelings")
                    }
                }
            }
            Section {
                NavigationLink(destination: RespondGuideView().navigationBarTitle(Text("Responding"))) {
                    HStack {
                        Image(systemName: "bubble.left.fill")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Text("Responding to Feelings")
                    }
                }
            }
            Section {
                NavigationLink(destination: InboxGuideView().navigationBarTitle(Text("Viewing Responses"))) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Text("Viewing Received Feelings")
                    }
                }
            }
            Section {
                NavigationLink(destination: SettingsGuideView().navigationBarTitle("Changing Settings")) {
                    HStack {
                        Image(systemName: "gear")
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        Text("Changing Settings")
                    }
                }
            }
        }
    }
}

struct HelpGuideView_Previews: PreviewProvider {
    static var previews: some View {
        HelpGuideView()
    }
}
