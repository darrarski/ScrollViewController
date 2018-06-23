pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh 'bundle install'
        sh 'bundle exec fastlane setup'
      }
    }
    stage('Test') {
      steps {
        sh 'bundle exec fastlane test'
      }
    }
  }
}