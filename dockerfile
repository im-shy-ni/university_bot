# Install dependencies
RUN pip install rasa==3.6.0

# Ensure Rasa is accessible
RUN chmod +x /usr/local/bin/rasa

# Set the working directory
WORKDIR /app

# Activate the virtual environment and run the Rasa server
CMD ["/bin/bash", "-c", "source /app/.venv/bin/activate && rasa run --enable-api --cors \"*\" --port 5005"]
