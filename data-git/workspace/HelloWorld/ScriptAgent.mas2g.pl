use "HelloWorldEnvironment-1.2.0.jar" as environment.

define helloWorldAgent as agent {
	use initScriptCounter as init module.
	use printScript as main module.
	use updateScriptCounter as event module.
}

launchpolicy {
	when * launch helloWorldAgent.
}