//
//  IntroGuideView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct IntroGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Welcome to Friends Afar!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .padding(.top, 20.0)
                Text("Friends Afar is in app in which you can support your fellow human beings anonymously (or not). By uploading written snippets about your life, others can respond to you, allowing you to acquire support and encouragement from people you don’t even know!")
                    .padding([.leading, .bottom, .trailing])
                Image(systemName: "hand.thumbsup.fill")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.green)
                Text("Feelings")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("Feelings are pieces of text that describe something about you, like “I’m feeling happy” or “I’m upset”. When writing a Feeling, you can feel free to write whatever you want others to see! You can submit your own Feelings in the Request screen and respond to the Feelings of others in the Respond screen.")
                    .padding([.leading, .bottom, .trailing])
                VStack(alignment: .leading) {
                    Image(systemName: "star.fill")
                    .padding(.horizontal)
                    .imageScale(.large)
                    .foregroundColor(Color.gold)
                    Text("Achievements")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding([.leading, .trailing])
                    Text("You can earn achievements by simply using the app! There are different achievements to earn by uploading Feelings, responding to Feelings, and receiving responses in your Inbox! There are 17 achievements to earn in total, and they come in bronze, gold, and silver varieties!")
                        .frame(maxHeight: .infinity)
                        .padding([.leading, .bottom, .trailing])
                }
                Image(systemName: "hammer.fill")
                .padding(.horizontal)
                .imageScale(.large)
                .foregroundColor(Color.gray)
                Text("App Updates")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.leading, .bottom, .trailing])
                Text("Updates with new features and improvements may come in the future! If you have suggestions for new features, imporovements, or bug fixes, you can send an email to ethanm938@gmail.com.")
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct IntroGuideView_Previews: PreviewProvider {
    static var previews: some View {
        IntroGuideView()
    }
}
