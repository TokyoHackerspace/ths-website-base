SHELL="/bin/bash"

build:
	@docker-compose down

  # Check if the main website code exists otherwise pull it locally.
	@if [ ! -d "www/main" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-website.git www/main; \
		mkdir -p www/main/app/events/cache; \
		chmod 777 www/main/app/events/cache; \
		echo 'closed' > www/main/app/events/cache/status.txt; \
	fi

	  # Check if the akihabara tour website code exists otherwise pull it locally.
	@if [ ! -d "www/akihabara/html" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-akihabara-tour.git www/akihabara/html; \
	fi

	  # Build everything in the docker-compose.yml file.
	@docker-compose build

# Debug throws the docker logs to the console
debug:
	@docker-compose down
	@docker-compose -f docker-compose.yml -f ./overrides/development.yml up

# run does not throw the docker logs to the console
production:
	@docker-compose down
	@docker-compose -f docker-compose.yml -f ./overrides/production.yml up

# Stop brings down docker containers.
stop:
	@docker-compose down

# Clean brings down the docker containers and deletes other sub repositories
clean:
	@docker-compose down
	@rm -rf www/main
	@rm -rf www/akihabara
