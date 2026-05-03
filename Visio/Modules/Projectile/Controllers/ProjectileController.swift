import Foundation
import QuartzCore
import Combine
import CoreGraphics

/// Controls the CADisplayLink animation engine and updates ProjectileState.
class ProjectileController: ObservableObject {
    @Published var state = ProjectileState()
    
    /// The historical trail of the projectile for rendering
    @Published var historicalPoints: [CGPoint] = [CGPoint.zero]
    
    var analytics: ProjectileAnalytics {
        ProjectileAnalytics(state: state)
    }
    
    private var displayLink: CADisplayLink?
    private var lastTickTime: CFTimeInterval = 0
    
    /// Toggles the animation state between play and pause
    func togglePlayPause() {
        if state.isPlaying {
            stopEngine()
        } else {
            // If it already landed, reset it before playing again
            if state.hasLanded {
                resetPhysics()
            }
            startEngine()
        }
        state.isPlaying.toggle()
    }
    
    /// Full reset of the simulation
    func reset() {
        stopEngine()
        state.isPlaying = false
        resetPhysics()
    }
    
    /// Resets only the time and historical points (used when parameters change)
    func handleParameterChange() {
        stopEngine()
        state.isPlaying = false
        resetPhysics()
    }
    
    private func resetPhysics() {
        state.time = 0
        historicalPoints = [CGPoint.zero]
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
        historicalPoints.append(CGPoint(x: state.currentX, y: state.currentY))
        
        if state.hasLanded {
            state.isPlaying = false
            stopEngine()
        }
    }
    
    deinit {
        stopEngine()
    }
}
