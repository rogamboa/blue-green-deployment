FROM python:3.8-alpine

WORKDIR /app

COPY . app.py /app/

# hadolint ignore=DL3013
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]