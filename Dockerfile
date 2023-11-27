FROM ubuntu:22.04 as builder

RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install software-properties-common -y \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update

RUN apt-get install python3.10 -y \
    && apt-get install python3-pip -y

FROM builder

WORKDIR /app

COPY requirements.txt /app

RUN pip install -r requirements.txt

COPY app /app

EXPOSE 5000

ENTRYPOINT [ "python3", "app.py" ]