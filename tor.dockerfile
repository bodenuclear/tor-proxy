from alpine:3.12
label name="tor-proxy"


run apk -U upgrade && \
	apk add tor curl && \
	tor --version && \
	chmod 700 /var/lib/tor && \
	rm -rf /var/cache/apk/*

run rm -rf /etc/tor/torrc && \
	echo 'User tor' >> /etc/tor/torrc && \
	echo 'HardwareAccel 1' >> /etc/tor/torrc && \
	echo 'Log notice stdout' >> /etc/tor/torrc && \
	echo 'DNSPort 0.0.0.0:53' >> /etc/tor/torrc && \
	echo 'SocksPort 0.0.0.0:9150' >> /etc/tor/torrc && \
	DataDirectory /var/lib/tor

healthcheck --timeout=10s --start-period=60s \
	cmd curl --fail --socks5-hostname localhost:9150 -I -L 'https://www.facebookcorewwwi.onion/' || exit 1

expose 53/udp 9150/tcp 
cmd ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
 
