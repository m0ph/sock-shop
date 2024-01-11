pipeline {
    environment {
        DOCKER_ID = "m0ph"
        DOCKER_IMAGE_CARTS = "carts"
        DOCKER_IMAGE_CATALOGUE = "catalogue"
        DOCKER_IMAGE_CATALOGUE_DB = "catalogue-db"
        DOCKER_IMAGE_FRONT_END = "front-end"
        DOCKER_IMAGE_ORDERS = "orders"
        DOCKER_IMAGE_PAYMENT = "payment"
        DOCKER_IMAGE_QUEUE = "queue-master"
        DOCKER_IMAGE_SHIPPING = "shipping"
        DOCKER_IMAGE_USER = "user"
        DOCKER_IMAGE_USER_DB = "user-db"
        DOCKER_TAG = "${BUILD_ID}"
        BUILD_AGENT  = ""
    }
agent any
    stages {
        stage('Build') {
            steps { //create a loop somehow??
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_CARTS:$DOCKER_TAG ./microservices/carts'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:$DOCKER_TAG ./microservices/catalogue'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:$DOCKER_TAG ./microservices/catalogue-db'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:$DOCKER_TAG ./microservices/front-end'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_ORDERS:$DOCKER_TAG ./microservices/orders'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:$DOCKER_TAG ./microservices/payment'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_QUEUE:$DOCKER_TAG ./microservices/queue-master'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:$DOCKER_TAG ./microservices/shipping'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_USER:$DOCKER_TAG ./microservices/user'
                sh 'docker build -t $DOCKER_ID/$DOCKER_IMAGE_USER_DB:$DOCKER_TAG ./microservices/user-db'
            }
        }
        stage('Run') {
            steps {
                sh 'docker network create $BUILD_TAG'
                sh 'docker run -d --name $DOCKER_IMAGE_CARTS --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_CARTS:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_CARTS'
                sh 'docker run -d --name $DOCKER_IMAGE_CATALOGUE --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_CATALOGUE'
                sh 'docker run -d --name $DOCKER_IMAGE_CATALOGUE_DB --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_CATALOGUE_DB'
                sh 'docker run -d --name $DOCKER_IMAGE_FRONT_END --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_FRONT_END'
                sh 'docker run -d --name $DOCKER_IMAGE_ORDERS --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_ORDERS:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_ORDERS'
                sh 'docker run -d --name $DOCKER_IMAGE_PAYMENT --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_PAYMENT'
                sh 'docker run -d --name $DOCKER_IMAGE_QUEUE --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_QUEUE:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_QUEUE'
                sh 'docker run -d --name $DOCKER_IMAGE_SHIPPING --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_SHIPPING'
                sh 'docker run -d --name $DOCKER_IMAGE_USER --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_USER:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop $DOCKER_IMAGE_USER'
                sh 'docker run -d --name $DOCKER_IMAGE_USER_DB --rm --network $BUILD_TAG $DOCKER_ID/$DOCKER_IMAGE_USER_DB:$DOCKER_TAG'
                sh 'sleep 5'
                sh 'docker stop  $DOCKER_IMAGE_USER_DB'
                sh 'docker network rm $BUILD_TAG'
            }
        }
        stage('Push') {
            environment {
                DOCKER_PASS = credentials("DOCKER_HUB_PASS")
            }
            steps {
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_CARTS:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_CARTS:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_ORDERS:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_ORDERS:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_QUEUE:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_QUEUE:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_USER:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_USER:latest'
                sh 'docker image tag $DOCKER_ID/$DOCKER_IMAGE_USER_DB:$DOCKER_TAG $DOCKER_ID/$DOCKER_IMAGE_USER_DB:latest'
                sh 'docker login -u $DOCKER_ID -p $DOCKER_PASS'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_CARTS:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_CARTS:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_CATALOGUE_DB:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_FRONT_END:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_ORDERS:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_ORDERS:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_PAYMENT:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_QUEUE:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_QUEUE:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_SHIPPING:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_USER:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_USER:latest'
                sh 'docker push $DOCKER_ID/$DOCKER_IMAGE_USER_DB:$DOCKER_TAG && docker push $DOCKER_ID/$DOCKER_IMAGE_USER_DB:latest'
            }
        }
        stage('Deploy VPS') {
            environment {
                KUBECONFIG = credentials("VPS_KUBE_CONFIG")
            }
            steps{
                sh 'rm -Rf .kube'
                sh 'mkdir .kube'
                sh 'cat $KUBECONFIG > .kube/config'
                sh 'kubectl apply -f'
            }
            

        }
    }
}