//
//  CircularProgressView.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 18/10/2023.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: CGFloat
    
    let color: Color = Style.accentColor
    let strokeWidth: CGFloat = 5.0
    
    var body: some View {
        ZStack {
            // Background for the progress bar
            Circle()
                .stroke(lineWidth: strokeWidth)
                .opacity(0.1)
                .foregroundColor(color)
            
            // Foreground or the actual progress bar
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.5)
    }
}
