FROM scratch AS ctx
COPY build_files /

FROM quay.io/fedora/fedora-coreos:stable@sha256:4f4024a807ef0c43671a8d83ab967a2713d463a879cba79b0b4d178037948de3

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit

RUN bootc container lint
