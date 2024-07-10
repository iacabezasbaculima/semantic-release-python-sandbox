################################################################################
## Variables
################################################################################

# https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables
CI := x'${CI:-false}'

################################################################################
## Main Recipes
################################################################################

# Show this help message
@default:
  just --list

# Install project dependencies
setup: _install-poetry _install-pre-commit
  poetry install --no-root

# Pre-commit
pre-commit:
  pre-commit run --all-files

################################################################################
## Helper Recipes
################################################################################

_install-poetry:
  pipx install poetry

_install-pre-commit:
  eval {{ if CI == "true" { "echo \"skip pre-commit install\"" } else { "pre-commit install" } }}
