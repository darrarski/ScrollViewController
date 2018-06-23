pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh '''#!/bin/bash -l
bundle install --jobs=3 --retry=3 --deployment'''
        sh '''#!/bin/bash -l
bundle exec fastlane setup'''
      }
    }
    stage('Test') {
      steps {
        sh '''#!/bin/bash -l
bundle exec fastlane codeclimate_before_build'''
        sh '''#!/bin/bash -l
bundle exec fastlane test'''
        sh '''#!/bin/bash -l
bundle exec fastlane coverage_xml'''
        sh '''#!/bin/bash -l
bundle exec fastlane codeclimate_after_build'''
        sh '''#!/bin/bash -l
bundle exec fastlane pod_lint'''
      }
    }
  }
}