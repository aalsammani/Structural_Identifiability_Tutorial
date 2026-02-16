#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 5: Within-Host Viral Dynamics
#
# Standard target cell-limited model. Two scenarios:
#   A: Observe viral load V(t) only (typical clinical setting)
#   B: Observe viral load V(t) and target cells T(t)
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

# ─────────────────────────────────────────────────────────────
# Scenario A: Observe V(t) only
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 5A: Viral Dynamics — V(t) Only")
println("=" ^ 60)
println()

viral_V = @ODEmodel(
    T'(t) = lambda - dT * T(t) - beta * T(t) * V(t),
    I'(t) = beta * T(t) * V(t) - delta * I(t),
    V'(t) = p * I(t) - c * V(t),
    y(t) = V(t)
)

result_V = assess_identifiability(viral_V)
for (param, status) in result_V
    println("  $param => $status")
end
println()

println("Identifiable functions:")
id_funcs_V = find_identifiable_functions(viral_V)
println(id_funcs_V)
println()

# ─────────────────────────────────────────────────────────────
# Scenario B: Observe V(t) and T(t)
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 5B: Viral Dynamics — V(t) and T(t)")
println("=" ^ 60)
println()

viral_VT = @ODEmodel(
    T'(t) = lambda - dT * T(t) - beta * T(t) * V(t),
    I'(t) = beta * T(t) * V(t) - delta * I(t),
    V'(t) = p * I(t) - c * V(t),
    y1(t) = V(t),
    y2(t) = T(t)
)

result_VT = assess_identifiability(viral_VT)
for (param, status) in result_VT
    println("  $param => $status")
end
