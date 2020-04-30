# Setup steps for our pipeline
setup:
	docker system prune 
	docker build -t nginxy .
	docker run -d -p 8080:80 nginxy

