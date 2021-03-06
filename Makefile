SHELL="/bin/bash"

build:

	@docker-compose down

  # Make sure we have the website proxy repository.
	@if [ ! -d "../ths-website-rproxy" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-website-rproxy.git ../ths-website-rproxy; \
	fi

  # Make sure we have the apache php repository.
	@if [ ! -d "../ths-website-apache-php" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-website-apache-php.git ../ths-website-apache-php; \
	fi

  # Check if the main website code exists otherwise pull it locally.
	@if [ ! -d "vol/www/main" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-website.git vol/www/main; \
		mkdir -p vol/www/main/app/events/cache; \
		chmod 777 vol/www/main/app/events/cache; \
		echo 'closed' > vol/www/main/app/events/cache/status.txt; \
	fi

  # Check if the akihabara tour website code exists otherwise pull it locally.
	@if [ ! -d "vol/www/akihabara/html" ]; then  \
		git clone git@github.com:TokyoHackerspace/ths-akihabara-tour.git vol/www/akihabara/html; \
	fi

  # Build everything in the docker-compose.yml file.
	@docker-compose build


# Debug throws the docker logs to the console
debug:

	@if [ -f "vol/www/main/html/.htaccess" ]; then  \
    echo "Removing existing symlink to htaccess file"; \
		rm vol/www/main/html/.htaccess; \
	fi

	@echo "Linking development htaccess file";
	@(cd vol/www/main/html; ln -s ../app/security/htaccess-dev .htaccess)

	@docker-compose down
	@docker-compose -f docker-compose.yml -f ./overrides/development.yml up

# Run does not throw the docker logs to the console
production:

	@if [ -f "vol/www/main/html/.htaccess" ]; then  \
    echo "Removing existing symlink to htaccess file"; \
		rm vol/www/main/html/.htaccess; \
	fi

  @echo "Linking production htaccess file";
	@(cd vol/www/main/html; ln -s ../app/security/htaccess-prod .htaccess)

	@docker-compose down
	@docker-compose -f docker-compose.yml -f ./overrides/production.yml up


# Stop brings down docker containers.
stop:

	@docker-compose down

# Clean brings down the docker containers and deletes other sub repositories
clean:
  @docker-compose down
  @echo "Removing the main website repository"
  @rm -rf vol/www/main
  @echo "Removing the akihabaratour website repository"
  @rm -rf vol/www/akihabara
  @echo "Removing the mysql temp directory"
  @rm -rf vol/mysql
