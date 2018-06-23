pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh '''#!/bin/bash -l
bundle install'''
        sh '''#!/bin/bash -l
bundle exec fastlane setup'''
      }
    }
    stage('Test') {
      steps {
        sh '''#!/bin/bash -l
bundle exec fastlane test'''
        sh '''#!/bin/bash -l
bundle exec fastlane pod_lint'''
      }
    }
  }
}