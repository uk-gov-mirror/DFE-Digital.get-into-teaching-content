ARG APP_SHA
FROM dfedigital/get-into-teaching-web:${APP_SHA}

COPY content app/views/content
COPY assets public/assets

ARG CONTENT_SHA
RUN echo "${CONTENT_SHA}" > /etc/get-into-teaching-content-sha
