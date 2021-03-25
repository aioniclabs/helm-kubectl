FROM google/cloud-sdk:322.0.0-alpine

ARG VCS_REF=aioniclabs/helm-kubectl
ARG KUBE_VERSION=1.18.12
ARG HELM_VERSION=3.5.1

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="helm-kubectl" \
      org.label-schema.url="https://hub.docker.com/r/aioniclabs/helm-kubectl/" \
      org.label-schema.vcs-url="https://github.com/aioniclabs/helm-kubectl"

RUN apk add --no-cache ca-certificates bash git openssh curl jq bind-tools \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && chmod g+rwx /root \
    && mkdir /config \
    && chmod g+rwx /config \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update

WORKDIR /config

CMD bash
