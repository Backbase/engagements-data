FROM alpine:3.15.4 AS build-env

ENV COREUTILS_VERSION 8.30

RUN apk update && apk add gcc make automake autoconf libc-dev xz

WORKDIR /tmp

RUN wget https://ftp.gnu.org/gnu/coreutils/coreutils-${COREUTILS_VERSION}.tar.xz \
	&& xz -d coreutils-${COREUTILS_VERSION}.tar.xz \
	&& tar xf coreutils-${COREUTILS_VERSION}.tar \
	&& cd coreutils-${COREUTILS_VERSION} \
	&& FORCE_UNSAFE_CONFIGURE=1 ./configure \
	&& autoreconf -f \
	&& FORCE_UNSAFE_CONFIGURE=1 make SHARED=0 CFLAGS="-static -static-libgcc -static-libstdc++ -fPIC" \
	&& cp src/cp /tmp/cp

# create nonroot user
RUN adduser --disabled-password --no-create-home --uid 65532 --shell /bin/false nonroot

RUN ["mkdir", "-p", "/home/backbase/content/"]

FROM scratch

COPY --from=build-env /etc/passwd /etc/passwd
COPY --from=build-env /etc/group /etc/group
COPY --chown=nonroot:nonroot --from=build-env /tmp/cp /usr/local/bin/cp
COPY --chown=nonroot:nonroot --from=build-env /home/backbase/content /home/backbase/content

ARG PRODUCT_LINE=retail

# bootstrap folders structure
COPY --chown=nonroot:nonroot ./target/assembly/${PRODUCT_LINE}/repositories/repositories-s3.zip /content/init/repositories-s3.zip
COPY --chown=nonroot:nonroot ./target/assembly/${PRODUCT_LINE}/repositories/repositories-azure.zip /content/init-azure/repositories-azure.zip
COPY --chown=nonroot:nonroot ./target/assembly/${PRODUCT_LINE}/repositories/repositories-db.zip /content/init-azure/repositories-db.zip
COPY --chown=nonroot:nonroot ./target/assembly/${PRODUCT_LINE}/collections/*.zip /content/upgrade/

USER nonroot
CMD ["cp","-rf","/content", "/home/backbase"]