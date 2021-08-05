pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                sh 'rm -rf .git'
                sh "sed -i 's/Distribution/Jenkins - Pipeline/' index.html"
                withCredentials([sshUserPrivateKey(credentialsId: 'jenkins', keyFileVariable: 'keyfile', passphraseVariable: '', usernameVariable: 'username')]) {
                    script {
                        [100, 200].each {
                            sh "scp -i ${keyfile} -r $WORKSPACE ${username}@172.27.11.${it}:/tmp/html"
                            distro = sh(returnStdout: true, script: "ssh -i ${keyfile} ${username}@172.27.11.${it} '. /etc/os-release && echo -n \$ID'")
                            user = distro == 'debian' ? 'www-data' : 'lighttpd'
                            sh "ssh -i ${keyfile} ${username}@172.27.11.${it} 'sudo rsync --delete --chown=${user}:${user} -rog /tmp/html /srv/www'"
                        }
                    }
                }
            }
        }
        stage('Clean') {
            steps {
                cleanWs()
            }
        }
    }
}
