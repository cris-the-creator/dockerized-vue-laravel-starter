#!/bin/bash

echo "🚀 Setting up environment..."

echo "Cleaning up existing directories..."
rm -rf backend frontend

echo "📦 Creating Laravel project..."
docker run --rm -v $(pwd):/app -w /app composer create-project laravel/laravel backend

echo "📦 Creating Vue project..."
docker run --rm -v $(pwd):/app -w /app node:20-alpine sh -c "
cd /app 
npm create vue@latest frontend << EOF
Vue.js
y
y
y
y
y
y
n
y
EOF
"

echo "⚙️ Configuring Laravel..."
cp backend/.env.example backend/.env

cat > backend/.env << EOF
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8080

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=mariadb
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_password

BROADCAST_DRIVER=log
CACHE_DRIVER=redis
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=redis
SESSION_LIFETIME=120

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379
EOF

echo "🐳 Building Docker containers..."
docker-compose build

echo "🎉 Setup complete! Run 'docker-compose up -d' to start the development environment"
echo ""
echo "📍 Access points:"
echo "   - Laravel API: http://localhost:8080"
echo "   - Vue Frontend: http://localhost:3000"
