FROM rust:slim-bookworm AS builder

RUN apt-get update -y && \
  apt-get install -y make g++ libssl-dev 

WORKDIR /app
COPY . .

RUN cargo build 
# I had issues compiling for release

FROM gcr.io/distroless/cc-debian12
COPY --from=builder /app/target/debug/zola /bin/zola

ENTRYPOINT [ "/bin/zola" ]
