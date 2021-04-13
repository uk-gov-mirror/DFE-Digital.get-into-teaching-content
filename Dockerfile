FROM dfedigital/get-into-teaching-web:sha-4418a8f

COPY config/*.yml config
COPY content app/views/content
COPY assets public/assets

# Add image compression packages
RUN apk add --no-cache jpegoptim=1.4.6-r0 optipng=0.7.7-r0 imagemagick=7.0.10.48-r0 parallel=20200522-r0

# Lossless optimize PNGs
RUN find public -type f -iname "*.png" -exec optipng -nb -nc -np {} \;
# Optimize JPEG at 90% quality
RUN find public -type f \( -iname "*.jpg" -o -iname "*.jpg" \) -exec jpegoptim -m90 --strip-all {} \;
RUN find public -type f \( -iname "*.jpeg" -o -iname "*.jpeg" \) -exec jpegoptim -m90 --strip-all {} \;

# Fingerprint content assets
RUN bundle exec rake fingerprinter:run

# Convert to WebP/JPEG-2000 formats (size constraint avoids an error on empty images)
# At 75% quality the images still look good and they are roughly half the size.
# We need to convert after the fingerprinting so the file names are consistent.
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN find public -name "*.jpg" -size "+1b" | parallel -eta magick {} -quality 75 "{.}.webp"
RUN find public -name "*.jpeg" -size "+1b" | parallel -eta magick {} -quality 75 "{.}.webp"
RUN find public -name "*.png" -size "+1b" | parallel -eta magick {} -quality 75 "{.}.webp"
RUN find public -name "*.jpg" -size "+1b" | parallel -eta magick {} -quality 75 "{.}.jp2"
RUN find public -name "*.jpeg" -size "+1b" | parallel -eta magick {} -quality 75 "{.}.jp2"

ARG CONTENT_SHA
RUN echo "${CONTENT_SHA}" > /etc/get-into-teaching-content-sha
RUN date -u -Iseconds > /etc/get-into-teaching-content-build-time
