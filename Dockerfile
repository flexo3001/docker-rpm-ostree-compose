FROM golang:buster as gobuild
RUN apt update && apt install --no-install-recommends ca-certificates git \
    && git clone https://git.borg.sh/flexo3001/serve.go.git \
    && cd serve.go \
    && go build serve.go

FROM registry.fedoraproject.org/fedora-minimal:33
RUN microdnf install -y sudo git rpm-ostree selinux-policy selinux-policy-targeted policycoreutils \
    && microdnf clean all \
    && git clone --branch f33 https://pagure.io/forks/flexo3001/workstation-ostree-config.git \
    && chmod +x /workstation-ostree-config/compose.sh

ARG PUID=2000
ARG PGID=2000

EXPOSE 8000/tcp

COPY --from=gobuild /go/serve.go/serve /usr/local/bin/serve

RUN groupadd -g ${PGID} ostree-serve && adduser -g ${PGID} -u ${PUID} -M ostree-serve

COPY entrypoint.sh /entrypoint.sh

WORKDIR /workstation-ostree-config
ENTRYPOINT ["/entrypoint.sh", "/usr/local/bin/serve", "/var/tmp/repo"]
