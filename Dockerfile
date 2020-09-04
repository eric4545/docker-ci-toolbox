FROM alpine:3.10.1

LABEL maintainer eric4545@users.noreply.github.com

ENV KUSTOMIZE_VERSION 3.5.3
ENV CHAMBER_VERSION v2.3.3
ENV YQ_VERSION 3.3.2
ENV AWS_CLI_VERSION=1.16.273

RUN apk --no-cache add \
        git \
        curl \
        openssh-client \
        bash \
        python3 \
        py-pip \
    && \
    curl -sLo /tmp/kustomize.tar.gz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZE_VERSION/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
        tar -zxvf /tmp/kustomize.tar.gz -C /tmp && \
        chmod +x /tmp/kustomize && \
        mv /tmp/kustomize /usr/local/bin/kustomize && \
    curl -sLo ./chamber "https://github.com/segmentio/chamber/releases/download/${CHAMBER_VERSION}/chamber-${CHAMBER_VERSION}-linux-amd64" && \
        chmod +x ./chamber && \
        mv chamber /usr/local/bin/chamber && \
    curl -sLo ./yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" && \
        chmod +x ./yq && \
        mv yq /usr/local/bin/yq && \
    pip install --upgrade awscli==$AWS_CLI_VERSION && \
    apk --purge del py-pip