//
//  RespondGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct RespondGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .padding([.top, .leading, .trailing])
                    .imageScale(.large)
                    .foregroundColor(Color.purple)
                Text("The Respond Screen")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("If you’re looking to respond to another user’s Feeling, the Respond screen is the place to go! Simply tap Receive Feeling to connect to the Internet and retrieve Feelings from the server! Then tap Continue and write out your response! If you forget what the Feeling is, tap View Feeling to take a peek and avoid losing your writing progress. Finally, tap Submit to upload your response and sent it to the original user! Keep in mind that if you submit a blank response, no one will see it.")
                    .padding([.leading, .bottom, .trailing])
                Image(systemName: "rectangle.stack.fill")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.gray)
                Text("Choosing a Feeling")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("If you don’t like the Feeling you get on your first try, tap Skip Feeling to replace your current Feeling with a new one! If you still don’t like the Feelings you’re getting, you can try blocking certain users or toggling the profanity filter.")
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct RespondGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RespondGuideView()
    }
}
