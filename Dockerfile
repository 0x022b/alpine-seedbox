FROM scoobadog/alpine-s6:3.4
MAINTAINER Janne K <0x022b@gmail.com>

RUN \
addgroup -S flexget && \
adduser -s /sbin/nologin -h /var/lib/flexget -SD -G flexget flexget && \
addgroup -S openvpn && \
adduser -s /sbin/nologin -h /var/lib/openvpn -SD -G openvpn openvpn && \
apk --update-cache --upgrade add \
	iptables \
	ip6tables \
	openvpn \
	py-pip \
	transmission-daemon && \
pip install --no-cache-dir --upgrade pip flexget transmissionrpc && \
mkdir -p /var/log/flexget && chown flexget:flexget /var/log/flexget && \
mkdir -p /var/log/openvpn && chown openvpn:openvpn /var/log/openvpn && \
rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /root/.cache

COPY rootfs/ /
