import Foundation
import QuartzCore
import Combine

/// Animation engine for the Simple Harmonic Motion module
class SHMController: ObservableObject {
    @Published var state = SHMState()
    
    /// Historical displacement values for the live graph
    @Published var displacementHistory: [Double] = []
    
    private var displayLink: CADisplayLink?
    private var lastTickTime: CFTimeInterval = 0
    
    /// Toggle animation
    func togglePlayPause() {
        if state.isPlaying {
            stopEngine()
        } else {
            startEngine()
        }
        state.isPlaying.toggle()
    }
    
    /// Full reset of the simulation
    func reset() {
        stopEngine()
        state.isPlaying = false
        state.time = 0
        displacementHistory.removeAll()
    }
    
    /// Called when switching modes to ensure clean state
    func handleModeChange() {
        reset()
        // Default amplitude adjustments for modes for visual clarity
        if state.mode == .pendulum {
            state.amplitude = 1.0
        } else {
            state.amplitude = 3.0
        }
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
        displacementHistory.append(state.displacement)
        
        // Cap the history array to maintain performance and match graph width
        if displacementHistory.count > AppDimensions.maxSHMSamples {
            displacementHistory.removeFirst()
        }
    }
    
    deinit {
        stopEngine()
    }
}
