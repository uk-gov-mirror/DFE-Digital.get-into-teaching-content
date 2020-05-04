ARG RAILSAPP=dfedigital/get-into-teaching-web:latest
FROM $RAILSAPP

COPY content app/views/content
