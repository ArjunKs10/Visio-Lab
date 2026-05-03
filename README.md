# Visio 🧪
**An Interactive Math & Physics Visualization Laboratory for iOS**

Visio is a production-ready educational platform designed to bring complex mathematical and physical concepts to life. Built entirely with **SwiftUI** and Apple's high-performance **Canvas API**, it provides students and educators with a modular, interactive environment to explore the laws of the universe in real-time.

---

## Features

### Interactive Visualizations
Explore a growing library of physics and math modules, each designed with a focus on interactivity and visual clarity:

*   **Projectile Motion:** Visualize trajectories with real-time parameter adjustments for velocity, angle, and gravity.
*   **Simple Harmonic Motion (SHM):** Explore oscillations, spring constants, and damping effects.
*   **Wave Interference:** Simulate constructive and destructive interference with dynamic wave generators.
*   **Fourier Series:** Break down complex waveforms into their constituent sine waves.
*   **Function Transformations:** Interact with parent functions to understand shifts, stretches, and reflections.
*   **Trigonometry:** A visual playground for unit circles, identities, and periodic functions.

### Guided Lessons
A dedicated **Learning Hub** that bridges the gap between abstract theory and interactive experimentation. Each lesson is paired with a visualization module to reinforce understanding.

### Context-Aware Insights
The **Info System** provides real-time feedback and data analysis as you manipulate parameters within the laboratory.

---

## Technology Stack

*   **Language:** Swift 5.10+
*   **Framework:** SwiftUI
*   **Graphics:** Apple Canvas API (for high-performance 60FPS rendering)
*   **Architecture:** Modular Domain-Driven Design
*   **Minimum iOS:** 17.0+

---

## Project Structure

Visio follows a modular architecture to ensure scalability and ease of contribution:

```text
Visio/
├── Core/           # Design system, Extensions, and App-wide utilities
├── Shared/         # Common UI components and Physics engines
└── Modules/        # Feature-specific domains
    ├── Projectile/ # Trajectory logic and views
    ├── SHM/        # Oscillation simulations
    └── Fourier/    # Waveform decomposition
