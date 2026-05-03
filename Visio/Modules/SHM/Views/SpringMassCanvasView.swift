import SwiftUI

/// Draws a zig-zag spring and an oscillating mass block
struct SpringMassCanvasView: View {
    @ObservedObject var controller: SHMController
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let mountX = size.width / 2
            let mountY: CGFloat = 40
            
            let equilibriumY = size.height / 2
            let scale: CGFloat = 20.0 // 1 meter = 20px
            
            Canvas { context, _ in
                let displacement = controller.state.displacement
                let massY = equilibriumY + displacement * scale
                
                // 1. Mount surface
                var mountPath = Path()
                mountPath.move(to: CGPoint(x: mountX - 50, y: mountY))
                mountPath.addLine(to: CGPoint(x: mountX + 50, y: mountY))
                context.stroke(mountPath, with: .color(AppColors.label), style: StrokeStyle(lineWidth: AppDimensions.boldStroke))
                
                // 2. Zig-zag Spring
                var springPath = Path()
                springPath.move(to: CGPoint(x: mountX, y: mountY))
                
                let coils = AppDimensions.springCoilCount
                let endY = massY - 20 // Attach to top of mass
                let springHeight = endY - mountY
                let coilHeight = springHeight / Double(coils)
                let coilWidth: CGFloat = 25
                
                for i in 1...coils {
                    let xOffset = (i % 2 == 0) ? -coilWidth : coilWidth
                    let y = mountY + coilHeight * Double(i) - (coilHeight / 2)
                    springPath.addLine(to: CGPoint(x: mountX + xOffset, y: y))
                }
                springPath.addLine(to: CGPoint(x: mountX, y: endY))
                
                context.stroke(springPath, with: .color(AppColors.secondaryLabel), style: StrokeStyle(lineWidth: AppDimensions.standardStroke, lineJoin: .round))
                
                // 3. Mass Block (Scale size slightly based on mass parameter)
                let massSize: CGFloat = 40 + controller.state.mass * 2.0
                let rect = CGRect(x: mountX - massSize/2, y: massY - massSize/2, width: massSize, height: massSize)
                context.fill(Path(roundedRect: rect, cornerRadius: 6), with: .color(AppColors.physicsAccent))
            }
        }
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
    }
}

#Preview {
    SpringMassCanvasView(controller: SHMController())
        .frame(height: 300)
        .padding()
}
