.PHONY: none init up down rebuild migration logs backend_bash frontend_bash

none:
	# nothing
	@echo "Please don't run make without an argument, i have no idea what to do now :O"

init:
	@chmod +x docker/setup.sh
	@./docker/setup.sh

	@$(MAKE) up
	docker-compose exec backend php artisan key:generate
	@$(MAKE) migration
	docker-compose exec frontend npm install

up:
	@docker-compose up -d

down:
	docker-compose down

rebuild:
	docker-compose build --no-cache

migration:
	docker-compose exec backend php artisan migrate

logs:
	docker-compose logs -f

logs_fe:
	docker-compose logs -f frontend

logs_be:
	docker-compose logs -f backend

logs_laravel:
	docker-compose exec backend cat storage/logs/laravel.log

backend_bash:
	docker-compose exec backend bash

frontend_bash:
	docker-compose exec frontend sh
