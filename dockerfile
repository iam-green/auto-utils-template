FROM ubuntu:latest

LABEL org.opencontainers.image.source="https://github.com/iam-green/auto-utils-template"

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Seoul \
  UID=1000 \
  GID=1000 \
  DATA_DIRECTORY=/app/data \
  LIBRARY_DIRECTORY=/app/lib

WORKDIR /app

# Install required packages, create group/user, and configure sudoers
RUN apt-get update && \
  apt-get install -y --no-install-recommends curl xz-utils sudo && \
  rm -rf /var/lib/apt/lists/* && \
  groupadd -g ${GID} app && \
  useradd -m -u ${UID} -g app app && \
  echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY start .

RUN chmod +x start && \
  chown -R app:app /app

VOLUME ["/app/data", "/app/lib"]

USER app

CMD ./start -dd ${DATA_DIRECTORY} -ld ${LIBRARY_DIRECTORY}
