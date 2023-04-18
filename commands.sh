### Playlist "Docker na Prática com Python" (https://www.youtube.com/playlist?list=PLAgbpJQADBGIDbMSopaqFnGm7GJnwru0-) ###
### Video 3/7: Docker na Prática - Aula 2 - Setando a Aplicação ###

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

