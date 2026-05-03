import Foundation

// ============================================================
// CoordinateTransform Unit Tests
// Run: swift CoordinateTransformTests.swift ../Visio/Shared/Canvas/CoordinateTransform.swift
// ============================================================

var passed = 0
var failed = 0

func assertEqual(_ a: CGFloat, _ b: CGFloat, tolerance: CGFloat = 0.001, _ message: String = "", line: Int = #line) {
    if abs(a - b) <= tolerance {
        passed += 1
    } else {
        failed += 1
        print("  ✗ FAIL (line \(line)): \(message) — expected \(b), got \(a)")
    }
}

func assertPointEqual(_ a: CGPoint, _ b: CGPoint, tolerance: CGFloat = 0.001, _ message: String = "", line: Int = #line) {
    if abs(a.x - b.x) <= tolerance && abs(a.y - b.y) <= tolerance {
        passed += 1
    } else {
        failed += 1
        print("  ✗ FAIL (line \(line)): \(message) — expected \(b), got \(a)")
    }
}

func test(_ name: String, _ block: () -> Void) {
    print("▸ \(name)")
    block()
}

// ============================================================
// Tests
// ============================================================

print("╔══════════════════════════════════════════════╗")
print("║   CoordinateTransform Unit Tests             ║")
print("╚══════════════════════════════════════════════╝\n")

// --- toScreen ---

test("toScreen: origin maps to screen origin") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toScreen(CGPoint(x: 0, y: 0))
    assertPointEqual(result, CGPoint(x: 200, y: 300), "math (0,0) → screen origin")
}

test("toScreen: positive X moves right") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toScreen(CGPoint(x: 1, y: 0))
    assertPointEqual(result, CGPoint(x: 250, y: 300), "math (1,0) → screen (250,300)")
}

test("toScreen: positive Y moves UP (screen Y decreases)") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toScreen(CGPoint(x: 0, y: 1))
    assertPointEqual(result, CGPoint(x: 200, y: 250), "math (0,1) → screen (200,250)")
}

test("toScreen: negative values") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toScreen(CGPoint(x: -2, y: -3))
    assertPointEqual(result, CGPoint(x: 100, y: 450), "math (-2,-3) → screen (100,450)")
}

test("toScreen: fractional coordinates") {
    let t = CoordinateTransform(origin: CGPoint(x: 100, y: 100), scale: 100)
    let result = t.toScreen(CGPoint(x: 0.5, y: 0.25))
    assertPointEqual(result, CGPoint(x: 150, y: 75), "math (0.5,0.25) → screen (150,75)")
}

// --- toMath ---

test("toMath: screen origin maps to math origin") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toMath(CGPoint(x: 200, y: 300))
    assertPointEqual(result, CGPoint(x: 0, y: 0), "screen origin → math (0,0)")
}

test("toMath: screen right of origin → positive X") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toMath(CGPoint(x: 250, y: 300))
    assertPointEqual(result, CGPoint(x: 1, y: 0), "screen (250,300) → math (1,0)")
}

test("toMath: screen above origin → positive Y") {
    let t = CoordinateTransform(origin: CGPoint(x: 200, y: 300), scale: 50)
    let result = t.toMath(CGPoint(x: 200, y: 250))
    assertPointEqual(result, CGPoint(x: 0, y: 1), "screen (200,250) → math (0,1)")
}

// --- Round-trip: toScreen ∘ toMath = identity ---

test("Round-trip: toMath(toScreen(p)) == p for various points") {
    let t = CoordinateTransform(origin: CGPoint(x: 150, y: 250), scale: 75)
    let testPoints: [CGPoint] = [
        CGPoint(x: 0, y: 0),
        CGPoint(x: 1, y: 1),
        CGPoint(x: -1, y: -1),
        CGPoint(x: 3.14, y: -2.71),
        CGPoint(x: -0.5, y: 0.5),
        CGPoint(x: 10, y: -10),
    ]
    for p in testPoints {
        let roundTripped = t.toMath(t.toScreen(p))
        assertPointEqual(roundTripped, p, "round-trip math→screen→math for \(p)")
    }
}

test("Round-trip: toScreen(toMath(p)) == p for various screen points") {
    let t = CoordinateTransform(origin: CGPoint(x: 150, y: 250), scale: 75)
    let testPoints: [CGPoint] = [
        CGPoint(x: 0, y: 0),
        CGPoint(x: 100, y: 100),
        CGPoint(x: 300, y: 500),
        CGPoint(x: 150, y: 250),
        CGPoint(x: 50, y: 400),
    ]
    for p in testPoints {
        let roundTripped = t.toScreen(t.toMath(p))
        assertPointEqual(roundTripped, p, "round-trip screen→math→screen for \(p)")
    }
}

// --- scaleLength ---

test("scaleLength: positive math length") {
    let t = CoordinateTransform(origin: CGPoint(x: 0, y: 0), scale: 50)
    let result = t.scaleLength(2.0)
    assertEqual(result, 100, "2 math units → 100 pixels at scale 50")
}

test("scaleLength: negative math length returns positive") {
    let t = CoordinateTransform(origin: CGPoint(x: 0, y: 0), scale: 50)
    let result = t.scaleLength(-3.0)
    assertEqual(result, 150, "|-3| math units → 150 pixels at scale 50")
}

// --- scaled ---

test("scaled: doubles the scale factor") {
    let t = CoordinateTransform(origin: CGPoint(x: 100, y: 200), scale: 50)
    let zoomed = t.scaled(by: 2.0)
    assertEqual(zoomed.scale, 100, "scale 50 × 2 = 100")
    assertPointEqual(zoomed.origin, CGPoint(x: 100, y: 200), "origin unchanged")
}

// --- centered factory ---

test("centered: places origin at center of size") {
    let t = CoordinateTransform.centered(in: CGSize(width: 400, height: 600), scale: 50)
    assertPointEqual(t.origin, CGPoint(x: 200, y: 300), "origin at center")
    assertEqual(t.scale, 50, "scale preserved")
}

// --- visibleXRange ---

test("visibleXRange: symmetric around origin when centered") {
    let t = CoordinateTransform.centered(in: CGSize(width: 400, height: 400), scale: 50)
    let range = t.visibleXRange(screenWidth: 400)
    assertEqual(CGFloat(range.lowerBound), -4.0, "left edge at -4")
    assertEqual(CGFloat(range.upperBound), 4.0, "right edge at +4")
}

// --- visibleYRange ---

test("visibleYRange: symmetric around origin when centered") {
    let t = CoordinateTransform.centered(in: CGSize(width: 400, height: 400), scale: 50)
    let range = t.visibleYRange(screenHeight: 400)
    assertEqual(CGFloat(range.lowerBound), -4.0, "bottom edge at -4")
    assertEqual(CGFloat(range.upperBound), 4.0, "top edge at +4")
}

// --- fitting factory ---

test("fitting: math range fills screen with correct scale") {
    let t = CoordinateTransform.fitting(
        xRange: -5...5,
        yRange: -5...5,
        in: CGSize(width: 400, height: 400),
        padding: 0
    )
    // 10 math units should fit in 400px → scale = 40
    assertEqual(t.scale, 40, "fitting scale for 10 units in 400px")
}

// ============================================================
// Summary
// ============================================================

print("\n══════════════════════════════════════════════")
if failed == 0 {
    print("✅ All \(passed) assertions passed!")
} else {
    print("❌ \(failed) assertion(s) failed out of \(passed + failed)")
}
print("══════════════════════════════════════════════")

if failed > 0 {
    exit(1)
}
