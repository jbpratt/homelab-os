FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-coreos:stable@sha256:e8db86835b88aabe5eed03549f0eac2bc11a7aad984858534241ef7fcd524c66

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
