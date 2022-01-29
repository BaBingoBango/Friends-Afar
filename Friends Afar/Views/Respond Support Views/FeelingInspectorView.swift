//
//  FeelingInspectorView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/11/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct FeelingInspectorView: View {
    
    // Variables
    var feelingText: String = "Default Text"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.bold)
                }
                .padding([.top, .trailing])
            }
            Text(feelingText)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
                )
                .padding()
        }
    }
}

struct FeelingInspectorView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingInspectorView()
    }
}
