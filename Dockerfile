FROM tiangolo/uvicorn-gunicorn-fastapi:python3.11

WORKDIR /app

RUN apt update
RUN apt install -y debian-keyring debian-archive-keyring apt-transport-https
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
RUN apt update
RUN apt install -y caddy=2.7.6

COPY ./requirements.txt /app/requirements.txt
RUN  pip3 install -r requirements.txt

COPY ./app ./app
COPY ./domains ./domains
COPY ./entrypoint.sh ./entrypoint.sh

CMD ["./entrypoint.sh"]
