provider "jenkins" {
  version = "~> 2.1"
  url     = "http://jenkins-server-url/"
  username = "admin"
  password = "admin"
}

resource "jenkins_job" "example" {
  name     = "example-job"
  config   = <<EOF
<flow-definition plugin="workflow-job@2.40">
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.87">
    <scm class="hudson.plugins.git.GitSCM" plugin="git@4.13.1">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/Anbazhagansekar-cloud/Setting-Up-CI-CD-and-Kubernetes-Deployment-using-Terraform.git</url>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/main</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
      <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <scriptPath>Jenkinsfile</scriptPath>
  </definition>
  <triggers/>
</flow-definition>
EOF
}
