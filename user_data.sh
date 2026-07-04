#!/bin/bash
# system update 
apt update && apt upgrade -y

#python install
apt install python3 -y
apt install python3-pip -y

#flask install 
pip install flask --break-system-packages

# create app directory and write app.py file
mkdir /flask-app 
cat > /flask-app/app.py << 'EOF'

from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Flask App is Running"

@app.route("/health")
def health():
    return {"status": "healthy"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

EOF
# systemd create service
cat > /etc/systemd/system/flask-app.service << 'EOF'
[Unit]
Description=Flask Application
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/usr/bin/python3 /flask-app/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# systemd enable and start service
systemctl daemon-reload
systemctl enable flask-app
systemctl start flask-app
