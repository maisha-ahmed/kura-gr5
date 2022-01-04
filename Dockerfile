FROM python:3.10
COPY ./backend/requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./backend/ /backend/
COPY ./frontend/ /frontend/
ENV FLASK_APP=server.py
EXPOSE 5000
CMD flask run --host=0.0.0.0
