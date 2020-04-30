pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }
        stage('Blue cluster') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh '''
						eksctl create cluster \
						--name blue \
						--nodegroup-name workers \
						--node-type t2.micro \
						--nodes 2 \
						--nodes-min 2 \
						--nodes-max 5 \
						--region us-west-2 \
						--node-ami auto
					'''
				}
			}
		}
        stage('Green cluster') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh '''
						eksctl create cluster \
						--name green \
						--version 1.14 \
						--nodegroup-name workers \
						--node-type t2.micro \
						--nodes 2 \
						--nodes-min 2 \
						--nodes-max 5 \
						--region us-west-2 \
						--node-ami auto
					'''
				}
			}
		}
    }
}