import SwiftUI

/// Draws a 2D top-down grid representing the ripple tank interference pattern.
struct WaveCanvasView: View {
    @ObservedObject var controller: WaveController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let transform = CoordinateTransform.fitting(
                xRange: controller.gridRange,
                yRange: controller.gridRange,
                in: size,
                padding: AppDimensions.canvasPadding
            )
            
            Canvas { context, _ in
                let res = controller.resolution
                guard res > 0 && controller.intensityGrid.count == res else { return }
                
                let mathWidth = controller.gridRange.upperBound - controller.gridRange.lowerBound
                let step = mathWidth / Double(res)
                
                let cellWidth = transform.scaleLength(step)
                let cellHeight = transform.scaleLength(step)
                
                // Draw intensity grid
                for i in 0..<res {
                    let mathY = controller.gridRange.lowerBound + step * Double(i) + step / 2
                    for j in 0..<res {
                        let mathX = controller.gridRange.lowerBound + step * Double(j) + step / 2
                        
                        let screenPt = transform.toScreen(CGPoint(x: mathX, y: mathY))
                        let rect = CGRect(x: screenPt.x - cellWidth / 2, y: screenPt.y - cellHeight / 2, width: cellWidth, height: cellHeight)
                        
                        let intensity = controller.intensityGrid[i][j]
                        // Map [0, 1] to [-1, 1] where 0 is neutral background
                        let iVal = intensity * 2 - 1.0
                        
                        var cellColor: Color = .clear
                        if iVal > 0 {
                            // Constructive
                            cellColor = AppColors.constructive.opacity(iVal)
                        } else {
                            // Destructive
                            cellColor = AppColors.destructive.opacity(-iVal)
                        }
                        
                        context.fill(Path(rect), with: .color(cellColor))
                    }
                }
                
                // Draw point sources
                let s1Pt = transform.toScreen(controller.state.source1)
                let s2Pt = transform.toScreen(controller.state.source2)
                let r = AppDimensions.waveSourceMaxRadius
                
                context.fill(Path(ellipseIn: CGRect(x: s1Pt.x - r, y: s1Pt.y - r, width: r * 2, height: r * 2)), with: .color(AppColors.label))
                context.fill(Path(ellipseIn: CGRect(x: s2Pt.x - r, y: s2Pt.y - r, width: r * 2, height: r * 2)), with: .color(AppColors.label))
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let mathPt = transform.toMath(value.location)
                        // Assign drag to the closest source
                        let d1 = distance(from: controller.state.source1, to: mathPt)
                        let d2 = distance(from: controller.state.source2, to: mathPt)
                        
                        if d1 < d2 {
                            controller.handleDrag(sourceIndex: 1, mathPoint: mathPt)
                        } else {
                            controller.handleDrag(sourceIndex: 2, mathPoint: mathPt)
                        }
                    }
            )
        }
        .canvasFrame()
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
    
    private func distance(from a: CGPoint, to b: CGPoint) -> Double {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
}

#Preview {
    WaveCanvasView(controller: WaveController())
        .padding()
}
