pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh '''#!/bin/sh
bundle install'''
        sh '''#!/bin/sh
bundle exec fastlane setup'''
      }
    }
    stage('Test') {
      steps {
        sh 'bundle exec fastlane test'
      }
    }
  }
}