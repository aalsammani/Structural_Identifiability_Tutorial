#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 3: SIR Epidemic Model — Three Observation Scenarios
#
# Demonstrates how identifiability depends critically on what is measured.
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

# ─────────────────────────────────────────────────────────────
# Scenario A: Observe only infectious cases I(t)
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 3A: SIR — Observing I(t) Only")
println("=" ^ 60)
println()

sir_I_only = @ODEmodel(
    S'(t) = -beta * S(t) * I(t),
    I'(t) = beta * S(t) * I(t) - gamma * I(t),
    R'(t) = gamma * I(t),
    y(t) = I(t)
)

result_A = assess_identifiability(sir_I_only)
for (param, status) in result_A
    println("  $param => $status")
end
println()

println("Identifiable functions:")
id_funcs_A = find_identifiable_functions(sir_I_only)
println(id_funcs_A)
println()

# ─────────────────────────────────────────────────────────────
# Scenario B: Observe I(t) and R(t)
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 3B: SIR — Observing I(t) and R(t)")
println("=" ^ 60)
println()

sir_I_R = @ODEmodel(
    S'(t) = -beta * S(t) * I(t),
    I'(t) = beta * S(t) * I(t) - gamma * I(t),
    R'(t) = gamma * I(t),
    y1(t) = I(t),
    y2(t) = R(t)
)

result_B = assess_identifiability(sir_I_R)
for (param, status) in result_B
    println("  $param => $status")
end
println()

# ─────────────────────────────────────────────────────────────
# Scenario C: Observe incidence beta*S*I
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 3C: SIR — Observing Incidence beta*S*I")
println("=" ^ 60)
println()

sir_incidence = @ODEmodel(
    S'(t) = -beta * S(t) * I(t),
    I'(t) = beta * S(t) * I(t) - gamma * I(t),
    R'(t) = gamma * I(t),
    y(t) = beta * S(t) * I(t)
)

result_C = assess_identifiability(sir_incidence)
for (param, status) in result_C
    println("  $param => $status")
end
println()

println("Identifiable functions:")
id_funcs_C = find_identifiable_functions(sir_incidence)
println(id_funcs_C)
