FROM alpine:3.13.2

LABEL maintainer eric4545@users.noreply.github.com

ENV KUBEVAL_VERSION 0.15.0
ENV KUBESEAL_VERSION 0.15.0
ENV KUSTOMIZE_VERSION 3.9.4
ENV CHAMBER_VERSION v2.3.3
ENV YQ_VERSION 4.6.1
ENV AWS_CLI_VERSION=1.19.17

RUN apk --no-cache add \
        git \
        curl \
        openssh-client \
        bash \
        python3 \
    && \
    cd /tmp && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
        chmod +x ./kubectl && \
        mv ./kubectl /usr/local/bin/kubectl && \
    curl -sLo ./kustomize.tar.gz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$KUSTOMIZE_VERSION/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
        tar -zxvf ./kustomize.tar.gz -C . && \
        chmod +x ./kustomize && \
        mv ./kustomize /usr/local/bin/kustomize && \
    curl -sLo ./kubeval.tar.gz "https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" && \
        tar -zxvf ./kubeval.tar.gz -C . && \
        chmod +x ./kubeval && \
        mv kubeval /usr/local/bin/kubeval && \
    curl -sLo ./kubeseal "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-linux-amd64"  && \
        chmod +x ./kubeseal && \
        mv kubeseal /usr/local/bin/kubeseal && \
    curl -sLo ./chamber "https://github.com/segmentio/chamber/releases/download/${CHAMBER_VERSION}/chamber-${CHAMBER_VERSION}-linux-amd64" && \
        chmod +x ./chamber && \
        mv chamber /usr/local/bin/chamber && \
    curl -sLo ./yq "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" && \
        chmod +x ./yq && \
        mv yq /usr/local/bin/yq && \
    python3 -m ensurepip --upgrade && \
    pip3 install \
        --no-cache \
        --upgrade \
        --ignore-installed six \
        awscli==$AWS_CLI_VERSION && \
    rm -rf /tmp/*