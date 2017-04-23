# Playlist Service

## Decomposing complex rails applications

http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

## Delete all unused data

    docker system prune

## Clean up dangling images

    docker images -qf dangling=true | xargs docker rmi

## Use the Minikube environment for the Docker toolbox

This will allow you to build and use images in the Minikube context. I.e. you
can test out images locally instead of uploading them to a remote registry.

    eval $(minikube docker-env)

## Debuging minikube addons

    get pods --all-namespaces
    minikube addons list
    kubectl cluster-info

## Build image

Build the docker image. Note, anytime the Gemfile is updated we'll want to
rebuild this image.

    docker build -t Crossvader/playlist:latest .

## Create, list, delete, etc. resources with Kubernetes

    kubectl {create,get,delete,describe,rollout,etc} -Rf k8s/development

## Migrate database

    kubectl exec POD_NAME bundle exec rake db:create db:migrate

## Open application

    minikube service playlist-service

## Verify app is running

    Tail the log to ensure the rails app server is running.

        kubectl logs -f POD_NAME

    The following command should return a JSON response from the app:

        curl $(minikube service playlist-service --url)/v1/playlists

## Elasticsearch

 * https://github.com/elastic/elasticsearch-rails
 * https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model
