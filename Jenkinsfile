pipeline {
    agent any
    stages {
        stage("Clone") {
            steps {
                script {
                    git url: "https://github.com/umerleghari01/two-tier-flask-app.git" ,branch: "master"
                    echo "Cloning..."
                }
            }
        }
        stage("Build") {
            steps {
                script {
                    sh "docker build -t flask-app:v1 ."
                    echo "Building..."
                }
            }
        }
        stage("Push and Login to DockerHub") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "dockerhubcreds", usernameVariable: "username", passwordVariable: "password")]) {
                        sh "docker login -u ${env.username} -p ${env.password}"
                        sh "docker image tag flask-app:v1 ${env.username}/flask-app:v1"
                        sh "docker push ${env.username}/flask-app:v1"
                        echo "Logging and Pushing..."
                    }
                }
            }
        }
        stage("Deploy") {
            steps {
                script {
                    sh "docker compose up -d"
                    echo "Deploying..."
                }
            }
        }
    }
    post {
        success {
            echo "pipeline succeed"
        }
        failure {
            echo "pipeline failed"
        }
    }
}
