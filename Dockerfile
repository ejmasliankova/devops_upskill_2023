FROM ubuntu:22.04 as builder
 
RUN apt-get update \
    && apt-get upgrade -y
RUN apt-get install software-properties-common -y \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update

RUN apt-get install python3.10 -y \
    && apt-get install python3-pip -y 

FROM builder
RUN mkdir -p /app \
    && useradd -d /app -s /bin/bash app \
    && chown -R app:app /app
WORKDIR /app

COPY requirements.txt /app

RUN pip3 install -r requirements.txt

COPY app/app.py /app

EXPOSE 5000

USER app

ENTRYPOINT [ "python3", "app.py" ]