import Foundation

extension FunctionTransformController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        results.append(ContextInsight(
            heading: "y = \(equationString)",
            body: "Compare this curve to the gray one. Every parameter change you make transforms that original shape in a predictable way.",
            icon: "function"
        ))
        
        let aVal = String(format: "%.1f", params.a)
        let bVal = String(format: "%.1f", params.b)
        let cVal = String(format: "%.1f", params.c)
        let dVal = String(format: "%.1f", params.d)
        
        if abs(params.a) != 1.0 {
            results.append(ContextInsight(
                heading: "a = \(aVal) — vertical \(abs(params.a) > 1 ? "stretch" : "compression")",
                body: abs(params.a) > 1
                ? "Look at the peaks — they are pulled away from the x-axis, making the wave taller than the gray reference."
                : "Notice how the graph is squashed toward the x-axis — all peaks are reduced in height.",
                icon: "arrow.up.and.down"
            ))
        }
        
        if abs(params.b) != 1.0 {
            let period = String(format: "%.2f", 2 * .pi / params.b)
            results.append(ContextInsight(
                heading: "b = \(bVal) — horizontal scaling",
                body: abs(params.b) > 1
                ? "The graph is compressed horizontally — more cycles fit in the same space. The wave oscillates faster."
                : "The graph is stretched out — fewer cycles appear. The wave oscillates more slowly.",
                icon: "arrow.left.and.right"
            ))
            
            results.append(ContextInsight(
                heading: "New period = \(period)",
                body: "The period determines how long one full cycle takes. Changing b directly changes how frequently the pattern repeats.",
                icon: "clock"
            ))
        }
        
        if params.c != 0.0 {
            results.append(ContextInsight(
                heading: "c = \(cVal) — phase shift",
                body: "Watch the curve slide left or right. The entire wave is shifting horizontally without changing its shape.",
                icon: "arrow.left.and.right"
            ))
        }
        
        if params.d != 0.0 {
            results.append(ContextInsight(
                heading: "d = \(dVal) — vertical shift",
                body: "The whole graph moves \(params.d > 0 ? "up" : "down"). Notice how the midline shifts along with it.",
                icon: "arrow.up.and.down"
            ))
        }
        
        if params.a != 1.0 && params.b != 1.0 {
            results.append(ContextInsight(
                heading: "Combined transformation",
                body: "You’re changing both height and frequency. That’s why the wave looks taller AND more compressed at the same time.",
                icon: "sparkles"
            ))
        }
        
        if type == .sine || type == .cosine {
            let period = String(format: "%.2f", 2 * .pi / params.b)
            let amp = String(format: "%.1f", abs(params.a))
            let minVal = String(format: "%.1f", params.d - abs(params.a))
            let maxVal = String(format: "%.1f", params.d + abs(params.a))
            
            results.append(ContextInsight(
                heading: "Wave properties",
                body: "Amplitude = \(amp), Period = \(period). The wave oscillates between \(minVal) and \(maxVal). Try changing one parameter at a time to see its exact effect.",
                icon: "info.circle"
            ))
        } else if type == .quadratic {
            results.append(ContextInsight(
                heading: "Parabola behavior",
                body: "‘a’ controls how wide or narrow the curve is. ‘c’ shifts it sideways, and ‘d’ moves it up or down. Try flipping ‘a’ negative to see it open downward.",
                icon: "info.circle"
            ))
        }
        
        return results
    }
}
