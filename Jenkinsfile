pipeline {
    agent any

    parameters {
        string(name: 'URL', defaultValue: 'https://github.com/matthcol/movieapp_jdbc.git', description: 'Java Project URL to Build')
        string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to Build')
        choice(name: 'JDK', choices: ['11', '17'], description: 'JDK to use')
    }

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
        jdk "jdk-${params.JDK}"
    }

    stages {
        stage('Git') {
            steps {
                // Get some code from a GitHub repository
                git url: "${params.URL}",
                branch: "${params.BRANCH}"
                sh "sed -i -e 's@<maven.compiler.target>.*</maven.compiler.target>@<maven.compiler.target>${params.JDK}</maven.compiler.target>@' -e 's@<maven.compiler.source>.*</maven.compiler.source>@<maven.compiler.source>${params.JDK}</maven.compiler.source>@' pom.xml"
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
                    junit '**/target/surefire-reports/TEST-*.xml'
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