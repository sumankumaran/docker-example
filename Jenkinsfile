node {
    def server
    def buildInfo
    def rtMaven

    environment {
            registry = "https://hub.docker.com/kumarakuruparans"
            registryCredential = 'docker_cred'
            dockerImage = ''
        }
    
    stage ('Code checkout') {
        git url: 'https://github.com/sumankumaran/docker-example.git'
    }
 
    stage ('Artifactory configuration') {
        server = Artifactory.server "Artifactory Server"

        rtMaven = Artifactory.newMavenBuild()
        rtMaven.tool = "Maven 3.6"
        rtMaven.deployer releaseRepo: "libs-release-local", snapshotRepo: "libs-snapshot-local", server: server
        rtMaven.resolver releaseRepo: "virtual-repo", snapshotRepo: "virtual-repo", server: server
        rtMaven.deployer.deployArtifacts = true // Disable artifacts deployment during Maven run

        buildInfo = Artifactory.newBuildInfo()
    }
        
    stage ('Maven Build') {
        rtMaven.run pom: 'pom.xml', goals: 'install', buildInfo: buildInfo
    }
 
    stage ('Maven Deploy') {
        rtMaven.deployer.deployArtifacts buildInfo
    }
        
    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }

    stage('Docker Build') {
        steps {
            script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
        }
    }

   stage('Docker Deploy') {
        steps {
            script {
                docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }
        }
    }

    stage('Cleaning up') {
        steps {
            sh "docker rmi $registry:$BUILD_NUMBER"
        }
    }
}