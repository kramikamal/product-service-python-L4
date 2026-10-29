# Start with Python 3.15 on a smaller Linux image.
FROM python:3.15-slim

# Use this folder inside the image for the application.
WORKDIR /usr/src/app

# Copy the list of Python packages and their versions.
COPY requirements.txt .

# Install those packages without keeping downloaded package files.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files, excluding anything in .dockerignore.
COPY . .

# Document the port used by the Product Service.
EXPOSE 3030

# Set the default application port.
ENV PORT=3030

# Start the Python application when the container runs.
CMD ["python", "app.py"]
