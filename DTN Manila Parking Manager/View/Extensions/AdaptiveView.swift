//
//  AdaptiveView.swift
//  Parking Manager
//
//  Created by Anselmo Oduca on 1/11/23.
//

import SwiftUI

struct AdaptiveView<Content: View>: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        if verticalSizeClass == .regular && horizontalSizeClass == .compact {
            // iPhone Portrait or iPad 1/3 split view for Multitasking for instance
            content
        } else if verticalSizeClass == .compact && horizontalSizeClass == .compact {
            // some "standard" iPhone Landscape (iPhone SE, X, XS, 7, 8, ...)
            content
        } else if verticalSizeClass == .compact && horizontalSizeClass == .regular {
            // some "bigger" iPhone Landscape (iPhone Xs Max, 6s Plus, 7 Plus, 8 Plus, ...)
            content
        } else if verticalSizeClass == .regular && horizontalSizeClass == .regular {
            // macOS or iPad without split view - no Multitasking
            content
        }
    }
}


