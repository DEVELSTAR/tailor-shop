# Fashion Paradise Ladies Tailor - Deployment Guide

## Quick Start

### Option 1: Run Locally
```bash
docker run --rm -p 3000:3000 fashion-paradise:latest
```

### Option 2: Use Deployment Script
```bash
./deploy.sh
```

## Cloud Deployment Options

### Azure Container Apps
1. Request quota increase for Basic VMs in Azure subscription
2. Use the pre-created resources:
   - Resource Group: `fashion-paradise-rg`
   - Container Registry: `fashionparadiseregistry.azurecr.io`
   - Image: `fashionparadiseregistry.azurecr.io/fashion-paradise:latest`

### Railway (Recommended for simplicity)
```bash
npm install -g @railway/cli
railway login
railway up
```

### Render
1. Connect your GitHub repository to Render
2. Create new Web Service
3. Select Docker runtime
4. Set port to 3000

### Heroku
```bash
heroku login
heroku create fashion-paradise-app
heroku container:push web
heroku container:release web
```

## Environment Variables
- `RAILS_ENV=production`
- `SECRET_KEY_BASE=<your-secret-key>`
- `DATABASE_URL=sqlite3:/rails/db/production.sqlite3`

## Database Configuration
The app is configured to use SQLite3 by default for simplicity. For production, consider:
- PostgreSQL for better performance
- Azure Database for PostgreSQL
- Railway PostgreSQL
- Render PostgreSQL

## Image Details
- Base: Ruby 3.4.5-slim
- Platform: linux/amd64
- Size: Multi-stage build for optimization
- Port: 3000

## Troubleshooting
- Ensure Docker daemon is running
- Check port 3000 is available
- Verify environment variables are set
- For Azure: Check quota limits
