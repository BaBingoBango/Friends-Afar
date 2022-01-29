//
//  InboxGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct InboxGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: "envelope.badge.fill")
                    .padding([.top, .leading, .trailing])
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
                Text("Inbox")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("Inbox is the place to go to check out the responses you’ve received to your Feelings! If you have new responses to view, a red indicator will appear over the Inbox tab icon.")
                    .padding([.leading, .bottom, .trailing])
                Image(systemName: "repeat")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.green)
                Text("Inbox Refreshing")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("In order to check for new messages, your Inbox refreshes at certain times. Whenever the Inbox refreshes, if there are any new messages, they will be appear in your Inbox and a red indicator will appear over the Inbox tab icon. Your Inbox refreshes when you open the app after it has fully closed, when you open a new tab, and when you tap the Refresh Inbox button.")
                    .padding([.leading, .bottom, .trailing])
                Image(systemName: "xmark.octagon.fill")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.red)
                Text("Blocking and Reporting")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("You can identify different users based on their sender IDs, which are listed on each response in your Inbox. If you don’t want to receive responses or view Feelings from a particular user, simply tap the “X” button to add the user to your block list. To unblock a user, visit Settings. You can also report a user for misconduct by tapping the exclamation mark icon and sending an email.")
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct InboxGuideView_Previews: PreviewProvider {
    static var previews: some View {
        InboxGuideView()
    }
}
