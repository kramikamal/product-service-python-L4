# Product Service (Python)

This Flask service serves `GET /products` on port 3030 by default. It returns the same catalog as the Rust implementation: Dog Food ($19.99), Cat Food ($34.99), and Bird Seeds ($10.99), with numeric IDs and prices. CORS allows the Store Front to fetch the catalog from another origin.

## Requirements

- Python 3.12 or newer for local development
- Python 3.15 for the Lab 5 container baseline

On Ubuntu 24.04, install the system Python and virtual-environment support:

```bash
sudo apt update
sudo apt install -y python3 python3-venv
```

## Local Setup

Run commands from this repository root. On Linux/macOS:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
cp .env.example .env
python app.py
```

On Windows PowerShell, create and activate the environment with:

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
Copy-Item .env.example .env
python app.py
```

The service binds to all IPv4 interfaces. `PORT` defaults to 3030; change it in `.env` or the shell and restart the process. Existing environment variables take precedence over the optional `.env` file.

Local environment files and virtual environments are ignored by Git and Docker. Commit `.env.example` and `requirements.txt`, which pins the tested direct and transitive dependencies. No RabbitMQ connection is required.

## Verification

From another terminal:

```bash
curl -i http://localhost:3030/products
curl -i -H 'Origin: http://localhost:8080' http://localhost:3030/products
```

Expect HTTP 200, three products, and an `Access-Control-Allow-Origin` response header for the second request. Use `test-product-service.http` with the VS Code REST Client extension as an alternative.

On Azure, use the VM's public IP in the laptop browser and allow the API port in its NSG. If you change `PORT`, update the request URL and port mapping as well.

## Lab 5 Containers

Create the Dockerfile using Lab 5's `python:3.15-slim` example. Install `requirements.txt`, then run `python app.py`. The supplied `.dockerignore` excludes local environment files and generated folders.

The Flask development server is sufficient for this Docker learning exercise. For a production deployment, use a WSGI server such as Gunicorn and follow its deployment guidance.

The tested application dependencies are Flask 3.1.3, Flask-Cors 6.0.5, and python-dotenv 1.2.4. The Rust and Python implementations share the same API contract; choose one for the Compose stack.
