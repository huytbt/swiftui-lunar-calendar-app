//
//  SettingView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/30/20.
//

import SwiftUI

struct SettingView: View {
    @Binding var showModal: Bool
    var body: some View {
        NavigationView {
            VStack {
                Text("This is a modal view")
            }
            .navigationTitle("Setting")
            .onTapGesture {
                self.showModal.toggle()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(showModal: .constant(true))
    }
}
