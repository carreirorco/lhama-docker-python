#! /bin/bash
### Playlist "Docker na Prática com Python" (https://www.youtube.com/playlist?list=PLAgbpJQADBGIDbMSopaqFnGm7GJnwru0-) ###
### Video 3/7: Docker na Prática - Aula 2 - Setando a Aplicação ###

# Create repository on GitHub and clone it

# Install python3-venv
sudo apt install -y python3-venv

# Create a virtual environment 
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# On Code, press Ctrl+Shift+P and type "Python: Select Interpreter" and select the venv

# Install Flask
pip3 install Flask

# Generate requirements.txt
pip3 freeze > requirements.txt

# Example for install requirements.txt
pip3 install -r requirements.txt

# Use pre-commit for increment requirements.txt automatically
pip3 install pre-commit

# Create .pre-commit-config.yaml file
cat << EOF > .pre-commit-config.yaml
repos:
-   repo: local
    hooks:
      - id: requirements
        name: requirements
        entry: bash -c 'venv/bin/pip3 freeze > requirements.txt; git add requirements.txt'
        language: system
        pass_filenames: false
        stages: [commit]
EOF

# Install pre-commit
pre-commit install

# Add .pre-commit-config.yaml to git
git add .pre-commit-config.yaml

# Commit
git commit -m "config: installing pre-commit"

# Add app.py to git
cat << EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route("/", methods=['GET'])
def hello_world():
    return "Olá Mundo!"
EOF

# Export FLASK_APP
export FLASK_APP=run.py

# Run Flask
flask run

# Commit
git add .
git commit -m "feat: implementing first route"

### Video 4/7: Docker na Prática - Aula 3 - Imagem e Container da Aplicação ###

# Create dockerignore
cat << EOF > .dockerignore
**/__pycache__
venv
EOF

# Create Dockerfile
cat << EOF > Dockerfile
# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app
ENV FLASK_APP run.py

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]

EOF

# Docker commands example
docker build --tag docker-python .
docker run docker-python
docker start 9d01ce909972
docker stop 9d01ce909972
docker exec -it 9d01ce909972 bash

### Video 4/7: Docker na Prática - Aula 4 - Portas, Banco de Dados e Volumes ###
