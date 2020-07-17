FROM alpine:3.12

EXPOSE 8118/tcp
HEALTHCHECK --interval=30s --timeout=3s CMD nc -z localhost 8118
RUN apk --no-cache --update add privoxy wget ca-certificates && \
    sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:8118/' /etc/privoxy/config && \
    sed -i'' 's/enable-edit-actions\ 0/enable-edit-actions\ 1/' /etc/privoxy/config && \
    sed -i'' 's/#max-client-connections/max-client-connections/' /etc/privoxy/config && \
    sed -i'' 's/accept-intercepted-requests\ 0/accept-intercepted-requests\ 1/' /etc/privoxy/config && \
    mkdir temp && \
    echo 'forward-socks5 / tor:9150 .' >> /etc/privoxy/config
RUN chown privoxy.privoxy /etc/privoxy/*

ENTRYPOINT ["privoxy"]
CMD ["--no-daemon","--user","privoxy","/etc/privoxy/config"]
