# Use official Python image as base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all files from your repo to container
COPY app.py .
COPY requirements.txt .

# Install dependencies if you have a requirements.txt
RUN pip install -r requirements.txt

# Command to run your app
CMD ["python", "app.py"]
