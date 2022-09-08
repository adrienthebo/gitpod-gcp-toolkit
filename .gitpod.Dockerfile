# syntax=docker/dockerfile:1.4

FROM gitpod/workspace-full

ARG CLOUDSDK_VERSION="395.0.0"

RUN sudo apt-get update -q \
    && sudo apt-get install -y gcc python3-dev python3-setuptools \
    && sudo pip3 install -y crcmod \
    && sudo pip3 install --no-cache-dir -U crcmod

RUN \
    TMPDIR="$(mktemp -d)" \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${CLOUDSDK_VERSION}-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-${CLOUDSDK_VERSION}-linux-x86.tar.gz \
    && sudo ./google-cloud-sdk/install.sh \
    && cd - \
    && rm -rf $TMPDIR

RUN \
    gcloud components install kubectl \
    && gcloud components install gke-gcloud-auth-plugin