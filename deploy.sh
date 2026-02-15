#!/bin/bash

# Fashion Paradise Ladies Tailor - Deployment Script
# This script provides deployment options for various cloud platforms

echo "Fashion Paradise Ladies Tailor - Deployment Options"
echo "=================================================="

# Check if Docker image exists
if ! docker image inspect fashion-paradise:latest > /dev/null 2>&1; then
    echo "❌ Docker image not found. Building..."
    docker build -t fashion-paradise:latest .
fi

echo "✅ Docker image ready: fashion-paradise:latest"

echo ""
echo "Choose deployment option:"
echo "1) Local Docker Run"
echo "2) Deploy to Azure Container Apps (requires quota increase)"
echo "3) Deploy to Railway"
echo "4) Deploy to Render"
echo "5) Deploy to Heroku"
echo "6) Export Docker image for manual deployment"

read -p "Enter choice (1-6): " choice

case $choice in
    1)
        echo "🚀 Running locally..."
        docker run --rm -p 3000:3000 fashion-paradise:latest
        ;;
    2)
        echo "📋 Azure Container Apps deployment instructions:"
        echo "1. Request quota increase for Basic VMs in your Azure subscription"
        echo "2. Run: az containerapp create \\"
        echo "   --name fashion-paradise-app \\"
        echo "   --resource-group fashion-paradise-rg \\"
        echo "   --image fashionparadiseregistry.azurecr.io/fashion-paradise:latest \\"
        echo "   --target-port 3000 \\"
        echo "   --ingress external"
        ;;
    3)
        echo "🚂 Railway deployment:"
        echo "1. Install Railway CLI: npm install -g @railway/cli"
        echo "2. Login: railway login"
        echo "3. Deploy: railway up"
        ;;
    4)
        echo "🎨 Render deployment:"
        echo "1. Create account at https://render.com"
        echo "2. Connect GitHub repository"
        echo "3. Create new Web Service"
        echo "4. Use Docker runtime"
        ;;
    5)
        echo "🌿 Heroku deployment:"
        echo "1. Install Heroku CLI"
        echo "2. Login: heroku login"
        echo "3. Create app: heroku create fashion-paradise-app"
        echo "4. Push container: heroku container:push web"
        echo "5. Release: heroku container:release web"
        ;;
    6)
        echo "📦 Exporting Docker image..."
        docker save fashion-paradise:latest -o fashion-paradise.tar
        echo "✅ Image exported to fashion-paradise.tar"
        echo "You can now load this image on any server with: docker load -i fashion-paradise.tar"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac
