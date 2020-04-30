pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Dockerfile') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'docker build -t nginxy .'
                }
            }
        }
        stage('Push Docker image') {
            steps {
                docker.withRegistry('https://registry.hub.docker.com', 'docker')
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'docker login -u $USERNAME --password $PASSWORD'
					sh 'docker push nginxy'
                }
            }
        }
    }
}