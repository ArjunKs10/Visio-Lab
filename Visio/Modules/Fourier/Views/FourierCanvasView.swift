import SwiftUI

/// Renders the rotating epicycles on the left and the resulting drawing wave on the right.
struct FourierCanvasView: View {
    @ObservedObject var controller: FourierController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let epicycleCenter = CGPoint(x: size.width * 0.25, y: size.height / 2)
            let waveStartX = size.width * 0.55
            let scale: Double = 50.0 // 1 math unit = 50 pixels
            
            Canvas { context, _ in
                // 1. Draw horizontal axis for wave
                var axisPath = Path()
                axisPath.move(to: CGPoint(x: waveStartX, y: epicycleCenter.y))
                axisPath.addLine(to: CGPoint(x: size.width, y: epicycleCenter.y))
                context.stroke(axisPath, with: .color(AppColors.gridMajor), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
                
                var prevX = epicycleCenter.x
                var prevY = epicycleCenter.y
                
                // 2. Draw Epicycles
                for n in 1...controller.state.harmonicCount {
                    let r = controller.state.shape.radiusForHarmonic(n: n)
                    if r == 0 { continue }
                    
                    let radius = abs(r) * scale
                    let omega = Double(n)
                    
                    let cx = prevX
                    let cy = prevY
                    
                    // Standard mathematical rotation
                    prevX += r * scale * cos(omega * controller.state.time)
                    prevY += r * scale * sin(omega * controller.state.time)
                    
                    let hColor = Color.harmonicColor(index: n, total: max(controller.state.harmonicCount, 5))
                    
                    // Circle path
                    let rect = CGRect(x: cx - radius, y: cy - radius, width: radius * 2, height: radius * 2)
                    context.stroke(Path(ellipseIn: rect), with: .color(hColor.opacity(0.35)), style: StrokeStyle(lineWidth: AppDimensions.thinStroke))
                    
                    // Radius vector line
                    var vectorPath = Path()
                    vectorPath.move(to: CGPoint(x: cx, y: cy))
                    vectorPath.addLine(to: CGPoint(x: prevX, y: prevY))
                    context.stroke(vectorPath, with: .color(hColor.opacity(0.8)), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
                    
                    // Joint dot
                    let dotRect = CGRect(x: prevX - 2, y: prevY - 2, width: 4, height: 4)
                    context.fill(Path(ellipseIn: dotRect), with: .color(hColor))
                }
                
                let tipPoint = CGPoint(x: prevX, y: prevY)
                
                // 3. Connecting dashed line from epicycle tip to wave start
                var connectPath = Path()
                connectPath.move(to: tipPoint)
                connectPath.addLine(to: CGPoint(x: waveStartX, y: tipPoint.y))
                context.stroke(connectPath, with: .color(AppColors.secondaryLabel.opacity(0.6)), style: StrokeStyle(lineWidth: AppDimensions.thinStroke, dash: [4, 4]))
                
                // 4. Draw Accumulated Wave
                let history = controller.wavePath
                if !history.isEmpty {
                    var wPath = Path()
                    var first = true
                    
                    // Shift speed for drawing rightward
                    let waveSpeed = 1.5
                    
                    for (i, pt) in history.enumerated() {
                        let sx = waveStartX + Double(i) * waveSpeed
                        let sy = epicycleCenter.y + pt.y * scale
                        
                        if sx > size.width { break } // Stop drawing offscreen
                        
                        if first {
                            wPath.move(to: CGPoint(x: sx, y: sy))
                            first = false
                        } else {
                            wPath.addLine(to: CGPoint(x: sx, y: sy))
                        }
                    }
                    context.stroke(wPath, with: .color(AppColors.mathAccent), style: StrokeStyle(lineWidth: AppDimensions.boldStroke, lineCap: .round, lineJoin: .round))
                    
                    // Highlight the drawing leading tip
                    let leadY = epicycleCenter.y + history[0].y * scale
                    let leadRect = CGRect(x: waveStartX - 4, y: leadY - 4, width: 8, height: 8)
                    context.fill(Path(ellipseIn: leadRect), with: .color(AppColors.mathAccent))
                }
            }
        }
        .canvasFrame()
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
}

#Preview {
    FourierCanvasView(controller: FourierController())
        .padding()
}
