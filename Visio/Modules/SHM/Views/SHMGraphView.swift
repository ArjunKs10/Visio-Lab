import SwiftUI

/// Draws a live displacement vs time graph mapping the sine wave.
struct SHMGraphView: View {
    @ObservedObject var controller: SHMController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let midY = size.height / 2
            
            Canvas { context, _ in
                // Draw center zero axis
                var axisPath = Path()
                axisPath.move(to: CGPoint(x: 0, y: midY))
                axisPath.addLine(to: CGPoint(x: size.width, y: midY))
                context.stroke(axisPath, with: .color(AppColors.gridMajor), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
                
                let history = controller.displacementHistory
                guard !history.isEmpty else { return }
                
                // Max slider amplitude is 5.0. Scale so 5.0 fits the half height.
                let scaleY = (size.height / 2 - 10) / 5.0
                let stepX = size.width / Double(AppDimensions.maxSHMSamples)
                
                var path = Path()
                var x = size.width
                var first = true
                
                // Draw backwards from right to left (newest to oldest)
                for displacement in history.reversed() {
                    let y = midY - (displacement * scaleY)
                    let pt = CGPoint(x: x, y: y)
                    
                    if first {
                        path.move(to: pt)
                        first = false
                    } else {
                        path.addLine(to: pt)
                    }
                    x -= stepX
                }
                
                context.stroke(path, with: .color(AppColors.mathAccent), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
                
                // Draw current live dot at the very right edge
                let currentY = midY - (controller.state.displacement * scaleY)
                let dotRect = CGRect(x: size.width - 6, y: currentY - 6, width: 12, height: 12)
                context.fill(Path(ellipseIn: dotRect), with: .color(AppColors.mathAccent))
            }
        }
        .frame(height: AppDimensions.shmGraphHeight)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
}

#Preview {
    SHMGraphView(controller: SHMController())
        .padding()
}
