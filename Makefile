# Setup steps for our pipeline
setup:
	docker system prune 
	apt -y install tidy
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	chmod +x /bin/hadolint

build:
	docker build -t nginxy .
	
run:
	docker run -d -p 8080:80 nginxy

lint:
	tidy -q -e *.html
	hadolint Dockerfile
