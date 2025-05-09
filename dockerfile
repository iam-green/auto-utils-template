FROM ubuntu:latest

LABEL org.opencontainers.image.source="https://github.com/iam-green/auto-utils-template"

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Seoul \
  UID=1000 \
  GID=1000 \
  DATA_DIRECTORY=/app/data \
  LIBRARY_DIRECTORY=/app/lib

WORKDIR /app

# Install required packages
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    curl xz-utils sudo ca-certificates && \
  rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
  
COPY start.sh .
RUN chmod +x start.sh

VOLUME ["/app/data", "/app/lib"]

ENTRYPOINT ["./entrypoint.sh"]
