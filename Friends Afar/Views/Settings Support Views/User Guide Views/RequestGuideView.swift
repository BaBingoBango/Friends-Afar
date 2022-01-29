//
//  RequestGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct RequestGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: "wifi")
                    .padding([.top, .leading, .trailing])
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
                Text("The Request Screen")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("Visit the Request screen to upload a Feeling! Type out your message in the text field and then tap Submit Feeling! Be careful, though - if you switch tabs while you have text in the text field, it will disappear! Also keep in mind that if someone has blocked you, they will not see any Feelings submitted by you. Furthermore, if you include explicit language, a user with the profanity filter enabled may not see your Feeling. Futhermore, if you upload a blank Feeling, no user will receive it.")
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct RequestGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RequestGuideView()
    }
}
