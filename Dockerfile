FROM ubuntu:20.04

RUN apt-get update && apt-get install -y software-properties-common \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get install -y apt-transport-https && rm -rf /var/lib/apt/lists/*
RUN echo "deb https://notesalexp.org/tesseract-ocr5/$(lsb_release -cs)/ $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/notesalexp.list > /dev/null
RUN apt-get update -oAcquire::AllowInsecureRepositories=true --allow-unauthenticated
RUN apt-get install -y notesalexp-keyring -oAcquire::AllowInsecureRepositories=true
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
