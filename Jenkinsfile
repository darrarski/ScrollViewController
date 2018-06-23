pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh '''#!/bin/bash -xl
whoami
which rvm
which bundle'''
        sh '''#!/bin/bash -xl
bundle install'''
        sh '''#!/bin/bash -xl
bundle exec fastlane setup'''
      }
    }
    stage('Test') {
      steps {
        sh '''#!/bin/bash -xl
bundle exec fastlane test'''
      }
    }
  }
}