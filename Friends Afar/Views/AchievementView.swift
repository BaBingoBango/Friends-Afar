//
//  AchievementView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/15/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct AchievementView: View {
    
    // Variables
    var type: String = "b"
    var name: String = "Great Job!"
    var desc: String = "You did nothing to earn this!"
    
    var body: some View {
        HStack {
            if type == "b" {
                Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(.bronze)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(desc)
                }
                Spacer()
            } else if type == "s" {
                Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(.silver)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(desc)
                }
                Spacer()
            } else {
                Image(systemName: "star.fill")
                .imageScale(.large)
                .foregroundColor(.gold)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(desc)
                }
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
        .padding()
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
        )
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
    }
}

extension Color {
    static let bronze = Color("bronze")
    static let silver = Color("silver")
    static let gold = Color("gold")
}
