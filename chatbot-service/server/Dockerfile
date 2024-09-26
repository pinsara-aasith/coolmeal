# Use an official Python runtime as a parent image
FROM python:3.12

# Accept build arguments
ARG GOOGLE_API_KEY
ARG MONGODB_URI


# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install additional package
RUN pip install --no-cache-dir rapidocr-onnxruntime

# Copy the rest of the application into the container
COPY . .


# Set environment variables from build arguments
ENV GOOGLE_API_KEY=${GOOGLE_API_KEY}
ENV MONGODB_URI=${MONGODB_URI}


# Command to run the FastAPI app using Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
