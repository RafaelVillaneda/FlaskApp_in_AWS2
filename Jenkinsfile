pipeline {
    agent any
    
    environment {
        DOCKER_COMPOSE_VERSION = '3.9'
    }

    stages {
        stage('Clonacion del repositorio') {
            steps {
               checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[credentialsId: 'RafaelVillaneda', url: 'https://github.com/RafaelVillaneda/FlaskApp_in_AWS2.git']])
                git branch: 'main', credentialsId: 'RafaelVillaneda', url: 'https://github.com/RafaelVillaneda/FlaskApp_in_AWS2.git'
            }
        }
        stage('Instalacion de dependencias del proyecto!') {
            steps {
                script {
                    sh 'python3 -m venv venv'
                    sh '. venv/bin/activate'
                    sh './venv/bin/pip install -r requirements.txt'
                }
            }
        }
        stage('Ejecucion de la aplicacion') {
            steps {
                script {
                    sh 'python3 -m venv venv'
                    sh '. venv/bin/activate'
                    sh 'nohup python app.py > output.log 2>&1 & echo $! > pid.file'
                    sh 'sleep 10' // Short initial sleep to give the process a chance to start
                    sh 'cat output.log' // Output the log to the console for debugging
                    sh 'if ! ps -p $(cat pid.file) > /dev/null; then echo "Process not running"; else kill $(cat pid.file); fi'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh """
                        sshpass -p 'REVT2001e' ssh -o StrictHostKeyChecking=no root@143.110.147.110 '
                            echo "Creando y cambiando a la ruta del proyecto" &&
                            cd /home/FlaskApp_in_AWS2 &&
                            echo "Cargando datos desde el github" &&
                            git pull https://RafaelVillaneda:ghp_CaNT3pufhuOtfVzKowEU3bNH10Oziw26wvX@github.com/RafaelVillaneda/FlaskApp_in_AWS2.git &&
                            echo "Levantando servicios de Docker Compose" &&

                            docker stop my-flask-app || true &&
                            docker rm my-flask-app || true &&
                            docker build -t my-flask-app . &&
                            docker run -d -p 8080:80 my-flask-app &&
                           
                            echo "Comandos de ejecucion completados sin errores!"
                        '
                    """
                }
            }
        }




    }
}