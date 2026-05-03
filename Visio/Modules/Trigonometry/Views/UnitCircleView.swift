import SwiftUI

/// Root view for the Trigonometry (Unit Circle) module.
/// Draws the interactive unit circle, axes, projections, and control panel.
struct UnitCircleView: View {
    @StateObject private var controller = UnitCircleController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                
                // Canvas Area
                GeometryReader { geo in
                    let size = geo.size
                    // Scale so that 1 math unit is 35% of the width, leaving padding
                    let transform = CoordinateTransform.centered(in: size, scale: size.width * 0.35)
                    
                    Canvas { context, _ in
                        drawUnitCircle(in: context, transform: transform)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                controller.handleDrag(to: value.location, transform: transform)
                            }
                    )
                }
                .canvasFrame()
                .canvasStyle()
                
                // Control Panel
                TrigValuesPanel(controller: controller)
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Unit Circle")
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button {
                        showInsightPanel = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    
                    ResetButton { controller.reset() }
                }
            }
        }
        .sheet(isPresented: $showInsightPanel) {
            InsightPanelView(insights: controller.insights())
                .presentationDetents([.medium, .large])
        }
    }
    
    // MARK: - Drawing Logic
    
    private func drawUnitCircle(in context: GraphicsContext, transform: CoordinateTransform) {
        let origin = transform.origin
        
        // 1. Grid & Axes
        GridPainter.draw(in: context, size: CGSize(width: transform.origin.x * 2, height: transform.origin.y * 2), transform: transform)
        
        // 2. Unit Circle Base
        let radius = transform.scaleLength(1.0)
        let circleRect = CGRect(x: origin.x - radius, y: origin.y - radius, width: radius * 2, height: radius * 2)
        context.stroke(Path(ellipseIn: circleRect), with: .color(AppColors.label.opacity(0.5)), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
        
        let state = controller.state
        let mathPoint = state.point
        let screenPoint = transform.toScreen(mathPoint)
        
        // 3. Projections (Sin and Cos)
        let xOnAxis = transform.toScreen(CGPoint(x: mathPoint.x, y: 0))
        
        // Cos projection (horizontal, red)
        var cosPath = Path()
        cosPath.move(to: origin)
        cosPath.addLine(to: xOnAxis)
        context.stroke(cosPath, with: .color(AppColors.cosColor), style: StrokeStyle(lineWidth: AppDimensions.standardStroke * 1.5))
        
        // Sin projection (vertical, green)
        var sinPath = Path()
        sinPath.move(to: xOnAxis)
        sinPath.addLine(to: screenPoint)
        context.stroke(sinPath, with: .color(AppColors.sinColor), style: StrokeStyle(lineWidth: AppDimensions.standardStroke * 1.5))
        
        // 4. Tangent Line (orange)
        if !state.tanValue.isInfinite {
            // Draw tangent at x=1 or x=-1 depending on cos sign for visual clarity? 
            // Standard visual representation puts tan at x=1
            let tanMathPoint = CGPoint(x: 1.0, y: state.tanValue)
            // Limit the drawn height to avoid infinite lines stretching the screen
            if abs(tanMathPoint.y) < 10 {
                let tanScreenPoint = transform.toScreen(tanMathPoint)
                let tangentOrigin = transform.toScreen(CGPoint(x: 1.0, y: 0))
                
                // Tangent segment
                var tanPath = Path()
                tanPath.move(to: tangentOrigin)
                tanPath.addLine(to: tanScreenPoint)
                context.stroke(tanPath, with: .color(AppColors.tanColor), style: StrokeStyle(lineWidth: AppDimensions.standardStroke * 1.5))
                
                // Secant line connecting origin to the tan point
                var secPath = Path()
                secPath.move(to: origin)
                secPath.addLine(to: tanScreenPoint)
                context.stroke(secPath, with: .color(AppColors.tanColor.opacity(0.4)), style: StrokeStyle(lineWidth: AppDimensions.thinStroke, dash: [4, 4]))
            }
        }
        
        // 5. Radius Line (Origin to Circle Edge)
        var radiusPath = Path()
        radiusPath.move(to: origin)
        radiusPath.addLine(to: screenPoint)
        context.stroke(radiusPath, with: .color(AppColors.label), style: StrokeStyle(lineWidth: AppDimensions.standardStroke))
        
        // 6. Draggable Point
        let pointRadius = AppDimensions.draggablePointRadius
        let pointRect = CGRect(x: screenPoint.x - pointRadius, y: screenPoint.y - pointRadius, width: pointRadius * 2, height: pointRadius * 2)
        context.fill(Path(ellipseIn: pointRect), with: .color(AppColors.mathAccent))
        
        // Small inner dot for visual depth
        let innerRect = pointRect.insetBy(dx: 4, dy: 4)
        context.fill(Path(ellipseIn: innerRect), with: .color(AppColors.background))
    }
}

#Preview {
    NavigationStack {
        UnitCircleView()
    }
}
