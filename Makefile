.PHONY: build up down restart logs shell verify backup restore clean hooks

build:
	docker compose -f docker/docker-compose.yml build

up:
	docker compose -f docker/docker-compose.yml up -d

down:
	docker compose -f docker/docker-compose.yml down

restart:
	./deploy/restart.sh

logs:
	./deploy/logs.sh

shell:
	docker exec -it cs16-server bash

verify:
	./deploy/verify.sh

backup:
	./deploy/backup.sh

restore:
	@echo "Usage: make restore FILE=backups/<backup>.tar.gz"
	@test -n "$(FILE)"
	./deploy/restore.sh $(FILE)

clean:
	docker system prune -f

hooks:
	./scripts/install-hooks.sh