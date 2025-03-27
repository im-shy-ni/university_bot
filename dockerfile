# ✅ Use Python 3.10 base image
FROM python:3.10-slim

# ✅ Set environment variables
ENV PYTHONUNBUFFERED=1
ENV VIRTUAL_ENV=/opt/venv

# ✅ Install dependencies
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# ✅ Install Rasa 3.6.0
RUN pip install --upgrade pip
RUN pip install rasa==3.6.0

# ✅ Set the working directory
WORKDIR /app

# ✅ Copy the project files
COPY . /app

# ✅ Expose the port
EXPOSE 5005

# ✅ Run Rasa with the correct Python version
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]
