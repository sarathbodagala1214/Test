version: "1.0"
# Stages can help you organize your steps in stages
stages:
  - "clone"
  - "build"
  - "test"
  - "push"

steps:
  clone:
    title: "Cloningrepository"
    type: "git-clone"
    repo: "sarathbodagala1214/Test"
    # CF_BRANCH value is auto set when pipeline is triggered
    # Learn more at codefresh.io/docs/docs/codefresh-yaml/variables/
    revision: "${{CF_BRANCH}}"
    git: "github"
    stage: "clone"

  build:
    title: "Building Docker image"
    type: "build"
    image_name: "sarath/docker"
    working_directory: "${{clone}}"
    tag: "${{CF_BRANCH_TAG_NORMALIZED}}"
    # If you have a Dockerfile in the repo you can use
    # dockerfile: 'Dockerfile'
    dockerfile: Dockerfile
    stage: "build"

  test:
    title: "Running test"
    type: "freestyle" # Run any command
    image: "docker:latest" # The image in which command will be executed
    working_directory: "${{clone}}" # Running command where code cloned
    commands:
      - "ls"
    stage: "test"

  push:
      stage: 'push'
      type: push
      title: Pushing to a registry
      candidate: ${{build}}
      tag: 'latest'
      registry: docker
      image_name: sarath/docker
