ARG BUILD_FROM=hassioaddons/ubuntu-base:3.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
RUN apt-get update && apt-get install --no-install-recommends -y \
    golang-go gcc make git xz-utils nginx-light libnginx-mod-http-lua \
    python3 python3-dev python3-setuptools python3-wheel python3-pip \
    python3-libtorrent python3-gi python3-gi-cairo \
    libtiff5-dev libjpeg8-dev libopenjp2-7-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk \
    libharfbuzz-dev libfribidi-dev libffi-dev libssl-dev \
    libtiff5 libjpeg8 libopenjp2-7 zlib1g \
    libfreetype6 liblcms2-2 libwebp6 \
    libharfbuzz0b libfribidi0 libffi6 libssl1.1

RUN pip3 --no-cache-dir install -U pip setuptools wheel

RUN pip3 --no-cache-dir install --no-binary :all: \
    twisted[tls]>=17.1 \
    rencode \
    pyopenssl \
    pyxdg \
    pillow \
    mako \
    chardet \
    six \
    setproctitle \
    zope.interface>=4.4.2 \
    distro

RUN curl -L -s http://download.deluge-torrent.org/source/2.0/deluge-2.0.3.tar.xz | tar -Jxvf - -C /root
RUN cd /root/deluge-2.0.3 && python3 setup.py build
RUN cd /root/deluge-2.0.3 && python3 setup.py install --optimize=1 --skip-build
RUN rm -rf /root/deluge-2.0.3

RUN go get github.com/pyed/deluge-telegram
RUN mv /root/go/bin/deluge-telegram /usr/local/bin
RUN rm -rf /root/go

RUN curl -L -s https://github.com/ncopa/su-exec/archive/v0.2.tar.gz | tar zxvf - -C /root
RUN cd /root/su-exec-0.2 && make
RUN mv /root/su-exec-0.2/su-exec /usr/local/bin
RUN rm -rf /root/su-exec-0.2

RUN curl -L -s https://github.com/ledgetech/lua-resty-http/archive/v0.13.tar.gz | tar zxvf - -C /root
RUN cd /root/lua-resty-http-0.13 && LUA_LIB_DIR=/usr/share/lua/5.1 make install
RUN rm -rf /root/lua-resty-http-0.13

RUN apt-get remove --autoremove --purge -y \
    golang-go gcc make git xz-utils \
    python3-dev python3-setuptools python3-wheel python3-pip python3-gi python3-gi-cairo \
    libtiff5-dev libjpeg8-dev libopenjp2-7-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk \
    libharfbuzz-dev libfribidi-dev

RUN rm -rf /var/lib/apt/lists/*
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
    io.hass.name="Deluge" \
    io.hass.description="Deluge is a lightweight, Free Software, cross-platform BitTorrent client (with telegram bot)" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="" \
    org.label-schema.description="Deluge is a lightweight, Free Software, cross-platform BitTorrent client (with telegram bot)" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Deluge" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="" \
    org.label-schema.usage="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="" \
    org.label-schema.vendor=""
