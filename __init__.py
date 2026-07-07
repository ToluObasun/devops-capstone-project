import os
import sys
import logging
from flask import Flask
from flask_talisman import Talisman
from flask_cors import CORS
from service.models import db

# 1. Initialize Flask Application
app = Flask(__name__)

# 2. Pull configuration environment variables
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
    "DATABASE_URI", "postgresql://postgres:postgres@localhost:5432/accounts"
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "secret-level-token-key")

# 3. Configure Flask-CORS (Cross-Origin Resource Sharing)
CORS(app, resources={r"/*": {"origins": "*"}})

# 4. Configure Flask-Talisman (Security Headers)
# Note: force_https is disabled globally or handled selectively for local testing/CI
Talisman(
    app,
    force_https=False,
    content_security_policy={
        'default-src': '\'self\'',
        'object-src': '\'none\''
    },
    referrer_policy='strict-origin-when-cross-origin'
)

# 5. Connect Database models
db.init_app(app)

# 6. Set up Logging infrastructure
app.logger.setLevel(logging.INFO)
app.logger.info("Initializing Customer Accounts Microservice with secure profiles...")

# Import routes after app initialization to prevent circular references
from service import routes
