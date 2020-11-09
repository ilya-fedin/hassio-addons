ARG BUILD_FROM=hassioaddons/base:8.0.5
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN \
    apk add --no-cache \
        python3 \
        lua-resty-http \
        nginx-mod-http-lua \
        nginx

RUN mkdir /opt/monitorrent
RUN wget -O /root/monitorrent.zip https://github.com/werwolfby/monitorrent/releases/download/1.1.10/monitorrent-1.1.10.zip
RUN unzip /root/monitorrent.zip -d /opt/monitorrent
RUN sed -i 's/falcon>=1\.0\.0/falcon>=1.0.0,<2.0.0/' /opt/monitorrent/requirements.txt
RUN sed -i "s/'\/login/'login/g" /opt/monitorrent/monitorrent/rest/static_file.py
RUN sed -i 's/"\/api/"api/g' /opt/monitorrent/webapp/scripts/monitorrent.js
RUN sed -i "s/'\/api/'api/g" /opt/monitorrent/webapp/login.html
RUN sed -i "s/'\/'/'.'/g" /opt/monitorrent/webapp/login.html
RUN pip3 install -r /opt/monitorrent/requirements.txt
RUN rm /root/monitorrent.zip

RUN rm -rf /etc/nginx

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Monitorrent" \
    io.hass.description="Automatic torrents downloader" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="" \
    org.opencontainers.image.title="Monitorrent" \
    org.opencontainers.image.description="Automatic torrents downloader" \
    org.opencontainers.image.vendor="ilya-fedin's Hass.io addons" \
    org.opencontainers.image.authors="Ilya Fedin <fedin-ilja2010@ya.ru>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/ilya-fedin/hassio-addons" \
    org.opencontainers.image.source="https://github.com/ilya-fedin/hassio-addons" \
    org.opencontainers.image.documentation="https://github.com/ilya-fedin/hassio-addons" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
