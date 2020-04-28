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

    stage ('Bundle-Dev'){
      sh label: '', script: '''

      ./bundle-dev.sh'''
    }

    stage ('Ship-To-Dev'){
      sh label: '', script: '''

      ./ship-to-dev.sh
      '''
    }

    stage ('Stop-Server'){
      sh label: '', script: '''

      ./stop-server.sh
      '''
    }

    stage ('Deploy-Server'){
      sh label: '', script: '''

      ./deploy_dev.sh
      '''
    }

    stage ('Start-Server'){
      sh label: '', script: '''

      ./start-server.sh
      '''
    }
