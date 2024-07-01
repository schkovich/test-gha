FROM ghcr.io/commaai/openpilot-base:latest AS base-image
LABEL authors="goran"
# This is the first image:
RUN apt-get update
RUN apt-get install -y --no-install-recommends gcc build-essential

FROM base-image AS compile-image
WORKDIR /root
COPY hello.c .
RUN gcc -o helloworld hello.c

# This is the second and final image; it copies the compiled binary
# over but starts from the base ghcr.io/commaai/openpilot-base:latest image.
FROM ghcr.io/commaai/openpilot-base:latest AS runtime-image

COPY --from=compile-image /root/helloworld .
CMD ["./helloworld"]
