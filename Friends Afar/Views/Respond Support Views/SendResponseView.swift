//
//  SendResponseView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/11/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct SendResponseView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    var feeling_text: String
    var feeling_id: String
    @State var response: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showingInspector: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                }
                .padding([.top, .leading])
                Spacer()
            }
            Spacer()
            Text("What do you have to say?")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top)
            Button(action: {
                self.showingInspector.toggle()
            }) {
                Text("View Feeling")
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
            }.sheet(isPresented: $showingInspector) {
                FeelingInspectorView(feelingText: self.feeling_text)
            }
            MultiLineTF(txt: $response)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
            )
            .padding(.horizontal)
            Spacer()
            Text("Tapping Submit will upload your response to the Internet and make it available for the user who originally sent this Feeling.")
            .foregroundColor(Color.secondary)
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
            Button(action: {
                // Increment the counter
                self.userData.numResponses += 1
                
                // Perform a data check on the response text
                var enteredText = self.response
                
                // 1: Change any single quotes (') to double single quotes ('')
                enteredText = enteredText.replacingOccurrences(of: "\'", with: "\'\'")
                
                // 2: Replace "&" with "and"
                enteredText = enteredText.replacingOccurrences(of: "&", with: "and")
                
                // Perform a data check on the feeling text
                var enteredFeelingText = self.feeling_text
                
                // 1: Change any single quotes (') to double single quotes ('')
                enteredFeelingText = enteredFeelingText.replacingOccurrences(of: "\'", with: "\'\'")
                
                // 2: Replace "&" with "and"
                enteredFeelingText = enteredFeelingText.replacingOccurrences(of: "&", with: "and")
                
                // Connect to the server and add the response
                
                // Prepare the URL
                let url = NSURL(string: "https://virusesarentalive.com/receiveResponse.php")
                
                // Setup the request
                var request = URLRequest(url: url! as URL)
                request.httpMethod = "POST"
                
                // Apply the secret word
                var dataString = "secretWord=33926hsbc8swequ6843b64cjf9"
                
                // Add the response and Feeling data
                dataString = dataString + "&response_text=\(enteredText)"
                dataString = dataString + "&device_id=\(self.feeling_id)"
                dataString = dataString + "&feeling_text=\(enteredFeelingText)"
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                    dataString = dataString + "&sender_id=\(UUID)"
                }
                
                // Convert the POST string to utf8 format
                let dataD = dataString.data(using: .utf8)
                do {
                    let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD) {
                        data, response, error in
                        
                        if error != nil {
                            // Display an alert if there is an error
                            print("There was an error connecting to the server.")
                        } else {
                            if let unwrappedData = data {
                                let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                                if returnedData == "1" { // insert into database worked
                                    // display an alert if no error and database insert worked (return = 1)
                                    print("Upload success!")
                                } else {
                                    // display an alert if an error and database insert didn't worked (return != 1)
                                    print("There was an error inserting the data into the database.")
                                }
                            }
                        }
                    }
                    uploadJob.resume()
                }
                
                // Close the modals
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Submit")
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
            }
        }
    }
}

/*struct SendResponseView_Previews: PreviewProvider {
    static var previews: some View {
        SendResponseView(feeling_text: "Test Feeling Text", feeling_id: "Preview ID")
    }
}*/
