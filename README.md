# Fashion Paradise Ladies Tailor

A modern, minimalist web application for a ladies' tailoring shop, built with Ruby on Rails 8, Hotwire, and PostgreSQL.

## Features

- **Frontend**:
  - Modern, minimalist design with vivid colors and glassmorphism.
  - Fully responsive mobile-first layout.
  - Reviews section with real-time submission (Hotwire Turbo).
  - Business information (Hours, Address, Map).
  - SEO optimized (Meta tags, JSON-LD, Sitemap).

- **Backend / Admin**:
  - Secure Admin authentication.
  - Dashboard with analytics (Review count, Average rating).
  - Manage Reviews (Approve, Delete).
  - Update Business Info.
  - API endpoints for external integrations.

## Tech Stack

- **Framework**: Ruby on Rails 8.1.2
- **Database**: PostgreSQL
- **Frontend**: Vanilla CSS (Modern), Hotwire (Turbo + Stimulus)
- **Deployment**: Docker, Azure-ready (Dockerfile included)

## Getting Started

### Prerequisites

- Ruby 3.4.5
- PostgreSQL
- Docker (optional)

### Local Setup

1.  **Clone the repository**:

    ```bash
    git clone <repository-url>
    cd fashion-paradise-ladies-tailor
    ```

2.  **Install dependencies**:

    ```bash
    bundle install
    ```

3.  **Setup Database**:

    ```bash
    bin/rails db:create db:migrate db:seed
    ```

4.  **Run the server**:
    ```bash
    bin/rails server
    ```
    Visit `http://localhost:3000`.

### Admin Access

- **Login URL**: `/login` (or click "Admin Login" in footer if added, otherwise direct URL).
- **Default Credentials**:
  - Email: `admin@example.com`
  - Password: `password123`

### API Endpoints

- `GET /api/v1/business_info` - Returns business details JSON.
- `GET /api/v1/reviews` - Returns approved reviews JSON.

## Deployment

### Docker

Build and run the container:

```bash
docker build -t fashion_paradise .
docker run -p 3000:80 \
  -e SECRET_KEY_BASE=... \
  -e DATABASE_URL=postgres://... \
  fashion_paradise
```

### Azure

Push the Docker image to ACR and deploy to Azure Container Apps. Ensure `RAILS_MASTER_KEY` or environment variables are set.

## Project Structure

- `app/models`: Business logic (Review, BusinessInfo, User).
- `app/controllers/admin`: Admin namespace controllers.
- `app/controllers/api`: API V1 controllers.
- `app/views/home`: Main landing page with partials.
- `app/assets/stylesheets/application.css`: Custom modern CSS.

## License

MIT
