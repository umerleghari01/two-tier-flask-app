# Base image

FROM python:3.9-slim

# Set working directory

WORKDIR   /app

# Install Packages

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy files from host to container (working directory path)

COPY   .    /app

# Run to compile code

RUN  pip install -r requirements.txt

RUN pip install mysqlclient

# Expose a port

EXPOSE  5000

# Set default command to run the compiled code

CMD  ["python", "app.py"]

