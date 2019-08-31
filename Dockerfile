FROM alpine:3

ARG K8S_VERSION=1.15.3
ARG K8S_DISTRO=linux/amd64

ARG K8S_DEFAULT_NAMESPACE=default
ENV K8S_DEFAULT_NAMESPACE=$K8S_DEFAULT_NAMESPACE

ARG KUBECONFIG=/root/.kube/config
ENV KUBECONFIG=$KUBECONFIG

ARG SECRETS_MNT=/run/secrets
ENV SECRETS_MNT=$SECRETS_MNT

RUN apk --no-cache add jq gettext ca-certificates openssl \
    && wget "https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/${K8S_DISTRO}/kubectl" \
    	-O /usr/local/bin/kubectl \
    && chmod a+x /usr/local/bin/kubectl \
    && apk --no-cache del ca-certificates openssl

ADD ./mount-k8s-secrets /bin/mount-k8s-secrets
ENTRYPOINT ["/bin/mount-k8s-secrets"]