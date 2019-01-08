#!groovy

@Library('MicroserviceBuilder') _
microserviceBuilderPipeline {
  image = 'ibmcom/ace'
  registry = 'mycluster.icp:8500/default'
  chartFolder="ace-helm-master/ibm-ace-dev-for-microclimate"
  namespace='default'
}
