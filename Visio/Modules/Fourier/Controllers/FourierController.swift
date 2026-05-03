import Foundation
import QuartzCore
import Combine

/// Engine that calculates the epicycle positions and accumulates the drawn wave.
class FourierController: ObservableObject {
    @Published var state = FourierState()
    
    /// Accumulated drawing points (x: 0, y: accumulated amplitude)
    /// X represents sequence in time, we shift it right when rendering.
    @Published var wavePath: [CGPoint] = []
    
    private var displayLink: CADisplayLink?
    private var lastTickTime: CFTimeInterval = 0
    
    func togglePlayPause() {
        if state.isPlaying {
            stopEngine()
        } else {
            startEngine()
        }
        state.isPlaying.toggle()
    }
    
    func reset() {
        stopEngine()
        state.isPlaying = false
        state.time = 0
        wavePath.removeAll()
    }
    
    func handleParameterChange() {
        // Clear history so the drawn wave doesn't jump discontinuously
        wavePath.removeAll()
    }
    
    // MARK: - Animation Engine
    
    private func startEngine() {
        if displayLink == nil {
            lastTickTime = CACurrentMediaTime()
            let link = CADisplayLink(target: self, selector: #selector(tick))
            link.add(to: .main, forMode: .common)
            displayLink = link
        }
    }
    
    private func stopEngine() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func tick(displaylink: CADisplayLink) {
        let currentTime = displaylink.timestamp
        let dt = currentTime - lastTickTime
        lastTickTime = currentTime
        
        guard state.isPlaying else { return }
        
        state.time += dt
        
        // Accumulate Y position from all harmonics at current time 't'
        var accumulatedY = 0.0
        
        for n in 1...state.harmonicCount {
            let r = state.shape.radiusForHarmonic(n: n)
            if r == 0 { continue }
            
            let omega = Double(n) // frequency
            // y = r * sin(n * t)
            accumulatedY += r * sin(omega * state.time)
        }
        
        // Insert new point at the front. It will be drawn at x=0 relative to the wave start.
        wavePath.insert(CGPoint(x: 0, y: accumulatedY), at: 0)
        
        // Limit path length to prevent memory/render issues
        if wavePath.count > AppDimensions.maxSHMSamples {
            wavePath.removeLast()
        }
    }
    
    deinit {
        stopEngine()
    }
}
