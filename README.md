# Structural Identifiability of Dynamical Models

Companion code for the paper:

> **Structural Identifiability of Dynamical Models: A Geometric Framework with Computational Illustrations**
> Abdallah Alsammani, Department of Mathematical Sciences, Delaware State University

This repository contains a Julia notebook for structural identifiability analysis and a Python notebook for practical identifiability diagnostics, together with the LaTeX source of the paper.


## What is structural identifiability?

Every ODE model with unknown parameters carries an implicit question: can those parameters be recovered from the observable output? Structural identifiability answers this *before any data are collected*, by analyzing the geometry of the parameter-to-output map

$$\Phi : \Theta \to \mathcal{Y}, \quad \boldsymbol{\theta} \mapsto (c_1(\boldsymbol{\theta}), \ldots, c_r(\boldsymbol{\theta}))$$

Three outcomes are possible:

| Classification | Meaning | Fiber of $\Phi$ |
|---|---|---|
| **SGI** (globally identifiable) | Unique recovery possible | Single point |
| **SLI** (locally identifiable) | Finite discrete ambiguity | Finite point set |
| **SNI** (nonidentifiable) | Individual recovery impossible | Continuous manifold |


## Repository Contents

```
├── Structural_Identifiability_Tutorial_Julia.ipynb   Julia notebook (structural analysis)
├── Practical_Identifiability_Tutorial_Python.ipynb    Python notebook (statistical diagnostics)
├── Structural_Identifiability_Article.tex             LaTeX source of the paper
└── README.md
```

### Julia Notebook: Structural Analysis

The primary notebook. It performs algebraic identifiability analysis on six ODE models using `StructuralIdentifiability.jl` and visualizes the fiber geometry of each. All 14 figures are rendered inline.

**Contents:**

| Section | Topic | What it demonstrates |
|---|---|---|
| 1 | Setup | Package installation and imports |
| 2 | The map $\Phi$ | Definitions, fiber classification table, kernel containment |
| 3 | First-order kinetics | Direct ($y = x$) vs. scaled ($y = ax$) observation; the hyperbola $ax_0 = c$ |
| 4 | SIR epidemic model | How adding $R(t)$ to the output collapses the $\beta S_0$ fiber |
| 5 | Two-compartment PK | Biexponential output gives 4 observables for 4 unknowns (SGI) |
| 6 | Viral dynamics | All three classes in one model: SGI, SLI, and SNI simultaneously |
| 7 | SEIR with hospitalization | Staged algebraic resolution via output ratios |
| 8 | Environmental transmission | Wastewater surveillance resolves structural confounding |
| 9 | FIM and kernel containment | Numerical verification that $\ker D\Phi \subseteq \ker \mathcal{F}$ |
| 10 | Likelihood geometry | Four regimes: ellipsoidal bowl, multiple wells, flat ridge, elongated valley |
| 11 | Summary | Lessons, workflow, resolution strategies |
| 12 | References | 12 key references |

### Python Notebook: Practical Diagnostics

Implements five numerical diagnostics on four of the models above:

- Fisher information matrix eigenvalue analysis
- Profile likelihood computation
- Collinearity indices
- Convergence rate analysis
- Bayesian posterior sampling (Metropolis-Hastings)

Generates 18 figures covering all diagnostic methods.


## Requirements

### Julia Notebook

Julia 1.6 or later. The notebook installs its own dependencies on first run:

```julia
using Pkg
Pkg.add(["StructuralIdentifiability", "Plots", "LaTeXStrings", "StatsPlots"])
```

**Core dependency:** [StructuralIdentifiability.jl](https://github.com/SciML/StructuralIdentifiability.jl) (Dong et al., 2023).

**Key functions used:**

| Function | Purpose |
|---|---|
| `assess_local_identifiability(model)` | Rank test for local identifiability |
| `assess_identifiability(model)` | Full classification: SGI, SLI, or SNI |
| `find_identifiable_functions(model)` | Maximal set of recoverable parameter combinations |

### Python Notebook

Python 3.8 or later with NumPy, SciPy, and Matplotlib:

```bash
pip install numpy scipy matplotlib
```


## Quick Start

### Run the Julia notebook

```bash
julia -e 'using Pkg; Pkg.add("IJulia")'
jupyter notebook Structural_Identifiability_Tutorial_Julia.ipynb
```

### Minimal example (standalone script)

```julia
using StructuralIdentifiability

# Define an ODE model with scaled observation
model = @ODEmodel(
    x'(t) = -k * x(t),
    y(t) = a * x(t)
)

# Classify each parameter
assess_identifiability(model)
# => Dict(k => :globally, a => :nonidentifiable, x(0) => :nonidentifiable)

# Find what IS recoverable
find_identifiable_functions(model)
# => [k, a*x(0)]
```

This tells you that only the rate constant $k$ and the product $a \cdot x_0$ can be recovered from data, regardless of sample size or measurement precision.


## Examples at a Glance

### Example 1: First-Order Kinetics

| Scenario | Unknowns | Coefficient map | Result |
|---|---|---|---|
| $y = x$ | $(k, x_0)$ | $\Phi = (k,\; x_0)$ | Both SGI |
| $y = ax$ | $(k, a, x_0)$ | $\Phi = (k,\; ax_0)$ | $k$ SGI; $a$, $x_0$ SNI; $ax_0$ identifiable |

The nonidentifiability manifold is the hyperbola $ax_0 = c$ in the $(a, x_0)$ plane. The kernel of $D\Phi$ is spanned by $(0, -a, x_0)$, tangent to this hyperbola.

### Example 2: SIR Epidemic Model

| Observation | $\beta$ | $\gamma$ | $S(0)$ |
|---|---|---|---|
| $y = I$ only | SNI | SGI | SNI |
| $y = (I, R)$ | SGI | SGI | SGI |

Adding recovery data provides $S(t) = N - I(t) - R(t)$, collapsing the $\beta S_0$ fiber to a single point.

### Example 4: Viral Dynamics (all three classes)

| Component | Classification | Fiber |
|---|---|---|
| $V(0)$ | SGI | Single point |
| $c$, $\delta$ | SLI | Two-point set (swap symmetry) |
| $\beta$, $p$ | SNI | Continuous hyperbola $\beta p = q$ |
| $\beta p$ | Identifiable function | Sharp profile likelihood |


## Recommended Workflow

1. **Specify** the ODE system, outputs, and all unknowns (including initial conditions).
2. **Screen** with `assess_local_identifiability` (fast, handles up to ~30 parameters).
3. **Classify** with `assess_identifiability` (global: SGI, SLI, or SNI).
4. **Compute** identifiable functions with `find_identifiable_functions` for any SNI parameters.
5. **Resolve** by reparameterizing, augmenting observations, fixing parameters, or simplifying the model.
6. **Verify** with numerical diagnostics (FIM eigenvalues, profile likelihood) using the Python notebook.
7. **Report** a parameter-by-parameter classification and justify all resolution strategies.


## Key Result: Kernel Containment

The central theoretical result connecting structural and practical identifiability:

$$\ker D\Phi(\boldsymbol{\theta}) \subseteq \ker \mathcal{F}(\boldsymbol{\theta})$$

If a parameter direction is structurally nonidentifiable (lies in $\ker D\Phi$), then the Fisher information matrix $\mathcal{F}$ has a zero eigenvalue in that direction, regardless of experimental design. The Julia notebook verifies this numerically for the scaled decay model: the zero eigenvector of $\mathcal{F}$ aligns with $(0, -a, x_0)$ to machine precision.


## Citation

If you use this code in your work, please cite:

```bibtex
@article{alsammani2025structural,
  title   = {Structural Identifiability of Dynamical Models:
             A Geometric Framework with Computational Illustrations},
  author  = {Alsammani, Abdallah},
  year    = {2025},
  note    = {Department of Mathematical Sciences, Delaware State University}
}
```


## License

This repository is provided for academic and educational use. See the individual files for details.


## References

1. Bellman, R. and Aström, K. J. (1970). On structural identifiability. *Mathematical Biosciences*, 7(3-4), 329-339.
2. Ljung, L. and Glad, T. (1994). On global identifiability for arbitrary model parametrizations. *Automatica*, 30(2), 265-276.
3. Dong, R., Goodbrake, C., Harrington, H. A., and Pogudin, G. (2023). Differential elimination for dynamical models via projections with applications to structural identifiability. *SIAM Journal on Applied Algebra and Geometry*, 7(1), 194-235.
4. Miao, H., Xia, X., Perelson, A. S., and Wu, H. (2011). On identifiability of nonlinear ODE models and applications in viral dynamics. *SIAM Review*, 53(1), 3-39.
5. Raue, A. et al. (2009). Structural and practical identifiability analysis of partially observed dynamical models by exploiting the profile likelihood. *Bioinformatics*, 25(15), 1923-1929.
