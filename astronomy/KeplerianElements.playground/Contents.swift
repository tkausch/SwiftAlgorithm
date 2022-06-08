import UIKit
import SceneKit
import QuartzCore   // for the basic animation
import PlaygroundSupport

//: # Keplerian Elements for Approximate Positions of the Major Planets
//: Lower accuracy formula for planetary positions have a number of important applications when one doesn't need the
//: full accuracy of an integrated ephimeris. They are often used in observation scheduling, telescope pointing,
//: and prediction of certain phenomena.
//:
//: Approximate positions of the nine major planets may be found by using Keplerian formulae with their associated
//: elements and rates. Such elements are not intended to represent any sort of mean; they are simply the result of being adjusted for best fit!
//:
//: This playground contains sufficient information, code and data to allow computation of approximate positions for the planets. The used Formulas are
//: taken from a [PDF document from JPL at NASA](https://ssd.jpl.nasa.gov/txt/aprx_pos_planets.pdf). To understand
//: formulas the follwing picture  helps:
//:
//: ## Keplerian Elements
//: The traditional orbital elements are the six Keplerian elements, after Johannes Kepler and his laws of planetary motion.
//:
//: When viewed from an inertial frame, two orbiting bodies trace out distinct trajectories. Each of these trajectories has its focus at the common center of mass. When viewed from a non-inertial frame centred on one of the bodies, only the trajectory of the opposite body is apparent; Keplerian elements describe these non-inertial trajectories. An orbit has two sets of Keplerian elements depending on which body is used as the point of reference. The reference body (usually the most massive) is called the primary, the other body is called the secondary. The primary does not necessarily possess more mass than the secondary, and even when the bodies are of equal mass, the orbital elements depend on the choice of the primary.
//:
//: Two elements define the shape and size of the ellipse:
//: * Eccentricity (e)—shape of the ellipse, describing how much it is elongated compared to a circle (not marked in diagram).
//:* Semimajor axis (a) — the sum of the periapsis and apoapsis distances divided by two. For classic two-body orbits, the semimajor axis is the distance between the centers of the bodies, not the distance of the bodies from the center of mass.
//:
//: Two elements define the orientation of the orbital plane in which the ellipse is embedded:
//: * Inclination (i) — vertical tilt of the ellipse with respect to the reference plane, measured at the ascending node (where the orbit passes upward through the reference plane, the green angle i in the diagram). Tilt angle is measured perpendicular to line of intersection between orbital plane and reference plane. Any three points on an ellipse will define the ellipse orbital plane. The plane and the ellipse are both two-dimensional objects defined in three-dimensional space.
//: * Longitude of the ascending node (Ω) — horizontally orients the ascending node of the ellipse (where the orbit passes upward through the reference plane, symbolized by ☊) with respect to the reference frame's vernal point (symbolized by ♈︎). This is measured in the reference plane, and is shown as the green angle Ω in the diagram.
//:
//: The remaining two elements are as follows:
//: * Argument of periapsis (ω) defines the orientation of the ellipse in the orbital plane, as an angle measured from the ascending node to the periapsis (the closest point the satellite object comes to the primary object around which it orbits, the blue angle ω in the diagram).
//: * True anomaly (ν, θ, or f) at epoch (t0) defines the position of the orbiting body along the ellipse at a specific time (the "epoch").
//:
//: The mean anomaly M is a mathematically convenient fictitious "angle" which varies linearly with time, but which does not correspond to a real geometric angle. It can be converted into the true anomaly ν, which does represent the real geometric angle in the plane of the ellipse, between periapsis (closest approach to the central body) and the position of the orbiting object at any given time. Thus, the true anomaly is shown as the red angle ν in the diagram, and the mean anomaly is not shown.
//:
//: The angles of inclination, longitude of the ascending node, and argument of periapsis can also be described as the [Euler angles](https://en.wikipedia.org/wiki/Euler_angles) defining the orientation of the orbit relative to the reference coordinate system.
//:
//: ![Planet Orbits](../Resources/Orbit1.png)
//:
//:
//: ## Mean longitude
//: [Mean longitude](https://en.wikipedia.org/wiki/Mean_longitude) is the ecliptic longitude at which an orbiting body
//: could be found if its orbit were circular and free of perturbations. While nominally a simple longitude, in practice the mean longitude does
//: not correspond to any one physical angle.
//:
//: * Define a reference direction, ♈︎, along the ecliptic. Typically, this is the direction of the *vernal equinox*. At this point, ecliptic longitude is 0°.
//: * The body's orbit is generally inclined to the ecliptic, therefore define the angular distance from ♈︎ to the place where the orbit crosses the ecliptic from south to north *as the longitude of the ascending node*, Ω.
//: * Define the angular distance along the plane of the orbit from the ascending node to the pericenter as the *argument of the pericenter*, ω.
//: * Define the *mean anomaly*, M, as the angular distance from the pericenter which the body would have if it moved in a circular orbit, in the same orbital period as the actual body in its elliptical orbit.
//:
//: From these definitions, the *mean longitude*, L, is the angular distance the body would have from the reference direction if it moved with uniform speed
//:
//:  L = Ω + ω + M  (1)
//:
//: ![Planet Orbits](../Resources/Orbit1-mean.png)
//:  An orbiting body's mean longitude is calculated L = Ω + ω + M, where Ω is the longitude of the ascending node, ω is the argument of the
//: pericenter and M is the *mean anomaly*, the body's angular distance from the pericenter as if it moved with constant speed rather than with
//: the variable speed of an elliptical orbit. Its true longitude is calculated similarly,   Ω + ω + ν, where ν is the *true anomaly*.
//:
//: ## Keplerian elements Data
//:  Tables containing the required Keplerian elements are provided in plain ASCII text format to allow for both human and machine readability. Have a look at
//:  at the figure below to understand what these values mean.
//: * [Keplarian elements for 1800 AD to 2050 AD](https://ssd.jpl.nasa.gov/txt/p_elem_t1.txt)
//: * [Keplarian elements for 3000 BC to 3000 AD](https://ssd.jpl.nasa.gov/txt/p_elem_t2.txt)
//:
//: ## High precision ephermerides
//:  High precision ephemerides for the planets are available via NASA's [HORIZONS system](https://ssd.jpl.nasa.gov/?horizons).
//:
struct PlanetaryOrbit {
    
    // semi major axis of orbit ellipse [au, au/cy]
    private let a0, Δa: Float
    private var a: Float?
    
    // eccentricity of orbit ellipse [, /cy]
    private let e0, Δe: Float
    private var e: Float?
    
    // inclination with units [deg, deg/cy]
    private let I0, ΔI: Float
    private var I: Float?
    
    // mean longitude [deg, deg/cy]
    private let L0, ΔL: Float
    private var L: Float?
    
    // longitued of the perihelion (β = ω +  Ω) [deg, deg/cy]
    private let β0, Δβ: Float
    private var β: Float?
    
    // logngitude of ascending node [deg, deg/cy]
    let Ω0, ΔΩ: Float
    var Ω: Float?
    
    
    init(a0: Float, Δa: Float, e0: Float, Δe: Float, I0: Float, ΔI: Float, L0:Float, ΔL:Float, β0: Float, Δβ: Float, Ω0: Float, ΔΩ: Float) {
        self.a0 = a0
        self.e0 = e0
        self.I0 = I0
        self.β0 = β0
        self.L0 = L0
        self.Ω0 = Ω0
        
        self.Δa = Δa
        self.Δe = Δe
        self.ΔI = ΔI
        self.Δβ = Δβ
        self.ΔL = ΔL
        self.ΔΩ = ΔΩ
    }
    
    
    
    
}
