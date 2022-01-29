//
//  InboxCardView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/12/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI
import UIKit
import MessageUI

struct InboxCardView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    var feeling_text: String
    var response_text: String
    var senderID: String
    var deviceID: String
    @State private var showingAlert = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    HStack {
                        Text("Response to \"\(feeling_text)\"")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                        if !self.userData.blockList.contains(senderID) {
                            // Sender is not blocked
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "xmark.octagon")
                                    .foregroundColor(Color.red)
                                        .imageScale(.large)
                                }
                                .onTapGesture {
                                    self.showingAlert = true
                                }
                                .padding(.trailing, 10)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Would you like to block this user?"), message: Text("You will not receive any new responses or Feelings from the user with ID \"\(senderID)\". You can unblock users from Settings."), primaryButton: .destructive(Text("Confirm")) {
                                    
                                    // Block the user
                                    self.userData.blockList.insert(self.senderID, at: 0)
                                    
                                    }, secondaryButton: .cancel())
                            }
                            Button(action: {}) {
                                Image(systemName: "exclamationmark.bubble")
                                    .imageScale(.large)
                                    .foregroundColor(Color.red)
                                    .onTapGesture {
                                        // Report the user
                                        self.isShowingMailView.toggle()
                                }
                            }
                            .disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result, deviceID: self.deviceID, senderID: self.senderID)
                            }
                        } else {
                                Spacer()
                                Button(action: {}) {
                                        Image(systemName: "xmark.octagon")
                                        .foregroundColor(Color.red)
                                        .imageScale(.large)
                                            .onTapGesture {
                                                self.showingAlert = true
                                        }
                                    }
                                .padding(.trailing, 10)
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("This user is already blocked."))
                                }
                            Button(action: {}) {
                                Image(systemName: "exclamationmark.bubble")
                                    .imageScale(.large)
                                    .foregroundColor(Color.red)
                                    .onTapGesture {
                                        // Report the user
                                        self.isShowingMailView.toggle()
                                }
                            }
                            .disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result, deviceID: self.deviceID, senderID: self.senderID)
                            }
                        }
                    }
                }
                //Spacer()
            }
            Text(response_text)
                .font(.body)
            Text("Sender ID: \(senderID)")
                .font(.caption)
                .padding(.top, 15.0)
                .foregroundColor(Color.secondary)
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

struct InboxCardView_Previews: PreviewProvider {
    static var previews: some View {
        InboxCardView(feeling_text: "PreviewFeeling", response_text: "Preview Response", senderID: "QWERTYUIOPASDFGHJKLZXCVBNM", deviceID: "Device ID").environmentObject(UserData())
    }
}

struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    @Binding var result: Result<MFMailComposeResult, Error>?
    var deviceID: String
    var senderID: String

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(["ethanm938@gmail.com"])
        vc.setSubject("Offending User Report")
        vc.setMessageBody("Please describe why you think this user should face consequences:\n\n\n\nOffending Sender ID: \(senderID)\nDevice ID: \(deviceID)", isHTML: false)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
