FROM python:3.8-slim
WORKDIR /app
COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt
COPY phase2/ .
CMD ["python3", "pipeline.py"]
