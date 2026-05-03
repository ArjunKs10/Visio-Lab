import Foundation
import SwiftUI
import Combine

/// Engine that computes the interference pattern over a 2D grid.
class WaveController: ObservableObject {
    @Published var state = WaveState()
    
    /// 2D array caching the relative intensity of interference [0.0...1.0]
    @Published var intensityGrid: [[Double]] = []
    
    /// The mathematical bounds of the ripple tank simulation
    let gridRange: ClosedRange<Double> = -10.0...10.0
    
    /// Predefined cell count (e.g. 60x60)
    let resolution = AppDimensions.waveGridResolution
    
    init() {
        computeGrid()
    }
    
    /// Distance between the two sources
    var currentSeparation: Double {
        let dx = state.source2.x - state.source1.x
        let dy = state.source2.y - state.source1.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func updateWavelength(_ w: Double) {
        state.wavelength = w
        computeGrid()
    }
    
    func updateSeparation(_ d: Double) {
        // Keep them horizontally centered on y=0
        state.source1 = CGPoint(x: -d / 2, y: 0)
        state.source2 = CGPoint(x: d / 2, y: 0)
        computeGrid()
    }
    
    func handleDrag(sourceIndex: Int, mathPoint: CGPoint) {
        if sourceIndex == 1 {
            state.source1 = mathPoint
        } else {
            state.source2 = mathPoint
        }
        computeGrid()
    }
    
    func reset() {
        state = WaveState()
        computeGrid()
    }
    
    // MARK: - Physics Engine
    
    /// Computes the interference intensity at each grid point
    private func computeGrid() {
        var newGrid = [[Double]](repeating: [Double](repeating: 0, count: resolution), count: resolution)
        let step = (gridRange.upperBound - gridRange.lowerBound) / Double(resolution)
        
        let k = 2 * .pi / state.wavelength
        let s1x = state.source1.x
        let s1y = state.source1.y
        let s2x = state.source2.x
        let s2y = state.source2.y
        
        var y = gridRange.lowerBound
        for i in 0..<resolution {
            var x = gridRange.lowerBound
            for j in 0..<resolution {
                // Distance to source 1
                let dx1 = x - s1x
                let dy1 = y - s1y
                let d1 = sqrt(dx1 * dx1 + dy1 * dy1)
                
                // Distance to source 2
                let dx2 = x - s2x
                let dy2 = y - s2y
                let d2 = sqrt(dx2 * dx2 + dy2 * dy2)
                
                // Path difference
                let deltaPath = d1 - d2
                let phaseDiff = k * deltaPath
                
                // Intensity I ∝ cos²(Δφ / 2), resulting in [0, 1]
                let intensity = pow(cos(phaseDiff / 2), 2)
                newGrid[i][j] = intensity
                
                x += step
            }
            y += step
        }
        
        intensityGrid = newGrid
    }
}
