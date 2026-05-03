import SwiftUI

/// Draws a full coordinate grid with minor/major grid lines, bold axes,
/// tick marks, and numeric labels. All colors are adaptive (dark/light mode).
struct GridPainter {

    /// Draw a complete coordinate grid into a Canvas GraphicsContext.
    /// - Parameters:
    ///   - context: the Canvas drawing context
    ///   - size: the full size of the canvas
    ///   - transform: coordinate transform mapping math ↔ screen
    ///   - minorStep: math-space distance between minor grid lines (default 0.5)
    ///   - majorStep: math-space distance between major grid lines (default 1.0)
    static func draw(
        in context: GraphicsContext,
        size: CGSize,
        transform: CoordinateTransform,
        minorStep: Double = 0.5,
        majorStep: Double = 1.0
    ) {
        let xRange = transform.visibleXRange(screenWidth: size.width)
        let yRange = transform.visibleYRange(screenHeight: size.height)

        // MARK: - Minor Grid Lines

        drawGridLines(
            in: context,
            size: size,
            transform: transform,
            step: minorStep,
            xRange: xRange,
            yRange: yRange,
            color: AppColors.gridMinor,
            lineWidth: AppDimensions.gridMinorStroke
        )

        // MARK: - Major Grid Lines

        drawGridLines(
            in: context,
            size: size,
            transform: transform,
            step: majorStep,
            xRange: xRange,
            yRange: yRange,
            color: AppColors.gridMajor,
            lineWidth: AppDimensions.gridMajorStroke
        )

        // MARK: - Axes (bold)

        drawAxes(
            in: context,
            size: size,
            transform: transform,
            color: AppColors.gridAxis,
            lineWidth: AppDimensions.boldStroke
        )

        // MARK: - Numeric Labels

        drawLabels(
            in: context,
            size: size,
            transform: transform,
            step: majorStep,
            xRange: xRange,
            yRange: yRange
        )
    }

    // MARK: - Private Helpers

    /// Draw vertical and horizontal grid lines at a given step interval.
    private static func drawGridLines(
        in context: GraphicsContext,
        size: CGSize,
        transform: CoordinateTransform,
        step: Double,
        xRange: ClosedRange<Double>,
        yRange: ClosedRange<Double>,
        color: Color,
        lineWidth: CGFloat
    ) {
        guard step > 0 else { return }

        let shading = GraphicsContext.Shading.color(color)
        let style = StrokeStyle(lineWidth: lineWidth)

        // Vertical grid lines (along X axis)
        let startX = (xRange.lowerBound / step).rounded(.down) * step
        var x = startX
        while x <= xRange.upperBound {
            let screenX = transform.toScreen(CGPoint(x: x, y: 0)).x
            var path = Path()
            path.move(to: CGPoint(x: screenX, y: 0))
            path.addLine(to: CGPoint(x: screenX, y: size.height))
            context.stroke(path, with: shading, style: style)
            x += step
        }

        // Horizontal grid lines (along Y axis)
        let startY = (yRange.lowerBound / step).rounded(.down) * step
        var y = startY
        while y <= yRange.upperBound {
            let screenY = transform.toScreen(CGPoint(x: 0, y: y)).y
            var path = Path()
            path.move(to: CGPoint(x: 0, y: screenY))
            path.addLine(to: CGPoint(x: size.width, y: screenY))
            context.stroke(path, with: shading, style: style)
            y += step
        }
    }

    /// Draw the X and Y axes as bold lines.
    private static func drawAxes(
        in context: GraphicsContext,
        size: CGSize,
        transform: CoordinateTransform,
        color: Color,
        lineWidth: CGFloat
    ) {
        let shading = GraphicsContext.Shading.color(color)
        let style = StrokeStyle(lineWidth: lineWidth)
        let origin = transform.origin

        // X axis (horizontal line at math Y=0)
        if origin.y >= 0 && origin.y <= size.height {
            var xAxis = Path()
            xAxis.move(to: CGPoint(x: 0, y: origin.y))
            xAxis.addLine(to: CGPoint(x: size.width, y: origin.y))
            context.stroke(xAxis, with: shading, style: style)
        }

        // Y axis (vertical line at math X=0)
        if origin.x >= 0 && origin.x <= size.width {
            var yAxis = Path()
            yAxis.move(to: CGPoint(x: origin.x, y: 0))
            yAxis.addLine(to: CGPoint(x: origin.x, y: size.height))
            context.stroke(yAxis, with: shading, style: style)
        }
    }

    /// Draw numeric labels at each major grid step along both axes.
    private static func drawLabels(
        in context: GraphicsContext,
        size: CGSize,
        transform: CoordinateTransform,
        step: Double,
        xRange: ClosedRange<Double>,
        yRange: ClosedRange<Double>
    ) {
        guard step > 0 else { return }

        let labelFont = Font.system(.caption2, design: .rounded)
        let labelColor = AppColors.gridLabel
        let tickLength: CGFloat = 4
        let labelOffset: CGFloat = 14

        // X axis labels
        let startX = (xRange.lowerBound / step).rounded(.down) * step
        var x = startX
        while x <= xRange.upperBound {
            let intVal = Int(x.rounded())
            // Skip the origin label to avoid overlap
            if abs(x) > step * 0.1 {
                let screenPt = transform.toScreen(CGPoint(x: x, y: 0))

                // Tick mark
                let tickShading = GraphicsContext.Shading.color(AppColors.gridAxis)
                var tick = Path()
                tick.move(to: CGPoint(x: screenPt.x, y: transform.origin.y - tickLength))
                tick.addLine(to: CGPoint(x: screenPt.x, y: transform.origin.y + tickLength))
                context.stroke(tick, with: tickShading, style: StrokeStyle(lineWidth: 1))

                // Label
                let labelText = formatGridLabel(x, step: step)
                let text = Text(labelText)
                    .font(labelFont)
                    .foregroundColor(labelColor)
                let resolvedText = context.resolve(text)
                let textSize = resolvedText.measure(in: CGSize(width: 100, height: 30))

                let labelY = min(transform.origin.y + labelOffset, size.height - textSize.height)
                context.draw(
                    resolvedText,
                    at: CGPoint(x: screenPt.x, y: labelY),
                    anchor: .top
                )
            }
            x += step
        }

        // Y axis labels
        let startY = (yRange.lowerBound / step).rounded(.down) * step
        var y = startY
        while y <= yRange.upperBound {
            // Skip the origin label
            if abs(y) > step * 0.1 {
                let screenPt = transform.toScreen(CGPoint(x: 0, y: y))

                // Tick mark
                let tickShading = GraphicsContext.Shading.color(AppColors.gridAxis)
                var tick = Path()
                tick.move(to: CGPoint(x: transform.origin.x - tickLength, y: screenPt.y))
                tick.addLine(to: CGPoint(x: transform.origin.x + tickLength, y: screenPt.y))
                context.stroke(tick, with: tickShading, style: StrokeStyle(lineWidth: 1))

                // Label
                let labelText = formatGridLabel(y, step: step)
                let text = Text(labelText)
                    .font(labelFont)
                    .foregroundColor(labelColor)
                let resolvedText = context.resolve(text)

                let labelX = max(transform.origin.x - labelOffset, 0)
                context.draw(
                    resolvedText,
                    at: CGPoint(x: labelX, y: screenPt.y),
                    anchor: .trailing
                )
            }
            y += step
        }
    }

    /// Format a grid label value — show integer if whole number, otherwise one decimal
    private static func formatGridLabel(_ value: Double, step: Double) -> String {
        if step >= 1 && abs(value - value.rounded()) < 0.01 {
            return "\(Int(value.rounded()))"
        } else {
            return String(format: "%.1f", value)
        }
    }
}
