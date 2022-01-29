//
//  RequestView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct RequestView: View {
    
    // Variables
    @State var feeling = ""
    @State var hasSentFeeling = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("How are you feeling?")
                .font(.title)
                .fontWeight(.bold)
            VStack {
                MultiLineTF(txt: $feeling)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 3)
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            if !hasSentFeeling {
                Text("Tap Submit Feeling to connect to the Internet and upload your Feeling. It may then be received by other users.")
                .foregroundColor(Color.secondary)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            }
            if self.hasSentFeeling {
                VStack {
                    Text("Feeling Submitted!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .fixedSize()
                    .padding(.top)
                    Button(action: {
                        self.hasSentFeeling = false
                    }) {
                        Text("Submit Another Feeling")
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
            if !hasSentFeeling {
                    Button(action: {
                        // Increment the counter
                        self.userData.numRequests += 1
                        
                        // Perform a data check on the response text
                        var enteredText = self.feeling
                        
                        // 1: Change any single quotes (') to double single quotes ('')
                        enteredText = enteredText.replacingOccurrences(of: "\'", with: "\'\'")
                        
                        // 2: Replace "&" with "and"
                        enteredText = enteredText.replacingOccurrences(of: "&", with: "and")
                        
                        // Upload the entered text to the server
                        
                        // Prepare the URL
                        let url = NSURL(string: "https://virusesarentalive.com/receiveFeeling.php")
                        
                        // Setup the request
                        var request = URLRequest(url: url! as URL)
                        request.httpMethod = "POST"
                        
                        // Apply the secret word
                        var dataString = "secretWord=aire7o8qw47nc8w475984n5v79e485ve5586n78e56v"
                        
                        // Add the response and Feeling data
                        dataString = dataString + "&feeling_text=\(enteredText)"
                        if let UUID = UIDevice.current.identifierForVendor?.uuidString {
                            dataString = dataString + "&device_id=\(UUID)"
                        }
                        if self.userData.healthcareMode {
                            dataString = dataString + "&is_healthcare=\("1")"
                        } else {
                            dataString = dataString + "&is_healthcare=\("0")"
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
                            self.hasSentFeeling = true
                            uploadJob.resume()
                        }
                        
                    }) {
                        Text("Submit Feeling")
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
        }.onAppear(perform: {
            self.hasSentFeeling = false
            
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

struct MultiLineTF: UIViewRepresentable {
    
    
    @Binding var txt: String
    
    func makeCoordinator() -> Coordinator {
        return MultiLineTF.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> UITextView {
        
        let tview = UITextView()
        tview.isEditable = true
        tview.isUserInteractionEnabled = true
        tview.isScrollEnabled = true
        tview.text = ""
        tview.returnKeyType = .done
        //tview.textColor = .gray
        tview.font = .systemFont(ofSize: 20)
        //tview.delegate = context.coordinator as? UITextViewDelegate
        tview.delegate = context.coordinator
        tview.addDoneButtonOnKeyboard()
        tview.smartQuotesType = UITextSmartQuotesType.no
        return tview
    }
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTF
        
        init(parent1: MultiLineTF) {
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            //textView.text = ""
            // for dark mode
            textView.textColor = .label
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            print("here")
            textView.resignFirstResponder()
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}

extension UITextView{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
