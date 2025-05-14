FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-coreos:stable@sha256:42b639953c23a464fe113d642696cf12a7ae56ab86bca45ed96163bd593a48ed

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
