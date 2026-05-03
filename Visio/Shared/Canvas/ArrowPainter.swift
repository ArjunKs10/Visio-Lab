import SwiftUI

/// Draws an arrow (line + arrowhead triangle) between two screen-space points.
/// Used by ProjectileCanvasView for Vx and Vy velocity vectors.
struct ArrowPainter {

    /// Draw an arrow from one point to another with an arrowhead at the tip.
    /// - Parameters:
    ///   - context: the Canvas drawing context
    ///   - from: screen-space start point (tail)
    ///   - to: screen-space end point (tip with arrowhead)
    ///   - color: arrow color
    ///   - lineWidth: stroke width (default 2)
    static func drawArrow(
        in context: GraphicsContext,
        from: CGPoint,
        to: CGPoint,
        color: Color,
        lineWidth: CGFloat = 2
    ) {
        let dx = to.x - from.x
        let dy = to.y - from.y
        let length = sqrt(dx * dx + dy * dy)

        // Don't draw arrows shorter than the arrowhead
        guard length > 8 else { return }

        let shading = GraphicsContext.Shading.color(color)

        // Draw the line (shaft)
        var shaft = Path()
        shaft.move(to: from)
        shaft.addLine(to: to)
        context.stroke(shaft, with: shading, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))

        // Arrowhead geometry
        let arrowHeadLength: CGFloat = min(10, length * 0.3)
        let arrowHeadWidth: CGFloat = arrowHeadLength * 0.5
        let angle = atan2(dy, dx)

        // Calculate arrowhead triangle points
        let tipPoint = to
        let leftPoint = CGPoint(
            x: to.x - arrowHeadLength * cos(angle) + arrowHeadWidth * sin(angle),
            y: to.y - arrowHeadLength * sin(angle) - arrowHeadWidth * cos(angle)
        )
        let rightPoint = CGPoint(
            x: to.x - arrowHeadLength * cos(angle) - arrowHeadWidth * sin(angle),
            y: to.y - arrowHeadLength * sin(angle) + arrowHeadWidth * cos(angle)
        )

        // Draw the arrowhead triangle (filled)
        var arrowHead = Path()
        arrowHead.move(to: tipPoint)
        arrowHead.addLine(to: leftPoint)
        arrowHead.addLine(to: rightPoint)
        arrowHead.closeSubpath()
        context.fill(arrowHead, with: shading)
    }

    /// Draw a labeled arrow with text near the midpoint.
    /// - Parameters:
    ///   - context: the Canvas drawing context
    ///   - from: screen-space start point
    ///   - to: screen-space end point
    ///   - color: arrow color
    ///   - label: text label to display near the arrow
    ///   - lineWidth: stroke width
    static func drawLabeledArrow(
        in context: GraphicsContext,
        from: CGPoint,
        to: CGPoint,
        color: Color,
        label: String,
        lineWidth: CGFloat = 2
    ) {
        drawArrow(in: context, from: from, to: to, color: color, lineWidth: lineWidth)

        let dx = to.x - from.x
        let dy = to.y - from.y
        let length = sqrt(dx * dx + dy * dy)
        guard length > 20 else { return }

        // Position label at midpoint, offset perpendicular to the arrow
        let midX = (from.x + to.x) / 2
        let midY = (from.y + to.y) / 2
        let angle = atan2(dy, dx)
        let offset: CGFloat = 14

        let labelPoint = CGPoint(
            x: midX + offset * sin(angle),
            y: midY - offset * cos(angle)
        )

        let text = Text(label)
            .font(AppFonts.caption)
            .foregroundColor(color)
        let resolved = context.resolve(text)
        context.draw(resolved, at: labelPoint, anchor: .center)
    }
}
