#!/usr/bin/env groovy

import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

node{

    stage ('pull code'){
      git credentialsId: 'KirshBitbucket', url: 'https://Kirshbitbucket@bitbucket.org/Kirshbitbucket/mobileapp.git'
    }

    stage ('gulp'){
      sh label: '', script: '''

      npm cache clean --force
      sudo rm -rf node_modules
      sudo npm install
      sudo npm run setConfig'''
    }

    stage ('Lint: Syntax Testing'){
      sh label: '', script: '''
        npm cache clean --force
        rm -rf node_modules
        sudo npm install
        sudo npm run lint'''
    }

    stage ('Jest: test using jest'){
      sh label: '', script: '''
        npm cache clean --force
        rm -rf node_modules
        sudo npm install
        sudo npm run test -- -u'''
    }

    stage ('Adding Keystore'){
      sh label: '', script: '''
        sudo cp -R /root/bizgo.keystore /var/lib/jenkins/workspace/ci/android/app
        '''
    }

    stage ('Build: Android'){
      sh label: '', script: '''
        npm cache clean --force
        sudo cp -R /root/local.properties /var/lib/jenkins/workspace/ci/android/
        sudo npm install
        sudo npm run build:android'''
    }
}
