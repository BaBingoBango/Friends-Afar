//
//  FeelingViewer.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/11/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct FeelingViewer: View {
    
    @EnvironmentObject var userData: UserData
    var feelings: [Feeling]
    @State var currentFeeling: String = "Default"
    @State var currentID: String = "Default ID"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showingSendResponseView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .fontWeight(.bold)
                }
                .padding([.top, .leading])
                Spacer()
            }
            Text("Someone's Feeling:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            Text(currentFeeling)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
                )
                .padding()
        
            Button(action: {
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                var nextFeeling = self.feelings.randomElement()!
                if self.userData.healthcareMode {
                    while ((nextFeeling.is_healthcare != "1") || (nextFeeling.device_id == UUID) || (nextFeeling.feeling_text == self.currentFeeling)) {
                        nextFeeling = self.feelings.randomElement()!
                    }
                } else {
                    while ((nextFeeling.is_healthcare != "0") || (nextFeeling.device_id == UUID) || (nextFeeling.feeling_text == self.currentFeeling)) {
                        nextFeeling = self.feelings.randomElement()!
                    }
                }
                self.currentFeeling = nextFeeling.feeling_text
                self.currentID = nextFeeling.device_id
                }
            }) {
                Text("Skip Feeling")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .fixedSize()
                .padding()
                .padding(.horizontal, 80.0)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                .background(Color.secondary)
                .cornerRadius(10)
                .padding()
            }
            Button(action: {
                self.showingSendResponseView.toggle()
            }) {
                Text("Continue")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .fixedSize()
                .padding()
                .padding(.horizontal, 80.0)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding(.bottom)
            .sheet(isPresented: $showingSendResponseView) {
                SendResponseView(feeling_text: self.currentFeeling, feeling_id: self.currentID).environmentObject(self.userData)
            }
        }
        .onAppear(perform: {
            
            /*if self.userData.isClosing {
                print("ahoy")
                self.presentationMode.wrappedValue.dismiss()
                self.userData.isClosing = false
            }*/
            
            if let UUID = UIDevice.current.identifierForVendor?.uuidString {
            var nextFeeling = self.feelings.randomElement()!
            if self.userData.healthcareMode {
                while ((nextFeeling.is_healthcare != "1") || (nextFeeling.device_id == UUID)) {
                    nextFeeling = self.feelings.randomElement()!
                }
            } else {
                while ((nextFeeling.is_healthcare != "0") || (nextFeeling.device_id == UUID)) {
                    nextFeeling = self.feelings.randomElement()!
                }
            }
            self.currentFeeling = nextFeeling.feeling_text
            self.currentID = nextFeeling.device_id
            }
        })
    }
}

/*struct FeelingViewer_Previews: PreviewProvider {
    static var previews: some View {
        FeelingViewer(feelings: [Feeling(feeling_text: "lweryiqoewyroqwyricqwutbiqureticwuerytiwrytiey", device_id: "preview", is_healthcare: "0")], showingSendResponseView: false).environmentObject(UserData())
    }
}*/
