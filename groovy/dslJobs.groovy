//////////////////////////////////////////////////////////////////
//Script Name	:dslJobs.groovy					 /
//Description	:create jenkins jobs and set their configuration /
//Author     	:Leandro Solagna                                 /
//Date       	:07/01/2019					 /
//////////////////////////////////////////////////////////////////

//GLOBAL VARIABLES

//Job's name

PrefixName = "Project"
DashJob = "01 - Project"
Job1 = "${PrefixName}_1"
Job2 = "${PrefixName}_2"

ArtifactServerId = "artifactory-server"
CredentialsSecret = "81273891-827482194-2481724812"
GitBranchMaster = '*/master'



def UserpassBindings() {
  return {
    wrappers {
      credentialsBinding {
        usernamePassword("ARTIFACTUSER", "ARTIFACTPASSWD", CredentialsSecret)
      }
      timeout {
        absolute(10)
      }
    }
  }
}

def NumLogs() {
  return {
    logRotator {
      numToKeep(5)
    }
  }
}

def CleanWorkSpace() {
  return {
    wrappers {
      preBuildCleanup()
    }
  }
}

def JobOne = freeStyleJob(Job1) {
  publishers {
    description("Some description")
    steps {
      shell('echo "testing 1 2 3"')
    }
  }
}

def JobTwo = freeStyleJob(Job2) {
  publishers {
    description('Some description')
  }
}

JobOne.with NumLogs()
JobOne.with CleanWorkSpace()

JobTwo.with NumLogs()
JobTwo.with CleanWorkSpace()
