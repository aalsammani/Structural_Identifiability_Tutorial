#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 6: SEIR Model with Hospitalization
#
# Observations: reported cases I(t), hospital census H(t), deaths mu*H(t)
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

println("=" ^ 60)
println("  Example 6: SEIR-H Model")
println("=" ^ 60)
println()
println("  Observations: y1=I, y2=H, y3=mu*H")
println()

seir_h = @ODEmodel(
    S'(t) = -beta * S(t) * I(t) / N,
    E'(t) = beta * S(t) * I(t) / N - sigma * E(t),
    I'(t) = sigma * E(t) - gamma * I(t) - alpha * I(t),
    H'(t) = alpha * I(t) - eta * H(t) - mu * H(t),
    R'(t) = gamma * I(t) + eta * H(t),
    y1(t) = I(t),
    y2(t) = H(t),
    y3(t) = mu * H(t)
)

println("─" ^ 60)
println("  Local Identifiability")
println("─" ^ 60)
local_seir = assess_local_identifiability(seir_h)
for (param, status) in local_seir
    println("  $param => $status")
end
println()

println("─" ^ 60)
println("  Global Identifiability")
println("─" ^ 60)
global_seir = assess_identifiability(seir_h)
for (param, status) in global_seir
    println("  $param => $status")
end
