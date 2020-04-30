pipeline {
    agent any
    def dockerImage
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Dockerfile') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    dockerImage = docker.build('imyke/nginxy:latest')
                }
            }
        }
        stage('Push Docker image') {
            steps {
                docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                    dockerImage.push()
                }
            }
        }
    }
}