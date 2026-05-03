import SwiftUI

/// Canvas view displaying the animated projectile, trail, and velocity vectors over a sky/grass background.
struct ProjectileCanvasView: View {
    @ObservedObject var controller: ProjectileController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let groundLevelY = size.height * 0.85
            
            // To fit a max velocity of 50m/s at 45 deg, max range is ~255m.
            // mathWidth of 270.0 ensures the entire trajectory fits on screen.
            let mathWidth = 270.0
            let scale = size.width / mathWidth
            let originX = size.width * 0.05 // 5% padding from left edge
            let transform = CoordinateTransform(origin: CGPoint(x: originX, y: groundLevelY), scale: scale)
            
            ZStack(alignment: .topLeading) {
                // Background Gradient and Ground
                VStack(spacing: 0) {
                    LinearGradient(
                        colors: [AppColors.skyTop, AppColors.skyBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    AppColors.ground
                        .frame(height: size.height - groundLevelY)
                }
                
                // Physics Drawing Canvas
                Canvas { context, _ in
                    // 1. Grid (only major grid lines every 25m for context)
                    GridPainter.draw(in: context, size: size, transform: transform, minorStep: 0, majorStep: 25)
                    
                    // 2. Historical Trail
                    var trailPath = Path()
                    for (index, point) in controller.historicalPoints.enumerated() {
                        let screenPt = transform.toScreen(point)
                        if index == 0 {
                            trailPath.move(to: screenPt)
                        } else {
                            trailPath.addLine(to: screenPt)
                        }
                    }
                    context.stroke(trailPath, with: .color(AppColors.label.opacity(0.4)), style: StrokeStyle(lineWidth: AppDimensions.thinStroke, dash: [4, 4]))
                    
                    // 3. Current Projectile
                    let currentMathPt = CGPoint(x: controller.state.currentX, y: controller.state.currentY)
                    let currentScreenPt = transform.toScreen(currentMathPt)
                    
                    // Ball
                    let r = AppDimensions.projectileBallRadius
                    let ballRect = CGRect(x: currentScreenPt.x - r, y: currentScreenPt.y - r, width: r * 2, height: r * 2)
                    context.fill(Path(ellipseIn: ballRect), with: .color(AppColors.physicsAccent))
                    
                    // Velocity Vectors (draw 0.5x scale to avoid arrows being too massive)
                    let vectorScale = 0.5
                    let vxMathPt = CGPoint(x: currentMathPt.x + controller.state.currentVx * vectorScale, y: currentMathPt.y)
                    let vyMathPt = CGPoint(x: currentMathPt.x, y: currentMathPt.y + controller.state.currentVy * vectorScale)
                    
                    let vxScreenPt = transform.toScreen(vxMathPt)
                    let vyScreenPt = transform.toScreen(vyMathPt)
                    
                    ArrowPainter.drawLabeledArrow(in: context, from: currentScreenPt, to: vxScreenPt, color: AppColors.velocityX, label: "Vx")
                    ArrowPainter.drawLabeledArrow(in: context, from: currentScreenPt, to: vyScreenPt, color: AppColors.velocityY, label: "Vy")
                }
            }
        }
        .canvasFrame()
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
}

#Preview {
    ProjectileCanvasView(controller: ProjectileController())
        .padding()
}
