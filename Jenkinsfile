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
        rtMaven.tool = MAVEN_TOOL
        rtMaven.deployer releaseRepo: ARTIFACTORY_LOCAL_RELEASE_REPO, snapshotRepo: ARTIFACTORY_LOCAL_SNAPSHOT_REPO, server: server
        rtMaven.resolver releaseRepo: ARTIFACTORY_VIRTUAL_RELEASE_REPO, snapshotRepo: ARTIFACTORY_VIRTUAL_SNAPSHOT_REPO, server: server
        rtMaven.deployer.deployArtifacts = false // Disable artifacts deployment during Maven run

        buildInfo = Artifactory.newBuildInfo()
    }
        
    stage ('Install') {
        rtMaven.run pom: 'maven-example/pom.xml', goals: 'install', buildInfo: buildInfo
    }
 
    stage ('Deploy') {
        rtMaven.deployer.deployArtifacts buildInfo
    }
        
    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }
}