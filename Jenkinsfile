pipeline {
    agent any
    environment {
        registry = "kumarakuruparans/docker-example"
        registryCredential = 'docker_cred'
        dockerImage = ''
     }
    stages {
        stage ('Code checkout') {
            steps {
                git url: "https://github.com/sumankumaran/docker-example.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "Artifactory Server",
                    url: "http://localhost:8081/artifactory",
                    credentialsId: "afdc4547-39a9-40d7-8a73-6fe5415e4133"
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "Artifactory Server",
                    releaseRepo: "libs-release-local",
                    snapshotRepo: "libs-snapshot-local"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "Artifactory Server",
                    releaseRepo: "maven-virtual-repo",
                    snapshotRepo: "maven-virtual-repo"
                )
            }
        }

        stage ('Maven Build') {
            steps {
                rtMavenRun (
                    tool: "Maven 3.6",
                    pom: 'pom.xml',
                    goals: 'clean package',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }

        stage ('Maven Deploy') {
            steps {
                rtPublishBuildInfo (
                    serverId: "Artifactory Server"
                )
            }
        }
        stage('Docker Build') {
                steps {
                    script {
                        dockerImage = docker.build("kumarakuruparans/docker-example:$BUILD_NUMBER")
                    }
                }
         }

         stage('Docker Deploy') {
                 steps {
                     script {
                         docker.withRegistry( 'https://hub.docker.com/', registryCredential ) {
                             dockerImage.push("latest")
                             dockerImage.push("$BUILD_NUMBER")
                         }
                     }
                 }
         }

         stage('Clean up') {
                 steps {
                     sh "docker rmi $registry:$BUILD_NUMBER"
                 }
         }
    }
}