//
//  TestWidgetBundle.swift
//  TestWidget
//
//  Created by 석기권 on 6/3/24.
//

import WidgetKit
import SwiftUI

@main
struct TestWidgetBundle: WidgetBundle {
    var body: some Widget {
        TestWidget()
        TestWidgetLiveActivity()
    }
}
