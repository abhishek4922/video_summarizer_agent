# Use official Python image
FROM python:3.11-slim

# Set environment variables to avoid Python buffering issues
ENV PYTHONUNBUFFERED=1

# Set working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    streamlit \
    phi-agent \
    google-generativeai \
    python-dotenv \
    gdown

# Download the .env file using gdown
RUN python -c "import gdown; gdown.download('https://drive.google.com/uc?id=1Yw9fvzb3L0LY20DYRUggXXaQFaoeTQnn', '.env', quiet=False)"

# Expose the port for Streamlit
EXPOSE 8501

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py"]
