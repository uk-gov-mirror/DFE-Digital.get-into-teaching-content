FROM dfedigital/get-into-teaching-web:sha-ae3624d

COPY config/*.yml config
COPY content app/views/content
COPY assets public/assets

# Add image compression packages
RUN apk add --no-cache jpegoptim=1.4.6-r0 optipng=0.7.7-r0

# Lossless optimize PNGs
RUN find . -type f -iname "*.png" -exec optipng -nb -nc -np {} \;
# Optimize JPEG at 90% quality
RUN find . -type f \( -iname "*.jpg" -o -iname "*.jpg" \) -exec jpegoptim -m90 --strip-all {} \;
RUN find . -type f \( -iname "*.jpeg" -o -iname "*.jpeg" \) -exec jpegoptim -m90 --strip-all {} \;

# Fingerprint content assets
RUN bundle exec rake fingerprinter:run

ARG CONTENT_SHA
RUN echo "${CONTENT_SHA}" > /etc/get-into-teaching-content-sha
RUN date -u -Iseconds > /etc/get-into-teaching-content-build-time
