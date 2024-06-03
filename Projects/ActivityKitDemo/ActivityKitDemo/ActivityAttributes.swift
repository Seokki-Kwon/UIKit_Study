//
//  ActivityAttributes.swift
//  ActivityKitDemo
//
//  Created by 석기권 on 6/3/24.
//

import Foundation
import ActivityKit

struct MyMood: Decodable, Encodable, Hashable {
    let status: String
    let emoji: String
}
struct TestWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        
        // Dynamic stateful properties about your activity go here!
        var mood: MyMood
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
