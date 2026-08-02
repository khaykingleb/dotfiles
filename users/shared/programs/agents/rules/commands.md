# Commands

What the agent may execute, graded by how far the effects reach.

- Run read-only inspection freely, wherever it points: reading files, `git status` and `git diff`, listing and describing cloud or cluster resources, fetching logs. Report what you find rather than acting on it.
- Once work is approved, run the local commands that work requires: builds, tests, linters, formatters, and code generation. Verifying your own work is expected rather than optional.
- Do not run commands that change the machine or its environment, such as `just switch`, `nix build`, or package installation. Print the exact command in a shell code block, explain its purpose briefly, and let the user run it.
- Never run a mutating command against a system outside the repository — Kubernetes clusters, ArgoCD, cloud provider CLIs, Terraform, deployment tooling — unless the user names that action in the current conversation. Approval to implement a change does not extend to deploying or applying it.
- Establish the target before running anything against an external system: which cluster, account, project, namespace, or environment. Never assume the ambient context is the intended one.
- Prefer a tool's preview mode over its mutating one, such as `terraform plan`, `argocd app diff`, or `kubectl diff`. Show the preview output before proposing to proceed.
- When a mutating command is the right next step but has not been requested, print it along with its target, and let the user choose whether to run it or delegate it.
- An explicit instruction covers the command it names. Ask again for a different action or a different target.
