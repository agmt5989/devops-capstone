pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Dockerfile') {
            def app
            steps {
                app = docker.build('nginxy')
            }
        }
        stage('Push Docker image') {
            steps {
                docker.withRegistry('https://registry-1.docker.io/v2/', 'docker') {
                    app.push('latest')
                }
            }
        }
    }
}