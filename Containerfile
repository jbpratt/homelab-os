FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-coreos:43.20250421.91.0@sha256:c1f51959fe50ab966a1325b9024a50ba519aebe4c3677fcbae3fdd2e74b5874a

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
