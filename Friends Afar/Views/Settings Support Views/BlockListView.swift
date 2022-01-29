//
//  BlockListView.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/13/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI

struct BlockListView: View {
    
    // Variables
    @EnvironmentObject var userData: UserData
    @State private var showingAlert = false
    
    var body: some View {
        
        return List(userData.blockList, id: \.self) { blocked in
        Button(action: {
            self.showingAlert = true
        }) {
            Text(blocked)
        }
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("Would you like to unblock this user?"), message: Text("You will again receive responses and Feelings from the user with ID \"\(blocked)\"."), primaryButton: .default(Text("Confirm")) {
                
                // Unblock the user
                if self.userData.blockList.contains(blocked) {
                    let index = self.userData.blockList.firstIndex(of: blocked)
                    self.userData.blockList.remove(at: index!)
                }
                
                }, secondaryButton: .cancel())
        }
        }
    }
}

struct BlockListView_Previews: PreviewProvider {
    static var previews: some View {
        BlockListView().environmentObject(UserData())
    }
}
