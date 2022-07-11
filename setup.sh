#!bin/bash

print_separator() {
    echo -e "########################################################################################"
}

print_separator
echo -e "Installing operators\n"
oc apply -k operator

print_separator
echo -e "Generating sealed secret for quay credentials\n"
kubeseal -o yaml < workspace/quay-credentials-generic-secret.yaml  > workspace/quay-credentials-sealed-secret.yaml

print_separator
echo -e "Installing workshop resources\n"
oc apply -k workspace
oc apply -k pipeline
oc apply -k trigger