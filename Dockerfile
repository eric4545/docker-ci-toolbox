FROM alpine:3.10.1

LABEL maintainer eric4545@users.noreply.github.com

ENV KUSTOMIZE_VERSION 3.5.3
ENV CHAMBER_VERSION v2.3.3
ENV YQ_VERSION 2.4.0

RUN apk --no-cache add \
        git \
        curl \
        openssh-client \
        bash \
    && \
    curl -sLo ./kustomize "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZE_VERSION/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
        chmod +x ./kustomize && \
        mv kustomize /usr/local/bin/kustomize && \
    curl -sLo ./chamber "https://github.com/segmentio/chamber/releases/download/v2.3.3/chamber-${CHAMBER_VERSION}-linux-amd64" && \
        chmod +x ./chamber && \
        mv chamber /usr/local/bin/chamber && \
    curl -sLo ./yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" && \
        chmod +x ./yq && \
        mv yq /usr/local/bin/yq
