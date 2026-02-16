#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 7: SIR with Environmental Transmission
#
# Compares identifiability with and without wastewater surveillance data.
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

# ─────────────────────────────────────────────────────────────
# Scenario A: With wastewater data
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 7A: Environmental Model — WITH Wastewater")
println("=" ^ 60)
println()

sir_env = @ODEmodel(
    S'(t) = -betaI * S(t) * I(t) - betaW * S(t) * W(t),
    I'(t) = betaI * S(t) * I(t) + betaW * S(t) * W(t) - gamma * I(t),
    R'(t) = gamma * I(t),
    W'(t) = xi * I(t) - delta * W(t),
    y1(t) = I(t),
    y2(t) = W(t)
)

result_with = assess_identifiability(sir_env)
for (param, status) in result_with
    println("  $param => $status")
end
println()

println("Identifiable functions:")
id_funcs = find_identifiable_functions(sir_env)
println(id_funcs)
println()

# ─────────────────────────────────────────────────────────────
# Scenario B: Without wastewater data
# ─────────────────────────────────────────────────────────────
println("=" ^ 60)
println("  Example 7B: Environmental Model — WITHOUT Wastewater")
println("=" ^ 60)
println()

sir_env_noW = @ODEmodel(
    S'(t) = -betaI * S(t) * I(t) - betaW * S(t) * W(t),
    I'(t) = betaI * S(t) * I(t) + betaW * S(t) * W(t) - gamma * I(t),
    R'(t) = gamma * I(t),
    W'(t) = xi * I(t) - delta * W(t),
    y(t) = I(t)
)

result_without = assess_identifiability(sir_env_noW)
for (param, status) in result_without
    println("  $param => $status")
end
