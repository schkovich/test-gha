FROM schkovich/4-open-pilot:main-base AS base-image
LABEL authors="goran"

WORKDIR /root
COPY hello.c .
RUN gcc -o helloworld hello.c

# This is the second and final image; it copies the compiled binary
# over but starts from the base schkovich/4-open-pilot:main-base image.
FROM schkovich/4-open-pilot:main-base AS runtime-image

COPY --from=compile-image /root/helloworld .
CMD ["./helloworld"]
