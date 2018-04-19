@Library('jenkins-pipeline-scripts') _

pipeline {
    agent none
    triggers {
        pollSCM('*/3 * * * *')
    }
    options {
        // Keep the 50 most recent builds
        buildDiscarder(logRotator(numToKeepStr:'30'))
    }
    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make docker-image'
            }
        }
        stage('Push image to registry') {
            agent any
            steps {
                pushImageToRegistry (
                    env.buildId,
                    'intranet/imio'
                )
            }
        }
        stage('Deploy to staging') {
            agent any
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                sh "mco shell run 'docker pull docker-staging.imio.be/intranet/imio:${env.buildId}' -I /^staging.imio.be$/"
            }
        }
        stage('Deploy to prod') {
            agent any
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                sh "docker tag docker-staging.imio.be/intranet/imio:${env.buildId} docker-prod.imio.be/intranet/imio:${env.buildId}"
                sh "docker tag docker-staging.imio.be/intranet/imio:${env.buildId}} docker-prod.imio.be/intranet/imio:${env.buildId}:latest"
                sh "docker push docker-prod.imio.be/intranet/imio"
                sh "docker rmi docker-staging.imio.be/intranet/imio:${env.buildId}"
                sh "docker rmi docker-prod.imio.be/intranet/imio"
                sh "docker rmi docker-prod.imio.be/intranet/imio:${env.buildId}"
                sh "mco shell run 'docker pull docker-prod.imio.be/intranet/imio:${env.buildId}' -I /^intranet-imio.imio.be$/"
            }
        }
    }
}
