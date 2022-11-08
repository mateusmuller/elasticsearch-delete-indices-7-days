FROM alpine:3.16.2

WORKDIR /app

RUN apk update && \
  apk add curl jq

COPY check_indices.sh .

RUN chmod +x check_indices.sh

CMD [ "sh","check_indices.sh" ]