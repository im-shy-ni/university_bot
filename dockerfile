# Use Python 3.9 base image (compatible with Rasa 3.6.0)
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install Rasa
RUN pip install rasa==3.6.0 rasa-sdk

# Copy project files into the container
COPY . /app

# Install dependencies
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install required dependencies from requirements.txt
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose Rasa server port
EXPOSE 5005

# Train the Rasa model
RUN rasa train

# Run Rasa server with debug and CORS enabled
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
