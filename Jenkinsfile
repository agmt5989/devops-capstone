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
        stage('Blue configuration') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'aws eks --region us-west-2 update-kubeconfig --name nginxyblue'
				}
			}
		}
		stage('Green configuration') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'aws eks --region us-west-2 update-kubeconfig --name nginxygreen'
				}
			}
		}
		stage('Blue deployment') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'kubectl apply -f ./blue.yml'
				}
			}
		}
		stage('Green deployment') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'kubectl apply -f ./green.yml'
				}
			}
		}
		stage('Blue service') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'kubectl apply -f ./service-blue.yml'
				}
			}
		}
 		stage('Green service') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscred') {
					sh 'kubectl apply -f ./service-green.yml'
				}
			}
		}
    }
}