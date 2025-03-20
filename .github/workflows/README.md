# xk6 workflows

## Repository workflows

The following workflows are used to maintain the **xk6 repository** itself. These workflows are not designed to be reusable, and are subject to change at any time without notice.

### [Validate](validate.yml)

This workflow calls the [Tooling Validate](#tooling-validate) reusable workflow with appropriate parameters. The parameters can be configured in GitHub repository variables and GitHub repository secrets.

**triggers**

```yaml file=validate.yml region=triggers
  workflow_dispatch:
  push:
    branches: ["main", "master"]
  pull_request:
    branches: ["main", "master"]
```

**secrets**

```yaml file=validate.yml region=secrets
      codecov-token: ${{secrets.CODECOV_TOKEN}}
```

**inputs**

```yaml file=validate.yml region=inputs
      go-version: ${{vars.GO_VERSION}}
      go-versions: ${{vars.GO_VERSIONS}}
      golangci-lint-version: ${{vars.GOLANGCI_LINT_VERSION}}
      goreleaser-version: ${{vars.GORELEASER_VERSION}}
      platforms: ${{vars.PLATFORMS}}
      k6-versions: ${{vars.K6_VERSIONS}}
      bats: .github/validate.bats
```

### [Release](release.yml)

This workflow calls the [Tooling Release](#tooling-release) reusable workflow with appropriate parameters. The parameters can be configured in GitHub repository variables and GitHub repository secrets.

**triggers**

```yaml file=release.yml region=triggers
  push:
    tags: ["v*.*.*"]
```

**secrets**

```yaml file=release.yml region=secrets
      docker-user: ${{secrets.DOCKERHUB_USERNAME}}
      docker-token: ${{secrets.DOCKERHUB_TOKEN}}
```

**inputs**

```yaml file=release.yml region=inputs
      go-version: ${{vars.GO_VERSION}}
      goreleaser-version: ${{vars.GORELEASER_VERSION}}
      k6-versions: ${{vars.K6_VERSIONS}}
      bats: ./.github/release.bats
```

## Tooling workflows

The following workflows are used to maintain tools related to the development of k6 extensions. These workflows are designed to be **reusable**.

Input parameters will change in a backwards compatible way if possible, but it is strongly recommended to use workflows with a specific version tag.

### [Tooling Validate](tooling-validate.yml)

**secrets**

```yaml file=tooling-validate.yml region=secrets
      codecov-token:
        description: Token for Codecov reports
        required: false
```

**inputs**

```yaml file=tooling-validate.yml region=inputs
      go-version:
        description: go version for building
        required: true
        type: string
      go-versions:
        description: go versions for testing
        required: true
        type: string
      platforms:
        description: platforms for testing
        required: true
        type: string
      golangci-lint-version:
        description: golangci-lint tool version
        required: true
        type: string
      goreleaser-version:
        description: goreleaser tool version
        required: true
        type: string
      k6-versions:
        description: k6 versions for testing
        required: false
        default: '["latest"]'
        type: string
      bats:
        description: bats scripts after build
        type: string
        required: false
```

### [Tooling Release](tooling-release.yml)

**secrets**

```yaml file=tooling-release.yml region=secrets
      docker-user:
        description: Docker Hub user name
        required: false
      docker-token:
        description: Docker Hub user token
        required: false
```

**inputs**

```yaml file=tooling-release.yml region=inputs
      go-version:
        description: go version for building
        required: true
        type: string
      goreleaser-version:
        description: goreleaser tool version
        required: true
        type: string
      k6-versions:
        description: k6 versions for testing
        required: false
        default: '["latest"]'
        type: string
      bats:
        description: bats scripts before release
        type: string
        required: false
```
