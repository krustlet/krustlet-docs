---
title: "Running Web Assembly (WASM) workloads in Kubernetes"
description: ""
type: docs
---

The Krustlet repository contains the built-in `krustlet-wasi` provider for
running WASM workloads in Kubernetes. There is also a `krustlet-wasmcloud`
[provider](https://github.com/wasmCloud/krustlet-wasmcloud-provider) available
that also runs WASM workloads. These kubelets run workloads implemented as Web
Assembly (WASM) modules rather than as OCI containers. Each running instance
appears to Kubernetes as a node; Kubernetes schedules work to the instance as to
any other node.

## Running WASM modules on the right kubelet

WASM modules are not interchangeable with OCI containers: `krustlet-wasi` and
`krustlet-wasmcloud` can't run OCI containers, and normal OCI nodes can't run WASM
modules. In order to run your WASM workloads on the right nodes, you should use
the Kubernetes tolerations system; in some cases you will also need to use node
affinity.

The `krustlet-wasi` and `krustlet-wasmcloud` 'virtual nodes' both have `NoExecute`
and `NoSchedule` taints with the key `kubernetes.io/arch` and a provider-defined
value (`wasm32-wasi` or `wasm32-wasmcloud` respectively).
WASM pods must therefore specify a toleration for this taint.  For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-wasm
spec:
  containers:
  - name: hello-wasm
    image: webassembly.azurecr.io/hello-wasm:v1
  tolerations:
  - effect: NoExecute
    key: kubernetes.io/arch
    operator: Equal
    value: wasm32-wasi   # or wasm32-wasmcloud according to module target arch
  - effect: NoSchedule
    key: kubernetes.io/arch
    operator: Equal
    value: wasm32-wasi   # or wasm32-wasmcloud according to module target arch
```

In addition, if the Kubernetes cluster contains 'standard' OCI nodes which do
not taint themselves, you should prevent Kubernetes from scheduling WASM
workloads to those nodes.  To do this, you can either taint the OCI nodes
(though this may require you to provide suitable tolerations on OCI pods), or
you can specify a node selector on the WASM workload to direct it to compatible
nodes:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-wasm
spec:
  # other values as above
  nodeSelector:
    kubernetes.io/arch: wasm32-wasi  # or wasm32-wasmcloud
```

If you get intermittent image pull errors on your WASM workloads, check that
they are not inadvertently getting scheduled to OCI nodes.
