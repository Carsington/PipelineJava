pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }

    stages {
        stage('Git') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main',
                url: 'https://github.com/matthcol/movieapp_jdbc.git'
            }
        }
        stage('Compile'){
            steps{
                // Run Maven
                sh "mvn clean compile"
            }
        }
        stage('Test'){
            steps{
                // Test
                sh "mvn test"
            }
            // Post = traitement
            post {
                always {
                    junit '*/target/surefire-reports/TEST-.xml'
                }
            }
        }
        stage('Package'){
            steps{
                // Skip the tests
                sh "mvn -DskipTests -Dmaven.test.skip package"
            }
            post {
                success {
                    archiveArtifacts 'target/*.jar, target/*.war'
                }
            }
        }
    }
}