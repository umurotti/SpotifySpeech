<%-- 
    Document   : newjsp
    Created on : Jun 27, 2019, 5:24:05 PM
    Author     : umur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html><head>
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Audio Recorder</title>

        <script type="text/javascript" src="audiodisplay.js"></script>
        <script type="text/javascript" src="recorder.js"></script>
        <script type="text/javascript" src="main.js"></script>

        <!-- fontawesome -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <style>
            html { overflow: hidden; }
            body { 
                font: 14pt Arial, sans-serif; 
                background: #000000;
                display: flex;
                flex-direction: column;
                height: 100vh;
                width: 100%;
                margin: 0 0;
            }
            canvas { 
                display: inline-block; 
                background: #000000; 
                width: 95%;
                height: 45%;
                /*box-shadow: 0px 0px 30px #0099ff;*/
                /*border: 1px solid #000000;
                border-radius: 15px;*/
                position: relative;
            }
            #controls {
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: space-around;
            }
            #record { height: 15vh; 
                      backface-visibility: hidden;
            }
            #record.recording { 
                background: #0099ff;
                background: -webkit-radial-gradient(center, ellipse cover, #0099ff 0%,black 75%,black 100%,#7db9e8 100%); 
                background: -moz-radial-gradient(center, ellipse cover, #0099ff 0%,black 75%,black 100%,#7db9e8 100%); 
                background: radial-gradient(center, ellipse cover, #0099ff 0%,black 75%,black 100%,#7db9e8 100%);
            }
            #save, #save img { height: 10vh; }
            #save { opacity: 0.25;}
            #save[download] { opacity: 1;}
            #viz {
                height: 80%;
                width: 100%;
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                align-items: center;
                position: relative;
            }
            a {
                border-bottom: 1px solid #453886;
                color: whitesmoke;
                padding-bottom: .25em;
                text-decoration: none;
            }

            a:hover {
                background-image: url("data:image/svg+xml;charset=utf8,%3Csvg id='squiggle-link' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:ev='http://www.w3.org/2001/xml-events' viewBox='0 0 20 4'%3E%3Cstyle type='text/css'%3E.squiggle{animation:shift .3s linear infinite;}@keyframes shift {from {transform:translateX(0);}to {transform:translateX(-20px);}}%3C/style%3E%3Cpath fill='none' stroke='%23453886' stroke-width='2' class='squiggle' d='M0,3.5 c 5,0,5,-3,10,-3 s 5,3,10,3 c 5,0,5,-3,10,-3 s 5,3,10,3'/%3E%3C/svg%3E");
                background-position: bottom;
                background-repeat: repeat-x;
                background-size: 25%;
                border-bottom: 0;
                padding-bottom: .3em;
                text-decoration: none;
                color: #453886;
            }
            @media (orientation: landscape) {
                body { flex-direction: row;}
                #controls { flex-direction: column; height: 10%; width: 100%; /*border: 2px solid #ff00cc;*/ margin-top: 30px;}
                #viz { height: 80%; width: 100%;}
            }

            #myControl {
                height:100%;
                width:100%;
                background-color: #000000;
            }

            .wrapper {
                max-width: 960px; /* 20px smaller, to fit the paddings on the sides */
                max-height: 800px;
                padding-right: 10px;
                padding-left: 10px;
                padding-bottom: 10px;
                padding-top: 10px;
                border-radius: 2px;
                /* ...  */
            }


            /* sebahattin */

            div#myControl {
                width: auto;
                position: absolute;
                height: 60px;
                margin: 0;
                padding: 0;
                /*left: calc((100% - 120px)/2);*/
                right: 60px;
            }

            div#myControl .btn-group button {
                width: 60px;
                height: 40px;
                border-radius: 2px;
                margin-top: 8px;
                text-align: center;
                background: #000;
                border: 1px solid #fff;
                color: #fff;
                cursor: pointer;
                transition: 0.8s;
            }

            div#myControl .btn-group .btn-play:before {
                content: "\f04b";
                font-family: fontAwesome;
                font-size: 18px;
            }

            div#myControl .btn-group .btn-send:before {
                content: "\f1d8";
                font-size: 18px;
                font-family: fontAwesome;
            }

            div#myControl .btn-group button:hover {
                background: #fff;
                color: #000;
            }

            .wrapper {
                width: 70%;
                max-width: 100%;
                margin: 0 auto;
                padding: 0;
                box-shadow: 0 0 8px #E91E63;
                margin-top: 90px;
                height: 500px;
            }

            .wrapper div#viz {
                height: 360px;
            }

            .wrapper #controls img#record {position: absolute;z-index: 2;background: transparent;border: 1px solid #fff;opacity: 0;cursor: pointer;width: 60px;height: 60px;}

            .wrapper #controls:before {
                content: "\f130";
                font-family: fontAwesome;
                color: #fff;
                font-size: 64px;
                cursor: pointer;
                position: absolute;
                z-index: 1;
            }
            div#controls {
                width: 80px;
                margin: 0 auto;
                padding: 11px;
            }

            div#controls:hover:before {
                text-shadow: 0px 0px 30px #ff0000;
            }

            #iframeHolder {
                position: fixed;
                left: 0;
                top: 90px;
            }
            #iframeHolder iframe {
                width: 283px;
                height: 500px;
            }

        </style>
    </head>
    <body>
        <div class="wrapper">
            <div id="viz" >
                <canvas id="analyser" width="1024" height="500"></canvas>
                <canvas id="wavedisplay" width="1024" height="500"></canvas>
            </div>
            <div id="controls" style="background-color: #000000; position: relative">
                <!-- <img id="record" src="mic128.png" onclick="toggleRecording(this);" class=""> -->
                <img id="record" src="mic128.png" onmouseover="toggleRecording(this);" onmouseleave="toggleRecording(this);">
                <!--<a id="save" href="blob:https://webaudiodemos.appspot.com/61248dcf-4962-4f61-8dc4-5a9bd5540813" download="myRecording00.wav"><img src="img/save.svg"></a>-->
            </div>
        </div>
        <div id="myControl">
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
            <!--
            <div class="btn-group">
                <button class="btn-play" id="button"></button>
                <button class="btn-send" type="button" onclick="func1()"></button>
                <!-- <button>Sony</button> 
                
            </div> 
            -->
            <!--<button id="button">PLAY</button>-->
            <div id="iframeHolder"></div>


            <div>
                <a href="CacheStat.jsp" >Cache Statistics</a>
            </div>

        </div>

        <!--<button type="button" onclick="func1()">Send</button>-->
        <script>
            /*
             $.myJquery = $(function () {
             $('#button').click(function () {
             if (!$('#iframe').length) {
             $('#iframeHolder').html('<iframe id="alow" width="480" height="620" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>');
             document.getElementById("alow").src = "https://open.spotify.com/embed/" + out;
             }
             });
             });
             */
        </script>

        <div>
            <script>
                var out;

                function sendAudio(d) {
                    //fileReader.onload = function () {
                    //    arrayBuffer = this.result;
                    //    byteArray = new Uint8Array(arrayBuffer);
                    debugger;
                    console.log(d);

                    //var byteArray;
                    //var fileReader = new FileReader();
                    //fileReader.onload = function () {
                    //    arrayBuffer = this.result;
                    //    byteArray = new Uint8Array(arrayBuffer);
                    //    console.log("in");
                    //};
                    //var arrayBuffer = new Response(d).arrayBuffer();

                    //arrayBuffer.then(function (value) {
                    //window.soundBite = new Uint8Array(value);  // expected output: "foo"
                    //function _arrayBufferToBase64( value ) {
                    //var binary = '';
                    //var bytes = new Uint8Array( value );
                    //var bytes = window.soundBite;
                    //var len = bytes.byteLength;
                    //for (var i = 0; i < len; i++) {
                    //  binary += String.fromCharCode( bytes[ i ] );
                    //}
                    //  return window.btoa( binary );
                    //}
                    //var base64 = bufferToBase64(window.soundBite);
                    //var x = _arrayBufferToBase64(value);
                    var reader = new FileReader();
                    var base64data;



                    reader.onloadend = function () {
                        /*
                         var newAud = new Audio(base64data);//("data:audio/wav;base64," + x);
                         newAud.play();
                         */
                        base64data = reader.result.replace(/^data:.+;base64,/, '');
                        console.log(base64data);
                        console.log(base64data);
                        var xhttp5 = new XMLHttpRequest();
                        xhttp5.onreadystatechange = function () {
                            if (this.readyState == 4 && (this.status == 200)) {
                                console.log("inside");

                                var obj = JSON.parse(this.responseText);
                                console.log(this.responseText);
                                if (Object.keys(obj)[0] == "tracks") {
                                    out = "track/" + obj.tracks.items[0].id;
                                    console.log("Track: " + out);
                                } else if (Object.keys(obj)[0] == "artists") {
                                    out = "artist/" + obj.artists.items[0].id;
                                    console.log("Artist: " + out);
                                } else if (Object.keys(obj)[0] == "playlists") {
                                    out = "playlist/" + obj.playlists.items[0].id;
                                    console.log("Playlist: " + out);
                                } else {
                                    console.log("Unsupported Type: ")
                                }
                                console.log(out);

                                if (!$('#iframe').length) {
                                    $('#iframeHolder').html('<iframe id="alow" width="480" height="620" frameborder="0" allowtransparency="true" allow="encrypted-media"></iframe>');
                                    document.getElementById("alow").src = "https://open.spotify.com/embed/" + out;
                                }
                            } else if (this.readyState == 4 && this.status == 500) {
                                alert("INTERNAL_SERVER_ERROR: Please try again");
                            }

                        };
                        var urlParams = new URLSearchParams(JSON.parse(window.sessionStorage.spotifyReply));
                        //urlParams.get('access_token');
                        var pageUrl = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname.split('/')[1] + "/api/SpotifyServices/query64";
                        console.log(urlParams);
                        console.log(urlParams.get('access_token'));


                        xhttp5.open("POST", pageUrl);
                        xhttp5.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        //console.log(x);
                        var base64toserver = encodeURIComponent(base64data);
                        xhttp5.send("token=" + urlParams.get('access_token') + "&base64=" + base64toserver);
                        //XHR.send({token: window.spotifyReply, })
                    };
                    reader.readAsDataURL(d);
                }



                //console.log(arrayBuffer);
                //fileReader.readAsArrayBuffer(data);
                //var curBuffer = new Buffer( data, 'binary' );
                //console.log(curBuffer);
                //
                //console.log(byteArray);
                //var byteArray = new Uint8Array(arrayBuffer);
                //console.log(byteArray);


                function func1() {

                    window.audioRecorder.exportMonoWAV(sendAudio);



                    //arrayBuffer = new Response(data.slice()).arrayBuffer();
                    //console.log(arrayBuffer.byteLength);
                    //window.audioRecorder.exportWAV(x);
                    //ÇALIŞMIYORconsole.log(data);
                    //arrayBuffer = await new Response(data).arrayBuffer();
                }
            </script>

        </div>
    </body></html>
