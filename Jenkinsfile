node{
   environment {
        MVN_HOME = tool name: 'maven3', type: 'maven'
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        NEXUS_USERNAME = 'admin'
        NEXUS_PASSWORD = 'admin123'
    }
   stage('SCM Checkout'){
     git 'https://github.com/Anbazhagansekar-cloud/Setting-Up-CI-CD-and-Kubernetes-Deployment-using-Terraform.git'
   }
   stage('Compile-Package'){

      def mvnHome =  tool name: 'maven3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
   stage('SonarQube Analysis') {
	        def mvnHome =  tool name: 'maven3', type: 'maven'
	        withSonarQubeEnv('sonar') { 
	          sh "${mvnHome}/bin/mvn sonar:sonar"
	        }
	    }
   stage('Build Docker Imager'){
   sh 'docker build -t anbazhagan24s/myweb:0.0.2 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u anbazhagan24s -p ${dockerPassword}"
    }
   sh 'docker push anbazhagan24s/myweb:0.0.2'
   }
   stage('Nexus Image Push') {
    withCredentials([usernamePassword(credentialsId: 'nexus-credentials', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
        sh "docker login -u ${NEXUS_USERNAME} -p ${NEXUS_PASSWORD} 3.109.1.242:8083"
        sh "docker tag anbazhagan24s/myweb:0.0.2 3.109.1.242:8083/anbu:1.0.0"
        sh 'docker push 3.109.1.242:8083/anbu:1.0.0'
    }
}
   stage('Deploy on Kubernetes') {
                sh 'kubectl apply -f /var/lib/jenkins/workspace/kuber/pod.yaml'
                sh 'kubectl rollout restart deployment loadbalancer-pod'
        }
}
