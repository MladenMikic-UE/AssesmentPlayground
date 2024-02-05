//
//  CircularProgressBar.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

struct CircularProgressBar: View {

    let color: Color
    let size: CGSize

    @State private var degrees = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        
        Circle()
            .trim(from: 0.0, to: 0.8)
            .stroke(color, lineWidth: 5)
            .frame(width: size.width, height: size.height)
            .rotationEffect(Angle(degrees: degrees))
            .onAppear(perform: {
                self.start()
            })
            .onDisappear(perform: {
                self.stop()
            })
    }
    
    // Start updating the loading rotation
    private func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
            withAnimation {
                self.degrees += 10
            }
        }
    }
    
    // Stop updating the loading rotation
    private func stop() {
        timer?.invalidate()
        timer = nil
    }
}
