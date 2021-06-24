pipeline {
    agent any
    stages {
        stage ('build') {

            steps {
                withMaven(maven : 'apache-maven') {
                    sh 'mvn clean install'
                }
            }
        }
    }
}

