# SpotifySpeech
Search items on Spotify by voice

### Give it a try...
[Go to app -->](http://ec2-18-184-251-229.eu-central-1.compute.amazonaws.com:8080/SpotifySpeech-1.0-SNAPSHOT)

How to use:

* Move your your mouse over the microphone icon
* Until the mouse moves out of icon borders application records the audio
* When mouse is moved out of icon it it sends the request and shows the response accordingly

</br>(If the application does not recording voice or showing a blank black page please see Significant Release Notes)

</br>What to say:</br>
<-command->     <-keyType-(choose one)->        <-item->

</br>Available Commands on Latest Version:
* Play

Available keyTypes on Latest Version:
* Track
* Artist
* Playlist


</br>e.g. __read the italic part as clearly as possible__ _"Play Artist Pink Floyd"_
</br>(be sure to give short breaks after each word)

## Deployment
Deployed on [Amazon AWS](https://aws.amazon.com/) remote machine using [Apache TOMCAT](http://tomcat.apache.org/)

## Significant Release Notes
* First level LRU Cache has still size of maximum 2 elements for some test issues about LRU policy
* Suported Languages: English
* Current release works properly on Firefox web browser, if the browser does not record your voice please try again with a Firefox window

## Built With

* [Spotıfy Web API](https://developer.spotify.com/documentation/web-api/) - Search item and get results as JSON
* [LRU Cache](https://github.com/umurotti/Caching) - First level cache
* [Maven](https://maven.apache.org/) - Dependency Management
* [Google Speech-to-Text API](https://cloud.google.com/speech-to-text/) - Convert voice to String elements ([see custom implementation](https://github.com/umurotti/GoogleSpeecToTextAPI))
* [Redis](https://redis.io/) - Storing search results as a second level cache
* [JAX-RS API](https://github.com/jax-rs) - Standardization for RESTful Web Services
* [Swagger UI](https://swagger.io/) - Open Source Web API interface
* [NetBeans](https://netbeans.org/) - What a lovely IDE...
* [Strategy Deisgn Pattern](http://www.cs.unc.edu/~stotts/GOF/hires/pat5ifso.htm) - Dynamical runtime response based on request parameters
* [Base64](https://base64.guru/learn/what-is-base64) - Send voice message as request paramter

## Contributing

Please contact me for contributiion at umur.gogebakan@ug.bilkent.edu.tr

## Versioning

Currently not following any versioning standart

## Authors

* **Umur Göğebakan** - [umurotti](https://github.com/umurotti)
* **Ferhat Savcı** - [LinkedIn](https://tr.linkedin.com/in/ferhat-savc%C4%B1-b725ba28)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is currently not under anyone's license.

## Future-Work

* Creating a mobile interface
* Adding new commands
* Improving search results
* Complete Listen-Search-Play cycle without any need of further interaction with the user

### This project is supported by [Cybersoft](http://www.cs.com.tr/TR/)
