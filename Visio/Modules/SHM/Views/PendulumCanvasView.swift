import SwiftUI

/// Draws a simple pendulum swinging from a fixed pivot
struct PendulumCanvasView: View {
    @ObservedObject var controller: SHMController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let pivot = CGPoint(x: size.width / 2, y: 40)
            
            // Scaling so max length 5.0 fits nicely
            let lengthScale = (size.height - 80) / 5.0
            
            Canvas { context, _ in
                let theta = controller.state.displacement
                let currentLength = controller.state.length * lengthScale
                
                let bR = AppDimensions.pendulumBobRadius
                let history = controller.displacementHistory
                let count = history.count
                
                // 1. Ghost Trails
                let trailCount = AppDimensions.ghostTrailCount
                let step = max(1, count / 20)
                var trailOpacities = [(Double, Double)]()
                
                for i in 0..<trailCount {
                    let idx = count - 1 - (i * step * 2)
                    if idx >= 0 && idx < count {
                        let pastTheta = history[idx]
                        let opacity = 0.5 - (Double(i) / Double(trailCount)) * 0.4
                        trailOpacities.append((pastTheta, opacity))
                    }
                }
                
                for (pastTheta, opacity) in trailOpacities.reversed() {
                    let gX = pivot.x + currentLength * sin(pastTheta)
                    let gY = pivot.y + currentLength * cos(pastTheta)
                    let rect = CGRect(x: gX - bR, y: gY - bR, width: bR * 2, height: bR * 2)
                    context.fill(Path(ellipseIn: rect), with: .color(AppColors.physicsAccent.opacity(opacity)))
                }
                
                // 2. Pivot
                let pR = AppDimensions.pendulumPivotRadius
                context.fill(Path(ellipseIn: CGRect(x: pivot.x - pR, y: pivot.y - pR, width: pR * 2, height: pR * 2)), with: .color(AppColors.label))
                
                // 3. String
                let bobX = pivot.x + currentLength * sin(theta)
                let bobY = pivot.y + currentLength * cos(theta)
                let bobCenter = CGPoint(x: bobX, y: bobY)
                
                var stringPath = Path()
                stringPath.move(to: pivot)
                stringPath.addLine(to: bobCenter)
                context.stroke(stringPath, with: .color(AppColors.secondaryLabel), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
                
                // 4. Bob
                context.fill(Path(ellipseIn: CGRect(x: bobX - bR, y: bobY - bR, width: bR * 2, height: bR * 2)), with: .color(AppColors.physicsAccent))
            }
        }
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
}

#Preview {
    PendulumCanvasView(controller: SHMController())
        .frame(height: 300)
        .padding()
}
