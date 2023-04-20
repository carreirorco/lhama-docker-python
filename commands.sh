#! /bin/bash
### Playlist "Docker na Prática com Python" (https://www.youtube.com/playlist?list=PLAgbpJQADBGIDbMSopaqFnGm7GJnwru0-) ###
### Video 3/7: Docker na Prática - Aula 2 - Setando a Aplicação ###

# Create repository on GitHub and clone it

# Install python3-venv
sudo apt install -y python3-venv

# Create a virtual environment 
python3 -m venv venv

# Activate the virtual environment
# shellcheck source=venv/bin/activate
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

# Docker commands example
docker sop 9d0
docker rm 9d0
docker run -p 2300:5000 -d docker-python
docker stop e09

# Create a mysql container
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=lhama -d mysql:latest
docker inspect 4b6be5693
docker stop 4b6be5693
docker rm 4b6be5693

# Create a mysql container with port 3306 and a volume
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=lhama -p 3306:3306 -v mysqlVolume:/var/lib/mysql -d mysql:latest

# Commit
git add commands.sh
git commit -m "doc: create mysql container with a volume"

# Create a file to create database and table on mysql
mkdir init
cat << EOF > init/schema.sql
CREATE DATABASE teste;

CREATE TABLE IF NOT EXISTS `teste`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL
) ENGINE = InnoDB;
EOF

# Execute schema.sql on mysql container
docker exec -i 11eccd2348bf mysql -uroot -plhama <./init/schema.sql

### Video 5/7: Docker na Prática - Aula 5 - Aplicação e Banco de Dados ###

# Some directories and files has been created
