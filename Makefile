#!/usr/bin/make
# Makefile readme: <https://www.gnu.org/software/make/manual/html_node/index.html#SEC_Contents>

SHELL = /bin/sh

.PHONY : up-dev build up down up-prod build-prod down-prod

help: ## Show this help
	@echo ""
	@echo    "████████╗███████╗███████╗████████╗"
	@echo    "╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝"
	@echo    "   ██║   █████╗  ███████╗   ██║   "
	@echo    "   ██║   ██╔══╝  ╚════██║   ██║   "
	@echo    "   ██║   ███████╗███████║   ██║   "
	@echo    "   ╚═╝   ╚══════╝╚══════╝   ╚═╝   "
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up-dev: up

build: ## build docker services
	docker-compose build --no-cache

up: build ## up docker services in the background
	docker-compose up -d

down: ## down docker services
	docker-compose down -v

up-prod: build-prod ## up production docker services in the background
	docker-compose -f docker-compose.yml up -d
	docker system prune -f

build-prod: ## build production docker services
	docker-compose -f docker-compose.yml build

down-prod: ## down production docker services
	docker-compose -f docker-compose.yml down -v
