pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
    }
    stage('Build Dockerfile') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                sh 'docker build -t nginxy .'
            }
		}
    }
}