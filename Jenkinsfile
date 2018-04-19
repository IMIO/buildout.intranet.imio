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
                    'docker-staging.imio.be/intranet/imio'
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
                deployToStaging (
                    env.buildId,
                    'intranet/imio'
                    'role::docker::sites$',
                     '/srv/docker_scripts/website-update-all-images.sh'
                )
            }
        }
    }
}
