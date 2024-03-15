//
//  SwiftUIView.swift
//  HostingController
//
//  Created by SeokkiKwon on 11/20/23.
//

import SwiftUI

struct SwiftUIView: View {
    var text: String
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Image(systemName: "smiley")
                Text("This is a SwiftUI View")
            }
        }
    }
}

//#Preview {
//    SwiftUIView(text:"Hello, World!")
//}
