import Foundation
import Combine

/// Owns topic list data, navigation state
class HomeController: ObservableObject {
    
    @Published var selectedTopic: String? = nil
    
    @Published var topics: [TopicItem] = [
        TopicItem(
            name: "Unit Circle",
            description: "Explore sin, cos, and tan visually",
            sfSymbol: "circle.dotted",
            category: .math
        ),
        TopicItem(
            name: "Function Transforms",
            description: "Translate and scale mathematical functions",
            sfSymbol: "function",
            category: .math
        ),
        TopicItem(
            name: "Fourier Series",
            description: "Deconstruct waves into epicycles",
            sfSymbol: "waveform",
            category: .math
        ),
        TopicItem(
            name: "Projectile Motion",
            description: "Analyze parabolic trajectories",
            sfSymbol: "arrow.up.right",
            category: .physics
        ),
        TopicItem(
            name: "Simple Harmonic Motion",
            description: "Simulate springs and pendulums",
            sfSymbol: "arrow.left.and.right",
            category: .physics
        ),
        TopicItem(
            name: "Wave Interference",
            description: "Observe ripples and superposition",
            sfSymbol: "wave.3.right",
            category: .physics
        )
    ]
}
