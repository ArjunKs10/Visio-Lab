import SwiftUI

/// Canvas view that draws the coordinate grid, reference curve, and live transformed curve
struct GraphCanvasView: View {
    @ObservedObject var controller: FunctionTransformController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            // Standard coordinate mapping: Math origin in center, scale 30 pixels per unit
            let transform = CoordinateTransform.centered(in: size, scale: 30)
            
            ZStack(alignment: .topLeading) {
                // Drawing Canvas
                Canvas { context, _ in
                    // 1. Grid
                    GridPainter.draw(in: context, size: size, transform: transform)
                    
                    let xRange = transform.visibleXRange(screenWidth: size.width)
                    let step = (xRange.upperBound - xRange.lowerBound) / Double(AppDimensions.functionPlotSamples)
                    
                    // 2. Reference Curve (Ghosted: a=1, b=1, c=0, d=0)
                    drawCurve(
                        in: context,
                        transform: transform,
                        xRange: xRange,
                        step: step,
                        params: TransformParameters(),
                        type: controller.type,
                        color: AppColors.referenceCurve,
                        lineWidth: AppDimensions.standardStroke,
                        dashed: true
                    )
                    
                    // 3. Live Transformed Curve
                    drawCurve(
                        in: context,
                        transform: transform,
                        xRange: xRange,
                        step: step,
                        params: controller.params,
                        type: controller.type,
                        color: AppColors.mathAccent,
                        lineWidth: AppDimensions.boldStroke,
                        dashed: false
                    )
                }
                
                // 4. Live Equation Overlay
                Text(controller.equationString)
                    .font(AppFonts.equation)
                    .foregroundColor(AppColors.label)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(AppColors.secondaryBackground.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: AppDimensions.badgeCornerRadius))
                    .padding(AppDimensions.canvasPadding)
            }
        }
        .canvasFrame()
        .canvasStyle()
    }
    
    // MARK: - Drawing Helper
    
    private func drawCurve(
        in context: GraphicsContext,
        transform: CoordinateTransform,
        xRange: ClosedRange<Double>,
        step: Double,
        params: TransformParameters,
        type: FunctionType,
        color: Color,
        lineWidth: CGFloat,
        dashed: Bool
    ) {
        var path = Path()
        var isFirstPoint = true
        var x = xRange.lowerBound
        
        while x <= xRange.upperBound {
            let y = params.evaluate(at: x, type: type)
            
            // Limit bounds to avoid math infinity or drawing glitch extremes
            if abs(y) < 1000 {
                let screenPt = transform.toScreen(CGPoint(x: x, y: y))
                
                if isFirstPoint {
                    path.move(to: screenPt)
                    isFirstPoint = false
                } else {
                    path.addLine(to: screenPt)
                }
            } else {
                isFirstPoint = true
            }
            
            x += step
        }
        
        let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: dashed ? [4, 4] : [])
        context.stroke(path, with: .color(color), style: style)
    }
}

#Preview {
    GraphCanvasView(controller: FunctionTransformController())
        .padding()
}
