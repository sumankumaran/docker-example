pipeline {
    agent any
    stages {
        stage ('build') {

            steps {
                withMaven(maven: 'Maven 3.6') {
                    sh 'mvn clean package'
                }
            }
        }
    }
}

