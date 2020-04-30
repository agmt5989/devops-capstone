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
                docker.withRegistry('https://registry-1.docker.io/v2/', 'docker')
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'docker login -u $USERNAME --password $PASSWORD'
					sh 'docker push nginxy'
                }
            }
        }
    }
}