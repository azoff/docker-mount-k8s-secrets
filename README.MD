# mount-k8s-secrets

A simple docker image you can use to pull down Kubernetes secrets,
and mount them into the container. Super useful for tying together
your remote k8s and local development workflows.

## Usage

```
docker run \
	-v ~/.kube/config:/root/.kube/config \
	azoff/mount-k8s-secrets \
	<secret_name> [path1] [path2] ... [path3]
```

## Examples

### All keys under a secret

```
> docker run --rm -v ~/.kube/config:/root/.kube/config azoff/mount-k8s-secrets my_secret

fetching default/secret/my_secret...
fetching all keys...
checking secret mount path...
mounting /run/secrets/my_secret/key_1...
mounting /run/secrets/my_secret/key_2...
done: 2 secret(s) mounted!
```

### A single key under a secret

```
> docker run --rm -v ~/.kube/config:/root/.kube/config azoff/mount-k8s-secrets my_secret key_1

fetching default/secret/my_secret...
using keys: key_1...
checking secret mount path...
mounting /run/secrets/my_secret/key_1...
done: 1 secret(s) mounted!
```

### Selecting the non-default namespace

```
> docker run --rm -e KUBE_NAMESPACE=foo -v ~/.kube/config:/root/.kube/config azoff/mount-k8s-secrets my_secret

fetching foo/secret/my_secret...
fetching all keys...
checking secret mount path...
mounting /run/secrets/my_secret/key_1...
mounting /run/secrets/my_secret/key_2...
done: 2 secret(s) mounted!
```

### Aliasing the secret name or sub-keys

```
> docker run --rm -v ~/.kube/config:/root/.kube/config azoff/mount-k8s-secrets my_secret=secret_alias key_1=key_alias

fetching foo/secret/my_secret...
fetching all keys...
checking secret mount path...
mounting /run/secrets/secret_alias/key_alias...
done: 1 secret(s) mounted!
```