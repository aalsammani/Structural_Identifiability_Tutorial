# Structural Identifiability Analysis: Tutorial

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Julia](https://img.shields.io/badge/Julia-1.6%2B-purple.svg)](https://julialang.org/)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)](https://jupyter.org/)
[![DOI](https://img.shields.io/badge/DOI-pending-lightgrey.svg)]()

A hands-on, tutorial-style introduction to **structural identifiability analysis** for ODE-based mathematical models, with complete Julia implementations using [StructuralIdentifiability.jl](https://github.com/SciML/StructuralIdentifiability.jl).

> **Companion to:** *"Structural and Practical Identifiability Analysis in Mathematical Modeling: A Comprehensive Survey and Tutorial"* by Abdallah Alsammani, Department of Mathematical Sciences, Delaware State University.

---

## What Is Structural Identifiability?

Before estimating parameters of a mathematical model from data, a fundamental question must be answered:

> *Given the model structure and which variables can be measured, is it theoretically possible to uniquely determine the parameter values?*

If the answer is **no**, then no amount of data — no matter how precise or abundant — can resolve the parameter values. Parameter estimates from such models are arbitrary, and any conclusions drawn from them are unreliable.

**Structural identifiability analysis** answers this question rigorously, using only the model equations and the observation specification, before any data are collected.

<p align="center">
  <img src="docs/identifiability_flowchart.png" alt="Identifiability Workflow" width="600">
</p>

## Why This Repository?

Despite its importance, identifiability analysis remains underused in applied research because:

- The mathematical theory (differential algebra, Lie derivatives) can seem intimidating
- Software tools have historically required specialized expertise
- Many textbooks treat identifiability abstractly, without runnable code

This repository bridges that gap with a **step-by-step, example-driven tutorial** that requires no prior knowledge of identifiability theory. Every concept is illustrated with a concrete model, mathematical explanation, and executable Julia code.

## Repository Contents

```
structural-identifiability-tutorial/
│
├── README.md                       ← You are here
├── LICENSE                         ← MIT License
├── CITATION.cff                    ← Citation metadata
├── Project.toml                    ← Julia dependencies
├── .gitignore                      ← Git ignore rules
├── CONTRIBUTING.md                 ← Contribution guidelines
│
├── Structural_Identifiability_Tutorial.ipynb
│                                   ← Main tutorial notebook (start here)
│
├── scripts/                        ← Standalone Julia scripts
│   ├── example1_decay.jl
│   ├── example2_scaled_decay.jl
│   ├── example3_sir.jl
│   ├── example4_pk_twocomp.jl
│   ├── example5_viral_dynamics.jl
│   ├── example6_seir_hospitalization.jl
│   ├── example7_environmental.jl
│   └── run_all_examples.jl         ← Run every example in sequence
│
├── docs/                           ← Supporting documentation
│   ├── mathematical_background.md  ← Extended mathematical reference
│   ├── software_comparison.md      ← Comparison of identifiability tools
│   └── identifiability_flowchart.png
│
└── examples/                       ← Additional models (community contributions welcome)
    └── README.md
```

## Quick Start

### Option 1: Jupyter Notebook (Recommended for Learning)

1. **Install Julia** (version 1.6 or later) from [julialang.org](https://julialang.org/downloads/)

2. **Install IJulia** (Julia kernel for Jupyter):
   ```julia
   using Pkg
   Pkg.add("IJulia")
   ```

3. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/structural-identifiability-tutorial.git
   cd structural-identifiability-tutorial
   ```

4. **Install dependencies:**
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

5. **Open the notebook:**
   ```bash
   jupyter notebook Structural_Identifiability_Tutorial.ipynb
   ```

### Option 2: Standalone Scripts (Quick Results)

Run any individual example directly:

```bash
julia --project=. scripts/example3_sir.jl
```

Or run all examples at once:

```bash
julia --project=. scripts/run_all_examples.jl
```

### Option 3: Julia REPL

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using StructuralIdentifiability

# Define any model and analyze it
model = @ODEmodel(
    x'(t) = -k * x(t),
    y(t) = x(t)
)

assess_identifiability(model)
```

## Tutorial Overview

The notebook covers seven examples of increasing complexity:

| # | Model | Domain | Key Lesson |
|---|-------|--------|------------|
| 1 | First-order decay | Chemistry/PK | Direct observation → full identifiability |
| 2 | Scaled decay | General | Unknown scaling → nonidentifiability |
| 3 | SIR epidemic (3 scenarios) | Epidemiology | Identifiability depends on what you measure |
| 4 | Two-compartment PK | Pharmacology | Known inputs (doses) improve identifiability |
| 5 | Viral dynamics (2 scenarios) | Virology | Guides experimental design decisions |
| 6 | SEIR with hospitalization | Epidemiology | Multiple data streams resolve different parameters |
| 7 | Environmental transmission | Epidemiology | Wastewater data resolves fundamental ambiguities |

Each example includes:
- Complete model description with equations
- Intuitive explanation of expected results
- Executable Julia code
- Detailed interpretation of software output
- Practical takeaways

## Three Key Functions

The entire analysis uses just three functions from `StructuralIdentifiability.jl`:

| Function | Purpose | Speed |
|----------|---------|-------|
| `assess_local_identifiability(model)` | Quick screen: is each parameter locally identifiable? | Fast |
| `assess_identifiability(model)` | Full classification: globally, locally, or nonidentifiable | Moderate |
| `find_identifiable_functions(model)` | What parameter combinations *can* be estimated? | Moderate |

## Requirements

| Dependency | Version | Purpose |
|------------|---------|---------|
| [Julia](https://julialang.org/) | ≥ 1.6 | Programming language |
| [StructuralIdentifiability.jl](https://github.com/SciML/StructuralIdentifiability.jl) | ≥ 0.5 | Identifiability analysis |
| [IJulia](https://github.com/JuliaLang/IJulia.jl) | Any | Jupyter kernel (notebook only) |

All Julia dependencies are specified in `Project.toml` and installed automatically via `Pkg.instantiate()`.

## Frequently Asked Questions

<details>
<summary><strong>Do I need to know differential algebra to use this?</strong></summary>
<br>
No. The software handles all the mathematics internally. The tutorial explains the intuition behind what the software does, but you do not need to understand differential algebra to use it effectively.
</details>

<details>
<summary><strong>My model has non-rational functions (exp, sin, etc.). Can I still use this?</strong></summary>
<br>
StructuralIdentifiability.jl requires rational right-hand sides (polynomials or ratios of polynomials). Most biological models satisfy this. For models with exponentials or trigonometric functions, consider STRIKE-GOLDD (MATLAB), which uses the observability rank condition and handles general nonlinearities.
</details>

<details>
<summary><strong>What is the difference between structural and practical identifiability?</strong></summary>
<br>
Structural identifiability asks: "Can parameters be recovered from perfect, infinite data?" It depends only on model structure. Practical identifiability asks: "Can parameters be estimated reliably from the actual data at hand?" It depends on noise, sample size, and experimental design. Structural identifiability is necessary but not sufficient for practical identifiability.
</details>

<details>
<summary><strong>My parameter is nonidentifiable. What should I do?</strong></summary>
<br>
See Section 11 of the notebook for a detailed decision flowchart. The main options are: (1) reparameterize using identifiable combinations, (2) fix the parameter from external sources, (3) add measurements, (4) use Bayesian methods with informative priors (with caveats), or (5) simplify the model.
</details>

<details>
<summary><strong>Can I analyze my own model?</strong></summary>
<br>
Yes. Simply define your model using the <code>@ODEmodel</code> macro and run the three analysis functions. See any of the examples in <code>scripts/</code> as a template.
</details>

## Citation

If you use this tutorial in your research or teaching, please cite:

```bibtex
@article{alsammani2025identifiability,
  title   = {Structural and Practical Identifiability Analysis in Mathematical
             Modeling: A Comprehensive Survey and Tutorial},
  author  = {Alsammani, Abdallah},
  year    = {2025},
  note    = {Department of Mathematical Sciences, Delaware State University}
}
```

Also cite the software:

```bibtex
@article{dong2023differential,
  title   = {Differential elimination for dynamical models via projections with
             applications to structural identifiability},
  author  = {Dong, Ruiwen and Goodbrake, Christian and Harrington, Heather A
             and Pogudin, Gleb},
  journal = {SIAM Journal on Applied Algebra and Geometry},
  volume  = {7},
  number  = {1},
  pages   = {194--235},
  year    = {2023}
}
```

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. Particularly valued:

- Additional worked examples from your research domain
- Translations of the tutorial to other languages
- Bug reports or suggestions for clearer explanations
- Comparisons with other identifiability tools

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Acknowledgments

- The developers of [StructuralIdentifiability.jl](https://github.com/SciML/StructuralIdentifiability.jl) for making rigorous identifiability analysis accessible
- The Julia community and the SciML ecosystem
- Delaware State University, Department of Mathematical Sciences

---

<p align="center">
  <em>Structural identifiability analysis should be performed routinely — ideally before data collection. The modest investment of time yields substantial returns in confidence that parameter estimates are meaningful.</em>
</p>
# Structural_Identifiability_Tutorial
