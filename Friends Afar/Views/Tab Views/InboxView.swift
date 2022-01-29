//
//  InboxView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct InboxView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    let deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    var body: some View {
        VStack {
            Button(action: {
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
                                    responses.remove(at: i)
                                    i = i - 1
                                    break
                                }
                            }
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
                    
                    // Increment the counter
                    for _ in responses {
                        self.userData.numInbox += 1
                    }
                    
                    // Check the array for responses from the user
                    if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                        for eachResponse in responses {
                            if eachResponse.device_id == UUID {
                                self.userData.inboxResponses.insert(eachResponse, at: 0)
                            }
                        }
                    }
                    
                    // Connect to the server, upload the device ID, and delete any responses with that device ID
                    
                    // Prepare the URL
                    let url = NSURL(string: "https://virusesarentalive.com/deleteResponses.php")
                    
                    // Setup the request
                    var request = URLRequest(url: url! as URL)
                    request.httpMethod = "POST"
                    
                    // Apply the secret word
                    var dataString = "secretWord=iw68w64598n7w4985c7nw457w0579cnw0"
                    
                    // Add the device ID
                    if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                        dataString = dataString + "&device_id=\(UUID)"
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
                                    print(returnedData!)
                                    if returnedData == "1" { // insert into database worked
                                        // display an alert if no error and database delete worked (return = 1)
                                        print("Deletion success!")
                                    } else {
                                        // display an alert if an error and database delete didn't worked (return != 1)
                                        print("There was an error deleteing the data from the database.")
                                    }
                                }
                            }
                        }
                        uploadJob.resume()
                    }
                    
                    }).resume()
            }) {
                Text("Refresh Inbox")
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
            List(userData.inboxResponses) { response in
                InboxCardView(feeling_text: response.feeling_text, response_text: response.response_text, senderID: response.sender_id, deviceID: self.deviceID).environmentObject(self.userData)
            }
        }
        .onDisappear(perform: {
            for i in self.userData.inboxResponses {
                print(i.response_text)
            }
        })
        .onAppear(perform: {
            
            self.userData.badgeOpacity = 0.0
            
            UITableView.appearance().separatorColor = .clear
            
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
                
                // Increment the counter
                for _ in responses {
                    self.userData.numInbox += 1
                }
                
                // Check the array for responses for the user
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                    for eachResponse in responses {
                        if eachResponse.device_id == UUID {
                            self.userData.inboxResponses.insert(eachResponse, at: 0)
                        }
                    }
                }
                
                // Connect to the server, upload the device ID, and delete any responses with that device ID
                
                // Prepare the URL
                let url = NSURL(string: "https://virusesarentalive.com/deleteResponses.php")
                
                // Setup the request
                var request = URLRequest(url: url! as URL)
                request.httpMethod = "POST"
                
                // Apply the secret word
                var dataString = "secretWord=iw68w64598n7w4985c7nw457w0579cnw0"
                
                // Add the device ID
                if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                    dataString = dataString + "&device_id=\(UUID)"
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
                                print(returnedData!)
                                if returnedData == "1" { // insert into database worked
                                    // display an alert if no error and database delete worked (return = 1)
                                    print("Deletion success!")
                                } else {
                                    // display an alert if an error and database delete didn't worked (return != 1)
                                    print("There was an error deleteing the data from the database.")
                                }
                            }
                        }
                    }
                    uploadJob.resume()
                }
                
                }).resume()
        })
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView().environmentObject(UserData())
    }
}
