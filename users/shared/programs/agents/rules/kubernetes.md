# Kubernetes

- Always use `kubie` for Kubernetes context management before running `kubectl`.
- Verify the cluster and namespace before every command. Do not assume the current context is correct.
- Read-only inspection is `kubectl get`, `kubectl describe`, `kubectl logs`, and `kubectl events`. Reach for these first when diagnosing.
- Mutating commands are `kubectl apply`, `kubectl delete`, `kubectl patch`, `kubectl rollout restart`, and anything else that changes context-sensitive state.
