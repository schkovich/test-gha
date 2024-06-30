FROM ubuntu:latest AS compile-image
LABEL authors="goran"
# This is the first image:
RUN apt-get update
RUN apt-get install -y --no-install-recommends gcc build-essential

WORKDIR /root
COPY hello.c .
RUN gcc -o helloworld hello.c

# This is the second and final image; it copies the compiled binary
# over but starts from the base ubuntu:latest image.
FROM ubuntu:latest AS runtime-image

COPY --from=compile-image /root/helloworld .
CMD ["./helloworld"]
