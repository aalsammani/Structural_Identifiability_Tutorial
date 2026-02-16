#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 2: First-Order Decay with Unknown Scaling
#
# Model:  dx/dt = -k * x,  y = a * x
# Parameters: k, a, x(0)
# Result: k is globally identifiable; a and x(0) are nonidentifiable
#         but the product a·x(0) is an identifiable function
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

println("=" ^ 60)
println("  Example 2: Decay with Unknown Scaling Factor")
println("=" ^ 60)
println()
println("  Model:  dx/dt = -k·x")
println("  Output: y = a·x  (scaled observation)")
println("  Unknowns: k, a, x(0)")
println()

scaled_decay = @ODEmodel(
    x'(t) = -k * x(t),
    y(t) = a * x(t)
)

# Global identifiability
println("─" ^ 60)
println("  Global Identifiability")
println("─" ^ 60)
global_result = assess_identifiability(scaled_decay)
for (param, status) in global_result
    println("  $param => $status")
end
println()

# Identifiable functions
println("─" ^ 60)
println("  Identifiable Functions")
println("─" ^ 60)
id_funcs = find_identifiable_functions(scaled_decay)
println(id_funcs)
println()

println("Interpretation: k is globally identifiable (from the exponential rate).")
println("a and x(0) are nonidentifiable individually, but their product a·x(0)")
println("is identifiable (it determines the amplitude of the observed signal).")
