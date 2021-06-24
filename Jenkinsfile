node {
    def server
    def buildInfo
    def rtMaven
    
    stage ('Clone') {
        git url: 'https://github.com/sumankumaran/docker-example.git'
    }
 
    stage ('Artifactory configuration') {
        server = Artifactory.server "Artifactory Server"

        rtMaven = Artifactory.newMavenBuild()
        rtMaven.tool = "Maven 3.6"
        rtMaven.deployer releaseRepo: "libs-release-local", snapshotRepo: "libs-snapshot-local", server: server
        rtMaven.resolver releaseRepo: "libs-release-local", snapshotRepo: "libs-snapshot-local", server: server
        rtMaven.deployer.deployArtifacts = false // Disable artifacts deployment during Maven run

        buildInfo = Artifactory.newBuildInfo()
    }
        
    stage ('Install') {
        rtMaven.run pom: 'pom.xml', goals: 'install', buildInfo: buildInfo
    }
 
    stage ('Deploy') {
        rtMaven.deployer.deployArtifacts buildInfo
    }
        
    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }
}