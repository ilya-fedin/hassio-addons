ARG BUILD_FROM=hassioaddons/base:4.1.1
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
    org.label-schema.description="Automatic torrents downloader" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Monitorrent" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="" \
    org.label-schema.vendor=""
