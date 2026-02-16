# Contributing Guidelines

Thank you for your interest in contributing to this tutorial! Contributions of all kinds are welcome: new examples, improved explanations, bug fixes, translations, and more.

## How to Contribute

### Reporting Issues

If you find an error, unclear explanation, or have a suggestion:

1. Open an [Issue](../../issues) on GitHub.
2. Describe the problem or suggestion clearly.
3. If reporting a bug, include the Julia version, package version, and the error message.

### Adding a New Example

New worked examples are especially valued. To add one:

1. **Fork** this repository and create a new branch.
2. Add a standalone Julia script in `scripts/` following the naming convention: `example_MODELNAME.jl`.
3. Add a corresponding section to the notebook or create a separate notebook in `examples/`.
4. Each example should include:
   - A brief model description (equations, parameter meanings, biological context)
   - The observation specification (what is measured)
   - Julia code using `@ODEmodel`, `assess_identifiability`, and `find_identifiable_functions`
   - Interpretation of results in plain language
5. Open a **Pull Request** with a clear description of the model and why it is instructive.

### Improving Explanations

If you think a section could be clearer:

1. Fork, edit, and open a Pull Request.
2. Explain what was unclear and how your revision improves it.
3. Keep the target audience in mind: graduate students and researchers who may have no prior exposure to identifiability theory.

### Style Guidelines

- **Code:** Follow standard Julia style conventions. Use descriptive variable names.
- **Markdown:** Use clear section headers. Prefer prose explanations over terse bullet points.
- **Mathematics:** Use LaTeX notation in markdown cells. Define all symbols before using them.
- **Tone:** Accessible and encouraging. Avoid jargon without explanation.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). By participating, you agree to uphold a respectful and inclusive environment.

## Questions?

Open an issue or contact the maintainer at aalsammani@desu.edu.
