FROM python:3.11-slim
WORKDIR /app
COPY . .
# No external dependencies required for kernel core
CMD ["python", "main.py"]
