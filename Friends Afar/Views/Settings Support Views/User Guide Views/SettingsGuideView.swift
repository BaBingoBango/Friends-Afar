//
//  SettingsGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct SettingsGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: "quote.bubble.fill")
                    .padding([.top, .leading, .trailing])
                    .imageScale(.large)
                    .foregroundColor(Color.orange)
                Text("The Profanity Filter")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("If you’re concerned about seeing Feelings or receiving responses that contain explicit content, try out the profanity filter! Any response or Feeling which contains one of the filter’s many common explicit words and phrases will not be shown. However, no filter is perfect, so some explicit text may still reach you.")
                    .padding([.leading, .bottom, .trailing])
                Image(systemName: "person.3.fill")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.red)
                Text("Blocked User List")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("Tap Blocked Users to view a list of all the sender IDs you’ve blocked! To unblock a user, simply tap on their user ID and choose “Confirm”!")
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct SettingsGuideView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGuideView()
    }
}
