import Foundation

protocol InsightProvider {
    func insights() -> [ContextInsight]
}
