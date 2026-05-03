import Foundation

final class LessonsController: ObservableObject {
    @Published var lessons: [LessonContent] = []
    @Published var completedLessonIDs: Set<String> = []
    
    init() {
        self.lessons = LessonsController.staticLessons()
    }
    
    func markComplete(id: String) {
        completedLessonIDs.insert(id)
    }
    
    func lesson(for topic: TopicID) -> LessonContent? {
        return lessons.first(where: { $0.topicID == topic })
    }
    
    private static func staticLessons() -> [LessonContent] {
        return [
            // Lesson 1: Unit Circle
            LessonContent(
                id: "unit-circle",
                topicID: .unitCircle,
                title: "Unit Circle",
                subtitle: "The foundation of all trigonometry",
                estimatedMinutes: 4,
                sections: [
                    LessonSection(
                        heading: "What is the Unit Circle?",
                        body: "The unit circle is a circle with radius exactly 1, centred at the origin of a coordinate plane. It is the single most important diagram in trigonometry — almost everything else follows from it.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Where do sin and cos come from?",
                        body: "When you place a point on the unit circle at angle θ, its x-coordinate IS cos(θ) and its y-coordinate IS sin(θ). This is not a coincidence or a definition you have to memorise — it falls directly from the geometry of right triangles inside the circle.",
                        callout: LessonSection.Callout(icon: "lightbulb", text: "cos is always the horizontal distance, sin is always the vertical distance. Every time. No exceptions.")
                    ),
                    LessonSection(
                        heading: "What about tan?",
                        body: "tan(θ) = sin(θ)/cos(θ). Geometrically it is the slope of the radius line. When cos = 0 (at 90° and 270°) the slope is undefined — the line is perfectly vertical. That is why tan is undefined at those angles.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "The four quadrants",
                        body: "Explain ASTC (All Students Take Calculus) rule — which functions are positive in each quadrant. Tie it to the signs of x and y coordinates in each quadrant.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Special angles you must know",
                        body: "0°, 30°, 45°, 60°, 90° and their exact values. Explain the \"hand trick\" pattern: sin values go √0/2, √1/2, √2/2, √3/2, √4/2 as angle goes 0→90°.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Pythagorean identity", formula: "sin²(θ) + cos²(θ) = 1", variables: []),
                    FormulaBlock(label: "Tangent identity", formula: "tan(θ) = sin(θ) / cos(θ)", variables: [])
                ]
            ),
            
            // Lesson 2: Function Transforms
            LessonContent(
                id: "function-transforms",
                topicID: .functionTransforms,
                title: "Function Transforms",
                subtitle: "How parameters reshape any graph",
                estimatedMinutes: 5,
                sections: [
                    LessonSection(
                        heading: "The master equation",
                        body: "y = a·f(b·x + c) + d controls EVERY standard transformation of any function. Understanding what each parameter does gives you power over any graph.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "a — Vertical stretch and flip",
                        body: "Multiplying the output by 'a' stretches or squashes the graph vertically. If a > 1 it grows taller, 0 < a < 1 it shrinks, and a < 0 flips it upside down. Amplitude of a wave = |a|.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "b — Horizontal stretch and frequency",
                        body: "'b' affects the x-axis. Counterintuitively, larger b makes the graph compressed (not stretched). Period of sin/cos = 2π/b.",
                        callout: LessonSection.Callout(icon: "exclamationmark.triangle", text: "b is the trickiest one — bigger b means MORE cycles in the same space, not fewer.")
                    ),
                    LessonSection(
                        heading: "c — Phase shift (horizontal slide)",
                        body: "Adding c inside f() shifts the graph left or right. The shift is −c/b units horizontally.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "d — Vertical shift (DC offset)",
                        body: "d simply moves the entire graph up or down. The midline of the wave is y = d.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Period (for sin and cos)", formula: "Period = 2π / b", variables: []),
                    FormulaBlock(label: "Phase shift", formula: "Phase shift = −c / b", variables: []),
                    FormulaBlock(label: "Amplitude", formula: "Amplitude = |a|", variables: [])
                ]
            ),
            
            // Lesson 3: Fourier Series
            LessonContent(
                id: "fourier-series",
                topicID: .fourierSeries,
                title: "Fourier Series",
                subtitle: "Any wave is just sine waves added together",
                estimatedMinutes: 6,
                sections: [
                    LessonSection(
                        heading: "The big idea",
                        body: "Joseph Fourier discovered in 1822 that ANY repeating signal — no matter how complex — can be built by adding together simple sine waves of different frequencies and amplitudes. This idea underpins all of modern signal processing, audio, and physics.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Building a square wave",
                        body: "A perfect square wave seems nothing like a sine wave. Yet you can approximate it by adding: sin(x) + sin(3x)/3 + sin(5x)/5... The more terms you add, the closer the sum gets to a true square.",
                        callout: LessonSection.Callout(icon: "lightbulb", text: "The 'ringing' you see at the edges as you add more harmonics is called Gibbs phenomenon — it never fully disappears, even with infinite terms.")
                    ),
                    LessonSection(
                        heading: "What is a harmonic?",
                        body: "The first harmonic is the base frequency. The second harmonic oscillates twice as fast, the third three times as fast, and so on. Each harmonic is one rotating circle in the visualiser.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Why does this matter?",
                        body: "MP3 audio compression, JPEG image compression, radio transmission, MRI machines, noise-cancelling headphones — all of these work by decomposing signals into their frequency components (Fourier transform) and then manipulating them.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "The three wave shapes",
                        body: "Square wave: only odd harmonics, amplitude 4/(nπ). Sawtooth wave: all harmonics, amplitude 2/(nπ) alternating sign. Triangle wave: only odd harmonics, amplitude 8/(n²π²) — converges much faster than square because of the n² denominator.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Square wave", formula: "aₙ = 4/(nπ) for odd n", variables: []),
                    FormulaBlock(label: "Sawtooth wave", formula: "aₙ = 2/(nπ)·(−1)^(n+1)", variables: []),
                    FormulaBlock(label: "Triangle wave", formula: "aₙ = 8/(n²π²) for odd n", variables: [])
                ]
            ),
            
            // Lesson 4: Projectile Motion
            LessonContent(
                id: "projectile-motion",
                topicID: .projectileMotion,
                title: "Projectile Motion",
                subtitle: "Gravity + inertia = a perfect parabola",
                estimatedMinutes: 4,
                sections: [
                    LessonSection(
                        heading: "The two independent motions",
                        body: "A projectile has two completely independent motions happening simultaneously: horizontal (constant velocity, no force) and vertical (constant acceleration downward due to gravity). They do not affect each other at all.",
                        callout: LessonSection.Callout(icon: "lightbulb", text: "A bullet fired horizontally and a bullet dropped from the same height will hit the ground at exactly the same time. Horizontal speed does not delay the fall.")
                    ),
                    LessonSection(
                        heading: "Breaking velocity into components",
                        body: "Initial velocity u at angle θ splits into:\nVx = u·cos(θ) — stays constant throughout the flight.\nVy = u·sin(θ) — starts positive (upward), decreases at rate g, reaches 0 at peak, then goes negative on the way down.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "The three key results",
                        body: "Time of flight depends on how long it takes gravity to cancel the vertical velocity and bring the object back down. Max height is determined solely by the initial vertical velocity. Range is horizontal velocity multiplied by time of flight. 45° gives maximum range on flat ground because sin(2θ) is maximum at 90°. 30° and 60° give the same range because they are complementary angles.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Gravity on other worlds",
                        body: "On the Moon (g = 1.6 m/s²) everything flies much further. On Jupiter (g = 24.8 m/s²) everything crashes back down fast. Same equations, different constant.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Range", formula: "R = u²·sin(2θ) / g", variables: []),
                    FormulaBlock(label: "Max height", formula: "H = u²·sin²(θ) / (2g)", variables: []),
                    FormulaBlock(label: "Time of flight", formula: "T = 2u·sin(θ) / g", variables: [])
                ]
            ),
            
            // Lesson 5: Simple Harmonic Motion
            LessonContent(
                id: "simple-harmonic-motion",
                topicID: .simpleHarmonicMotion,
                title: "Simple Harmonic Motion",
                subtitle: "The most common motion in all of physics",
                estimatedMinutes: 5,
                sections: [
                    LessonSection(
                        heading: "What makes motion 'harmonic'?",
                        body: "SHM happens when a restoring force always pulls toward equilibrium, and that force is proportional to displacement. The further you pull, the harder it pulls back. This produces perfect sinusoidal oscillation.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "The pendulum",
                        body: "For small angles (under ~15°), a pendulum behaves as SHM. The period depends only on length and gravity — NOT on mass or amplitude. A heavier bob and a lighter bob on the same length string swing in perfect sync.",
                        callout: LessonSection.Callout(icon: "exclamationmark.triangle", text: "Period is independent of amplitude only for small angles. Large swings are NOT true SHM — they are slower than the formula predicts.")
                    ),
                    LessonSection(
                        heading: "The spring-mass system",
                        body: "Hooke's Law: F = −kx. The spring constant k measures stiffness. Period = 2π√(m/k). Heavier mass → slower. Stiffer spring → faster. Unlike the pendulum, mass DOES affect the period here.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "x(t) = A·cos(ωt)",
                        body: "This is the equation of SHM. A is amplitude (max displacement), ω is angular frequency (= 2π/T), t is time. As amplitude increases, the wave gets taller. As period increases, the wave gets wider.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "SHM is everywhere",
                        body: "Vibrating strings, atoms in a lattice, LC electrical circuits, tides, car suspensions, the eardrum responding to sound — all described by the same equation.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Period (pendulum)", formula: "T = 2π√(L/g)", variables: []),
                    FormulaBlock(label: "Period (spring)", formula: "T = 2π√(m/k)", variables: []),
                    FormulaBlock(label: "Equation of motion", formula: "x(t) = A·cos(ωt)", variables: []),
                    FormulaBlock(label: "Angular frequency", formula: "ω = 2π/T", variables: [])
                ]
            ),
            
            // Lesson 6: Wave Interference
            LessonContent(
                id: "wave-interference",
                topicID: .waveInterference,
                title: "Wave Interference",
                subtitle: "What happens when two waves meet",
                estimatedMinutes: 5,
                sections: [
                    LessonSection(
                        heading: "The superposition principle",
                        body: "When two waves occupy the same space, the total displacement at every point is simply the sum of the individual displacements. Waves pass through each other unchanged — they do not \"collide\".",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Constructive interference",
                        body: "When two waves arrive at a point in phase (crest meets crest), amplitudes add. The result is a wave with double the amplitude. This happens wherever the path difference = nλ (a whole number of wavelengths).",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "Destructive interference",
                        body: "When waves arrive exactly out of phase (crest meets trough), they cancel. The result is silence/stillness. This happens wherever path difference = (n + ½)λ.",
                        callout: LessonSection.Callout(icon: "lightbulb", text: "Noise-cancelling headphones work by playing the exact destructive interference pattern of ambient sound into your ears.")
                    ),
                    LessonSection(
                        heading: "Beats",
                        body: "When two sources have slightly different frequencies, they drift in and out of phase over time. The amplitude rises and falls rhythmically. Beat frequency = |f1 − f2|. Musicians use this to tune instruments — when beats disappear, the frequencies match.",
                        callout: nil
                    ),
                    LessonSection(
                        heading: "The interference pattern",
                        body: "Two sources in 2D create a symmetric pattern of bright (constructive) and dark (destructive) fringes. This pattern is called Young's double-slit pattern in light, and is the foundation of the wave theory of light.",
                        callout: nil
                    )
                ],
                keyFormulas: [
                    FormulaBlock(label: "Constructive interference", formula: "path difference = nλ", variables: []),
                    FormulaBlock(label: "Destructive interference", formula: "path difference = (n + ½)λ", variables: []),
                    FormulaBlock(label: "Beat frequency", formula: "Beat frequency = |f1 − f2|", variables: [])
                ]
            )
        ]
    }
}
