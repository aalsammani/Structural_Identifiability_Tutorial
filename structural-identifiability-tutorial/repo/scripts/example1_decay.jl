#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 1: First-Order Decay Kinetics
#
# Model:  dx/dt = -k * x,  y = x
# Parameters: k (elimination rate), x(0) (initial condition)
# Result: Both parameters are globally identifiable
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

println("=" ^ 60)
println("  Example 1: First-Order Decay — Direct Observation")
println("=" ^ 60)
println()
println("  Model:  dx/dt = -k·x")
println("  Output: y = x  (direct observation)")
println("  Unknowns: k, x(0)")
println()

# Define the model
simple_decay = @ODEmodel(
    x'(t) = -k * x(t),
    y(t) = x(t)
)

# Local identifiability (fast check)
println("─" ^ 60)
println("  Local Identifiability")
println("─" ^ 60)
local_result = assess_local_identifiability(simple_decay)
for (param, status) in local_result
    println("  $param => $status")
end
println()

# Global identifiability
println("─" ^ 60)
println("  Global Identifiability")
println("─" ^ 60)
global_result = assess_identifiability(simple_decay)
for (param, status) in global_result
    println("  $param => $status")
end
println()

println("Interpretation: Both k and x(0) are globally identifiable.")
println("From the output y(t) = x₀·exp(-kt), the rate k is determined")
println("by the exponential shape, and x₀ is determined by y(0).")
