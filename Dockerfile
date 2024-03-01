FROM ubuntu:jammy as build
WORKDIR /build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -q && apt install -q -y git build-essential autoconf libtool bison
RUN git clone https://github.com/bgp/bgpq4
RUN cd /build/bgpq4 && /build/bgpq4/bootstrap && /build/bgpq4/configure && make

FROM ubuntu:jammy
COPY --from=build /build/bgpq4/bgpq4 /bin/bgpq4
CMD [ "/bin/bgpq4" ]