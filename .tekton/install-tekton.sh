#!/bin/bash

# Install Tekton Pipeline
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.14.2/release.yaml


# Install Tekton CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.11.0/tkn_0.11.0_Linux_x86_64.tar.gz

tar xvzf tkn_0.11.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn
