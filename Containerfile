FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-coreos:stable@sha256:962d96a8739036263308c024c45ec0b78e18396e02bb91f440f9c9f058636120

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
