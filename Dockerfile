# Pull from $BASE_IMAGE_SHA passed as build-arg or use latest if empty
ARG BASE_IMAGE_SHA=latest
FROM dfedigital/get-into-teaching-web:${BASE_IMAGE_SHA}

COPY content app/views/content
COPY assets public/assets
