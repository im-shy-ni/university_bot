# Base image with Python and Rasa installed
FROM rasa/rasa:3.6.0 

# Set working directory
WORKDIR /app

# Copy the Rasa project files into the container
COPY . /app

# Install Rasa SDK for custom actions
RUN pip install rasa-sdk

# Install dependencies from requirements.txt
RUN pip install -r requirements.txt

# Expose Rasa port
EXPOSE 5005

# Train the model
RUN rasa train

# Command to run Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
