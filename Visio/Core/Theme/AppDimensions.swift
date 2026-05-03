import Foundation

/// Spacing, corner radius, padding constants
/// All layout values in one place — no hardcoded magic numbers in views.
struct AppDimensions {

    // MARK: - Corner Radii

    /// Card corner radius (TopicCard, SectionCard)
    static let cardCornerRadius: CGFloat = 16

    /// Small corner radius (badges, pills)
    static let badgeCornerRadius: CGFloat = 8

    /// Button corner radius
    static let buttonCornerRadius: CGFloat = 12

    // MARK: - Padding

    /// Card internal padding
    static let cardPadding: CGFloat = 16

    /// Screen edge padding (horizontal safe area inset)
    static let screenPadding: CGFloat = 16

    /// Section spacing (between major UI blocks)
    static let sectionSpacing: CGFloat = 20

    /// Item spacing within a section
    static let itemSpacing: CGFloat = 12

    /// Compact spacing (within badges, between label and value)
    static let compactSpacing: CGFloat = 4

    /// Tight spacing (between very close elements)
    static let tightSpacing: CGFloat = 2

    // MARK: - Grid Layout

    /// Home grid spacing between columns/rows
    static let gridSpacing: CGFloat = 16

    /// Home grid number of columns
    static let gridColumns: Int = 2

    // MARK: - Canvas

    /// Canvas occupies top 58% of screen height
    static let canvasHeightFraction: CGFloat = 0.58

    /// Canvas internal padding (from edge of canvas to drawn content)
    static let canvasPadding: CGFloat = 16

    // MARK: - Controls

    /// Minimum tap target size (Apple HIG)
    static let minTapTarget: CGFloat = 44

    /// Slider thumb size
    static let sliderThumbSize: CGFloat = 28

    /// Standard control height
    static let controlHeight: CGFloat = 44

    // MARK: - Specific Component Sizes

    /// Draggable point radius on unit circle
    static let draggablePointRadius: CGFloat = 12

    /// Projectile ball radius
    static let projectileBallRadius: CGFloat = 10

    /// Pendulum bob radius
    static let pendulumBobRadius: CGFloat = 16

    /// Pendulum pivot radius
    static let pendulumPivotRadius: CGFloat = 6

    /// SHM graph height
    static let shmGraphHeight: CGFloat = 120

    /// Wave source pulse max radius
    static let waveSourceMaxRadius: CGFloat = 8

    // MARK: - Stroke Widths

    /// Standard line width (axes, radius line)
    static let standardStroke: CGFloat = 2

    /// Thin line width (projections, dashed lines)
    static let thinStroke: CGFloat = 1.5

    /// Grid minor line width
    static let gridMinorStroke: CGFloat = 0.5

    /// Grid major line width
    static let gridMajorStroke: CGFloat = 1

    /// Bold stroke (axes)
    static let boldStroke: CGFloat = 2

    // MARK: - Shadow

    /// Maximum shadow radius (per UI rules: ≤ 4)
    static let maxShadowRadius: CGFloat = 4

    /// Standard card shadow radius
    static let cardShadowRadius: CGFloat = 2

    // MARK: - Animation Counts / Limits

    /// Maximum trace points for Fourier
    static let maxFourierTracePoints: Int = 1000

    /// Maximum displacement history samples for SHM
    static let maxSHMSamples: Int = 200

    /// Number of plot samples for function transform curves
    static let functionPlotSamples: Int = 500

    /// Wave interference grid resolution (NxN)
    static let waveGridResolution: Int = 60

    /// Number of ghost trail positions for SHM pendulum
    static let ghostTrailCount: Int = 8

    /// Number of spring coils for spring-mass
    static let springCoilCount: Int = 8

    // MARK: - Snap Angles (degrees)

    /// Special angles for unit circle snapping
    static let snapAngles: [Double] = [
        0, 30, 45, 60, 90, 120, 135, 150,
        180, 210, 225, 240, 270, 300, 315, 330, 360
    ]

    /// Snap threshold in degrees
    static let snapThreshold: Double = 5
}
