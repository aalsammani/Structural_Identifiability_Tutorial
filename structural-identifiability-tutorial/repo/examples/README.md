# Additional Examples

This directory is for community-contributed examples of structural identifiability analysis applied to models from various domains.

## How to Contribute an Example

1. Create a Julia script (`.jl`) or Jupyter notebook (`.ipynb`) for your model.
2. Include:
   - Model equations and parameter descriptions
   - Biological or physical context
   - Complete identifiability analysis using StructuralIdentifiability.jl
   - Interpretation of results
3. Follow the naming convention: `domain_modelname.jl` (e.g., `ecology_lotka_volterra.jl`)
4. Open a Pull Request — see [CONTRIBUTING.md](../CONTRIBUTING.md) for details.

## Suggested Models to Add

Contributions for any of the following would be welcome:

| Domain | Model | Reference |
|--------|-------|-----------|
| Ecology | Lotka-Volterra predator-prey | Lotka (1925) |
| Ecology | Rosenzweig-MacArthur | Rosenzweig & MacArthur (1963) |
| Immunology | T-cell activation | Various |
| Oncology | Tumor growth (Gompertz, logistic) | Various |
| Neuroscience | FitzHugh-Nagumo | FitzHugh (1961) |
| Epidemiology | SIRS with waning immunity | Various |
| Epidemiology | Vector-borne disease (Ross-Macdonald) | Macdonald (1957) |
| Pharmacology | Indirect response models | Dayneka et al. (1993) |
| Pharmacology | Target-mediated drug disposition | Mager & Jusko (2001) |
| Systems biology | Michaelis-Menten enzyme kinetics | Michaelis & Menten (1913) |
| Systems biology | Goodwin oscillator | Goodwin (1965) |
