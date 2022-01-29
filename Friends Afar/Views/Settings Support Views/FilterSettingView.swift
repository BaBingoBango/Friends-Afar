//
//  FilterSettingView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/14/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct FilterSettingView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        //NavigationView {
            Form {
                Section(footer: Text("The profanity filter will attempt to identify Feelings and responses which include common explicit terms. Any Feelings or responses identified by the filter as explicit will not be shown. The profanity filter is unlikely to identify all explicit Feelings and responses.")) {
                    Toggle(isOn: $userData.blocksBadWords) {
                        Text("Profanity Filter")
                    }
                }
            }
            
            //.navigationBarHidden(true)
        //}
    }
}

struct FilterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSettingView().environmentObject(UserData())
    }
}
