#!/usr/bin/env julia
# ═══════════════════════════════════════════════════════════════════════════════
# Run All Examples
#
# Executes every example script in sequence.
# Usage: julia --project=. scripts/run_all_examples.jl
# ═══════════════════════════════════════════════════════════════════════════════

scripts_dir = @__DIR__

examples = [
    "example1_decay.jl",
    "example2_scaled_decay.jl",
    "example3_sir.jl",
    "example4_pk_twocomp.jl",
    "example5_viral_dynamics.jl",
    "example6_seir_hospitalization.jl",
    "example7_environmental.jl",
]

println("╔" * "═" ^ 58 * "╗")
println("║  Structural Identifiability Tutorial — Running All Examples  ║")
println("╚" * "═" ^ 58 * "╝")
println()

for (i, script) in enumerate(examples)
    path = joinpath(scripts_dir, script)
    println()
    println("▶ [$i/$(length(examples))] Running $script ...")
    println("─" ^ 60)
    include(path)
    println()
    println("✓ $script completed.")
    println()
end

println("╔" * "═" ^ 58 * "╗")
println("║                   All examples completed!                   ║")
println("╚" * "═" ^ 58 * "╝")
