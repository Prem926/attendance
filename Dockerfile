# Use Python 3.9 base image
FROM python:3.9

# Set working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Install system dependencies required for dlib
RUN apt-get update && apt-get install -y \
    cmake \
    libboost-all-dev \
    libopenblas-dev \
    libx11-dev \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv /opt/venv && . /opt/venv/bin/activate

# Upgrade pip before installing requirements
RUN pip install --upgrade pip

# Install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for Streamlit
EXPOSE 8501

# Run Streamlit application
CMD ["streamlit", "run", "attendance.py", "--server.port=8501", "--server.address=0.0.0.0"]
