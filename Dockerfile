FROM --platform=linux/amd64 python:3.12.1-slim-bookworm

WORKDIR /usr/src

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN pip install pandas

COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY ./src .

ENTRYPOINT ["bash", "orchestrate.sh"] 