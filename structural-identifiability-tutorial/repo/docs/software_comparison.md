# Software Tools for Identifiability Analysis

A comparative overview of available software for structural and practical identifiability analysis.

## Structural Identifiability Tools

| Tool | Platform | Method | Global | Local | ID Functions | Active | Reference |
|------|----------|--------|:------:|:-----:|:------------:|:------:|-----------|
| **StructuralIdentifiability.jl** | Julia | Differential algebra | ✅ | ✅ | ✅ | ✅ | Dong et al. (2023) |
| **SIAN** | Maple / Julia | Differential algebra | ✅ | ✅ | ✅ | ✅ | Hong et al. (2019) |
| **DAISY** | REDUCE | Differential algebra | ✅ | ✅ | ✅ | ⚠️ | Bellu et al. (2007) |
| **STRIKE-GOLDD** | MATLAB | Observability rank | ❌ | ✅ | Indirect | ✅ | Villaverde et al. (2016) |
| **GenSSI 2.0** | MATLAB | Generating series | ❌ | ✅ | ❌ | ⚠️ | Ligon et al. (2018) |
| **ObservabilityTest** | Mathematica | Observability rank | ❌ | ✅ | ❌ | ⚠️ | Sedoglavic (2002) |

**Legend:** ✅ = Yes / Actively maintained | ❌ = No | ⚠️ = Limited maintenance

### Recommendations

- **For most users:** StructuralIdentifiability.jl — modern, efficient, full-featured, open source.
- **For MATLAB users:** STRIKE-GOLDD — handles non-rational nonlinearities; local identifiability only.
- **For symbolic computation:** SIAN in Maple — rigorous but requires commercial software.

## Practical Identifiability Tools

| Tool | Platform | Profile Likelihood | FIM | Bayesian | Reference |
|------|----------|:------------------:|:---:|:--------:|-----------|
| **Data2Dynamics** | MATLAB | ✅ | ✅ | ❌ | Raue et al. (2015) |
| **PyPESTO** | Python | ✅ | ✅ | ✅ | ICB, Helmholtz Munich |
| **COPASI** | Standalone | ❌ | ✅ | ❌ | Hoops et al. (2006) |
| **Stan** | R / Python / Julia | ❌ | ❌ | ✅ | Carpenter et al. (2017) |
| **Turing.jl** | Julia | ❌ | ❌ | ✅ | Ge et al. (2018) |

### Recommended Workflow

1. **Structural analysis first** — use StructuralIdentifiability.jl
2. **If all parameters are structurally identifiable** — proceed to practical analysis
3. **For practical analysis** — use profile likelihood (Data2Dynamics or PyPESTO) or Bayesian methods (Stan or Turing.jl)

## Installation Links

- StructuralIdentifiability.jl: https://github.com/SciML/StructuralIdentifiability.jl
- STRIKE-GOLDD: https://github.com/afvillaverde/strike-goldd
- SIAN: https://github.com/alexeyovchinnikov/SIAN-Julia
- GenSSI: https://github.com/genssi-developer/GenSSI
- PyPESTO: https://github.com/ICB-DCM/pyPESTO
- Data2Dynamics: https://github.com/Data2Dynamics/d2d
