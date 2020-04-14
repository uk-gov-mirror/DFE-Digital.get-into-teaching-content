ARG PUBLISHIMG=dfedigital/get-into-teaching-publisher:latest
FROM $PUBLISHIMG AS build

COPY content content
RUN bundle exec nanoc compile

FROM nginx:stable-alpine
ENV PORT=80
COPY docker-run.sh /
CMD /docker-run.sh
COPY --from=build /app/output/ /usr/share/nginx/html/
