all:
	bash srcs/requirements/wordpress/tools/make_dir.sh
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	bash srcs/requirements/wordpress/tools/make_dir.sh
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

bonus:
	docker volume create portainer_data
	docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

clean: down
	docker system prune -a

fclean: 
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
