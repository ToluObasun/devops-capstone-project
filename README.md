# devops-capstone-project# Customer Accounts Microservice
![CI Build](https://github.com/<your-github-username>/devops-capstone-project/actions/workflows/ci-build.yaml/badge.svg)

---

## 📝 Project Description
This repository contains the **Customer Accounts Microservice**, developed as part of the DevOps Capstone Project. The service is a RESTful API built using Flask, designed to handle core client account operations using Test-Driven Development (TDD). It features built-in security profiles (Flask-Talisman, CORS) and is prepared for fully automated cloud-native deployment via Tekton CD pipelines.

## 🚀 Features Implemented
* **RESTful CRUD & List API:** Robust endpoints for creating, reading, updating, deleting, and listing customer data profiles.
* **Continuous Integration (CI):** Automated linting via `flake8` and unit-testing with `nosetests` triggered on every push or pull request.
* **Application Hardening:** Injected secure HTTP headers and cross-origin resource sharing rules.
* **Container Ready:** Operational multi-stage `Dockerfile` configurations matching cloud-native ecosystem standards.

## 🛠️ Tech Stack
* **Language/Framework:** Python 3.9, Flask
* **Database:** PostgreSQL
* **Testing & Quality:** Nosetests, Flake8, Coverage.py (>= 95% threshold)
* **CI/CD & Clouds:** GitHub Actions, Docker, Tekton, OpenShift/Kubernetes

---

## ⚡ Local Quickstart
To spin up the service dependencies and run the development server locally:

```bash
# Install dependencies
pip install -r requirements.txt

# Run the local unit tests and check test coverage
nosetests --with-spec --spec-color --with-coverage

# Boot up the server using Honcho
honcho start
