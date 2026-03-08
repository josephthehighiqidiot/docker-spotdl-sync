FROM python:3.12-alpine

RUN pip install spotdl && \
    apk add --no-cache ffmpeg dcron

WORKDIR /app

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

CMD ["/app/entrypoint.sh"]