#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Example 4: Two-Compartment Pharmacokinetic Model
#
# Model with known input u(t) (drug dosing) and plasma concentration output.
# ═══════════════════════════════════════════════════════════════════════════════

using StructuralIdentifiability

println("=" ^ 60)
println("  Example 4: Two-Compartment Pharmacokinetic Model")
println("=" ^ 60)
println()
println("  dA1/dt = -(k12 + ke)·A1 + k21·A2 + u(t)")
println("  dA2/dt = k12·A1 - k21·A2")
println("  y = A1/V  (plasma concentration)")
println()

pk_2comp = @ODEmodel(
    A1'(t) = -(k12 + ke) * A1(t) + k21 * A2(t) + u(t),
    A2'(t) = k12 * A1(t) - k21 * A2(t),
    y(t) = A1(t) / V
)

println("─" ^ 60)
println("  Local Identifiability")
println("─" ^ 60)
local_pk = assess_local_identifiability(pk_2comp)
for (param, status) in local_pk
    println("  $param => $status")
end
println()

println("─" ^ 60)
println("  Global Identifiability")
println("─" ^ 60)
global_pk = assess_identifiability(pk_2comp)
for (param, status) in global_pk
    println("  $param => $status")
end
println()

println("─" ^ 60)
println("  Identifiable Functions")
println("─" ^ 60)
id_funcs_pk = find_identifiable_functions(pk_2comp)
println(id_funcs_pk)
