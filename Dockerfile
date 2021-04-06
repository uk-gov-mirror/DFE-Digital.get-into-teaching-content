FROM dfedigital/get-into-teaching-web:sha-1459819

COPY config/*.yml config
COPY content app/views/content
COPY assets public/assets

# Add image compression packages
RUN apk add --no-cache jpegoptim=1.4.6-r0

# Optimize all assets
RUN find . -type f \( -iname "*.jpg" -o -iname "*.jpg" \) -exec jpegoptim -m90 -f --strip-all {} \;
RUN find . -type f \( -iname "*.jpeg" -o -iname "*.jpeg" \) -exec jpegoptim -m90 -f --strip-all {} \;

# Fingerprint content assets
RUN bundle exec rake fingerprinter:run

ARG CONTENT_SHA
RUN echo "${CONTENT_SHA}" > /etc/get-into-teaching-content-sha
RUN date -u -Iseconds > /etc/get-into-teaching-content-build-time
