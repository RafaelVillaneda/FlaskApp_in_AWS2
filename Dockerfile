
FROM python:3.9.13-alpine3.16 AS base
RUN apk add --no-cache nginx
WORKDIR /app

FROM base AS builder
COPY . /app
RUN apk add --no-cache --virtual .build-deps gcc musl-dev \
    && pip wheel --wheel-dir=/wheels -r requirements.txt \
    && apk del .build-deps


FROM base


COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir /wheels/*


COPY nginx.conf /etc/nginx/nginx.conf


COPY . /app


RUN pip install gunicorn
EXPOSE 80
CMD ["sh", "-c", "nginx && gunicorn -w 4 -b 0.0.0.0:8000 app:app"]