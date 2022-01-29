//
//  RespondView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct RespondView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    @State var showingFeelingViewer = false
    @State var currentFeelings: [Feeling]
    
    var body: some View {
        VStack {
            //Spacer()
            ScrollView {
                VStack {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50.0, height: 50.0)
                        Text("Please be mindful that you are communicating with real people when you are responding to Feelings.")
                            .multilineTextAlignment(.center)
                            .frame(maxHeight: .infinity)
                    }
                        
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
                    )
                    .padding([.top, .horizontal])
                    VStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50.0, height: 50.0)
                        Text("If you want to carry on the conversation with a user, consider providing your contact information or social media!")
                            .multilineTextAlignment(.center)
                            //.frame(maxHeight: .infinity)
                    }
                    
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
                )
                .padding([.horizontal])
                }
            }
            Spacer()
            Text("Tap Recieve Feeling to connect to the Internet and view and respond to another user's Feeling.")
            .foregroundColor(Color.secondary)
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
            Button(action: {
                
                // Connect to the server and retrieve an array of Feelings
                let url = URL(string: "https://virusesarentalive.com/getFeelings.php")
                URLSession.shared.dataTask(with: url!, completionHandler: {
                    (data, response, error) in
                    guard let data = data, error == nil else { print(error!); return }
                    let decoder = JSONDecoder()
                    var feelings = try! decoder.decode([Feeling].self, from: data)
                    
                    // Get rid of feelings with blocked IDs
                    if !self.userData.blockList.isEmpty {
                        feelings.removeAll(where: {
                            self.userData.blockList.contains($0.device_id)
                        })
                    }
                    
                    // Execute the profanity filter
                    if self.userData.blocksBadWords {
                        var i = 0
                        while (i < feelings.count) {
                            for eachBadWord in self.userData.badWords {
                                if (feelings[i].feeling_text.contains(eachBadWord)) {
                                    feelings.remove(at: i)
                                    i = i - 1
                                }
                            }
                            i = i + 1
                        }
                    }
                    
                    // Remove blank Feelings
                    var k = 0
                    while (k < feelings.count) {
                        if (MyString.blank(text: feelings[k].feeling_text)) {
                            feelings.remove(at: k)
                            k = k - 1
                        }
                        k = k + 1
                    }
                    
                    self.currentFeelings = feelings
                    self.showingFeelingViewer.toggle()
                    }).resume()
                
            }) {
                Text("Receive Feeling")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .fixedSize()
                .padding()
                .padding(.horizontal, 80.0)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
            }.sheet(isPresented: $showingFeelingViewer) {
                FeelingViewer(feelings: self.currentFeelings).environmentObject(self.userData)
            }
        }.onAppear(perform: {
            // Connect to the server and retrieve an array of responses
            let url = URL(string: "https://virusesarentalive.com/getResponses.php")
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                guard let data = data, error == nil else { print(error!); return }
                let decoder = JSONDecoder()
                var responses = try! decoder.decode([Response].self, from: data)
                
                // Remove responses from the array from blocked IDs
                if !self.userData.blockList.isEmpty {
                    responses.removeAll(where: {
                        self.userData.blockList.contains($0.sender_id)
                    })
                }
                
                // Execute the profanity filter
                if self.userData.blocksBadWords {
                    var i = 0
                    while (i < responses.count) {
                        for eachBadWord in self.userData.badWords {
                            if (responses[i].response_text.contains(eachBadWord)) {
                                print("in!")
                                responses.remove(at: i)
                                i = i - 1
                                break
                            }
                        }
                        print("out!")
                        i = i + 1
                    }
                }
                
                // Remove blank responses
                var k = 0
                while (k < responses.count) {
                    if (MyString.blank(text: responses[k].response_text)) {
                        responses.remove(at: k)
                        k = k - 1
                    }
                    k = k + 1
                }

                // Check the array for responses for the user
                var newResponses: [Response] = [Response]()
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                    for eachResponse in responses {
                        if eachResponse.device_id == UUID {
                            newResponses.append(eachResponse)
                        }
                    }
                }
                
                // Check to see if the array is empty
                if newResponses.isEmpty {
                    DispatchQueue.main.async {
                        self.userData.badgeOpacity = 0.0
                    }
                } else {
                    DispatchQueue.main.async {
                        self.userData.badgeOpacity = 1.0
                    }
                }
                
            }).resume()
        })
    }
}

struct RespondView_Previews: PreviewProvider {
    static var previews: some View {
        RespondView(currentFeelings: [Feeling(feeling_text: "Test Text", device_id: "preview", is_healthcare: "0")])
    }
}

struct MyString {
  static func blank(text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    return trimmed.isEmpty
  }
}
