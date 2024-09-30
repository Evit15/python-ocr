FROM ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common \
    && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:alex-p/tesseract-ocr-devel
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y \
    ffmpeg libsm6 libxext6 python3.9-dev \
    gcc tesseract-ocr python3-pip python3-pil \
    && rm -rf /var/lib/apt/lists/*
RUN python3.9 -m pip install --upgrade pip
RUN python3.9 --version
RUN python3.9 -m pip install --no-cache-dir wheel
RUN python3.9 -m pip install --no-cache-dir image
WORKDIR /app
COPY requirements.txt /app
RUN python3.9 -m pip install --no-cache-dir -r requirements.txt
ENV PYTHONPATH "${PYTHONPATH}:/app"