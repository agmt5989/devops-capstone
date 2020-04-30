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
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'docker login -u $USERNAME -p $PASSWORD'
					sh 'docker push nginxy'
                }
            }
        }
        stage('Blue cluster') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh '''
						eksctl create cluster \
						--name blue \
						--version 1.14 \
						--nodegroup-name standard-workers \
						--node-type t2.micro \
						--nodes 2 \
						--nodes-min 2 \
						--nodes-max 5 \
						--node-ami auto \
						--region us-west-2
					'''
				}
			}
		}
    }
}