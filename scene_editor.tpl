<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sensor Binder</title>
    <style>
        /*Page layout*/

        body {
            background: rgb(127, 133, 140);
            color: white;
            font-family: Arial, Helvetica, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px;

        }

        h1 {

            font-size: 20px;
            margin-bottom: 20px;
            color: #e0e0e0;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 50px;
            width: 100%;
            max-width: 100vw;
        }

        /*sensor list*/
        .sensor-list {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            gap: 10px;
            min-width: 180px;
        }

        .sensor {
            background: #2c2f33;
            border: 2px solid #444;
            padding: 10px 14px;
            border-radius: 8px;
            cursor: pointer;
            transition: border-color 0.2s;
        }

        .sensor:hover {
            border-color: #7289da;
        }

        .sensor.selected {
            border-color: purple;
            background: #2a0a0a;
        }

        .sensor .sensor-name {
            font-size: 14px;
            font-weight: bold;
        }

        .sensor .sensor-note {
            font-size: 12px;
            color: #aaa;
            margin-top: 4px;
        }

        /*Piano Wrapper*/

        .piano-wrapper {
            width: 100%;
            overflow-x: auto;
            padding-bottom: 20px;
            text-align: center;
            display: block;
        }

        /*keyboard*/
        .piano {
            display: flex;
            position: relative;
            height: 300px;
            width: max-content;
            margin: 0 auto;
        }

        /*white keys*/

        .key {
            width: 60px;
            min-width: 60px;
            flex-shrink: 0;
            height: 300px;
            background: white;
            border: 1px solid #333;
            border-radius: 0 0 5px 5px;
            position: relative;
            cursor: pointer;
            transition: background 0.1s;
        }

        .key:hover {
            background: #c6aeae;
        }

        .key.active {
            background: rebeccapurple;
        }

        .key .note-label {
            position: absolute;
            bottom: 5px;
            left: 50%;
            text-align: center;
            transform: translateX(-50%);
            font-size: 9px;
            color: #333;
        }

        /*black keys*/
	.key, .key.black {
    	box-sizing: border-box;
	}
        .key.black {
            width: 40px;
	    min-width: 40px;
            height: 180px;
            background: black;
            position: absolute;
            top: 0;
            z-index: 2;
            border-radius: 0 0 4px 4px;
	    box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4);
        }

        .key.black:hover {
            background: gray;
        }

        .key.black.active {
            background: rebeccapurple;
        }

        .note-labels {
            display: flex;
            margin-top: 8px;
            gap: 0px;
        }

        .note-lable-below {
            width: 36px;
            text-align: center;
            font-size: 10px;
            color: #aaa;
        }

        /*status display*/
        .status {
            margin-top: 16px;
            font-size: 14px;
            color: whitesmoke;
            min-height: 20px;
        }

        /*Go back button*/
         .bottom-bar {
           display: flex;
           justify-content: space-between;
           align-items: center;
           width: 100%;
           margin-top: 10px;
        }

       .btn {
            padding: 8px 18px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-back { background: #444; color: white; }
        .btn-back:hover { background: #666; }
        btn-back { background: #444; color: white; }
        .btn-back:hover { background: #666; }
    </style>
</head>

<body>

    <h1>Sensor Binder</h1>

    <div class="container">

        <!-- SENSOR LIST -->
        <div class="sensor-list" id="sensorList">
            <div class="sensor" data-sensor="1">
                <div class="sensor-name">Sensor 1</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="2">
                <div class="sensor-name">Sensor 2</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="3">
                <div class="sensor-name">Sensor 3</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="4">
                <div class="sensor-name">Sensor 4</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="5">
                <div class="sensor-name">Sensor 5</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="6">
                <div class="sensor-name">Sensor 6</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="7">
                <div class="sensor-name">Sensor 7</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="8">
                <div class="sensor-name">Sensor 8</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="9">
                <div class="sensor-name">Sensor 9</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="10">
                <div class="sensor-name">Sensor 10</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="11">
                <div class="sensor-name">Sensor 11</div>
                <div class="sensor-note">No note bound</div>
            </div>
            <div class="sensor" data-sensor="12">
                <div class="sensor-name">Sensor 12</div>
                <div class="sensor-note">No note bound</div>
            </div>

        </div>


        <!-- PIANO -->
        <div class="piano-wrapper">
            <div class="piano" id="piano"></div>
            <div class="status" id="status">Click a sensor to start binding</div>
        </div>
        </div>

        <div class="bottom-bar">
            <a class="btn btn-back" href="/">← Go Back</a>
        </div>

    <!-- Play real piano audio samples when a key is clicked -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tone/14.8.49/Tone.js"></script>
    <script>
        const sampler = new Tone.Sampler({
            urls: {
                "A0": "A0.mp3", "C1": "C1.mp3", "D#1": "Ds1.mp3",
                "F#1": "Fs1.mp3", "A1": "A1.mp3", "C2": "C2.mp3",
                "D#2": "Ds2.mp3", "F#2": "Fs2.mp3", "A2": "A2.mp3",
                "C3": "C3.mp3", "D#3": "Ds3.mp3", "F#3": "Fs3.mp3",
                "A3": "A3.mp3", "C4": "C4.mp3", "D#4": "Ds4.mp3",
                "F#4": "Fs4.mp3", "A4": "A4.mp3", "C5": "C5.mp3",
                "D#5": "Ds5.mp3", "F#5": "Fs5.mp3", "A5": "A5.mp3",
                "C6": "C6.mp3", "D#6": "Ds6.mp3", "F#6": "Fs6.mp3",
                "A7": "A7.mp3", "C8": "C8.mp3"
            },
            baseUrl: "https://tonejs.github.io/audio/salamander/",
        }).toDestination();

        const playTune = (note) => {
            Tone.start().then(() => {
                sampler.triggerAttackRelease(note, "2n");
            });
        }
    </script>
    <script>

        const whiteNotes = [
            "A0", "B0", "C1", "D1", "E1", "F1", "G1", "A1", "B1", "C2", "D2", "E2", "F2",
            "G2", "A2", "B2", "C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4",
            "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5", "C6", "D6",
            "E6", "F6", "G6", "A6", "B6", "C7", "D7", "E7", "F7", "G7", "A7", "B7", "C8"
        ];


        const blackKeys = [
            { note: "A#0", after: 0 },

            // Octave 1
            { note: "C#1", after: 2 }, { note: "D#1", after: 3 },
            { note: "F#1", after: 5 }, { note: "G#1", after: 6 }, { note: "A#1", after: 7 },

            // Octave 2
            { note: "C#2", after: 9 }, { note: "D#2", after: 10 },
            { note: "F#2", after: 12 }, { note: "G#2", after: 13 }, { note: "A#2", after: 14 },

            // Octave 3
            { note: "C#3", after: 16 }, { note: "D#3", after: 17 },
            { note: "F#3", after: 19 }, { note: "G#3", after: 20 }, { note: "A#3", after: 21 },

            // Octave 4
            { note: "C#4", after: 23 }, { note: "D#4", after: 24 },
            { note: "F#4", after: 26 }, { note: "G#4", after: 27 }, { note: "A#4", after: 28 },

            // Octave 5
            { note: "C#5", after: 30 }, { note: "D#5", after: 31 },
            { note: "F#5", after: 33 }, { note: "G#5", after: 34 }, { note: "A#5", after: 35 },

            // Octave 6
            { note: "C#6", after: 37 }, { note: "D#6", after: 38 },
            { note: "F#6", after: 40 }, { note: "G#6", after: 41 }, { note: "A#6", after: 42 },

            // Octave 7
            { note: "C#7", after: 44 }, { note: "D#7", after: 45 },
            { note: "F#7", after: 47 }, { note: "G#7", after: 48 }, { note: "A#7", after: 49 }
        ];


        const piano = document.getElementById("piano");
        const status = document.getElementById("status");
        let selectedSensor = null;// sensor that is currently selected


        //creating white keys

        whiteNotes.forEach((note, i) => {
            const key = document.createElement("div");
            key.classList.add("key");
            key.dataset.note = note;

            //note lable for the key

            const label = document.createElement("span");
            label.classList.add("note-label");
            label.textContent = note;
            key.appendChild(label);

            key.addEventListener('click', () => {
                playTune(note); // play note on white key click
                bindNote(note, key)
            });
            piano.appendChild(key);
        });


        //creating black keys


        const whiteKeyWidth = document.querySelector('.key').offsetWidth;
	const blackKeyWidth = 40;
        blackKeys.forEach(({ note, after }) => {

            const key = document.createElement("div");
            key.classList.add("key", "black");
            key.dataset.note = note;


            //placing inbetween white keys
	    const crackPosition = (after + 1) * whiteKeyWidth;
            key.style.left = (after * whiteKeyWidth + whiteKeyWidth * 0.65) + "px";

            key.addEventListener("click", (e) => {
                e.stopPropagation(); // restricting trigger of white key behind it
                playTune(note); // play note on black key click
                bindNote(note, key);              
            });
            piano.appendChild(key);
        });


        //sensor slector

        document.querySelectorAll(".sensor").forEach(sensor => {
            sensor.addEventListener("click", () => {
                // Deselect previously selected
                document.querySelectorAll(".sensor").forEach(s => s.classList.remove("selected"));
                sensor.classList.add("selected");
                selectedSensor = sensor;
                status.textContent = "Sensor " + sensor.dataset.sensor + " selected — Click a piano key";
            });
        });




	//binding function
        function bindNote(note, keyElement) {
            if (!selectedSensor) {
                status.textContent = "Please select a sensor first.";
                return;
            }

	     const sensorId = selectedSensor.dataset.sensor - 1;
    	     const sceneId = window.location.pathname.split('/').pop();;

	     const noteAsInt = noteToMidi(note);

	    fetch(`/bind/${sceneId}/${sensorId}/${noteAsInt }`)
        	.then(response => {
            //update the sensor's note display
	    	selectedSensor.querySelector(".sensor-note").textContent = `Note: ${note}`;

            //highlight the bound key

            	document.querySelectorAll(".key").forEach(k => k.classList.remove("active"));
            	keyElement.classList.add("active");
            	status.textContent = "Bound " + note + " to Sensor " + selectedSensor.dataset.sensor;

            //deselect sensor after binding
            	selectedSensor.classList.remove("selected");
            	selectedSensor = null;
	    })
        }
	//Our python backend expects an int. Convert the piano note to a int.
	function noteToMidi(noteString) {
            const noteMap = { 'C': 0, 'C#': 1, 'D': 2, 'D#': 3, 'E': 4, 'F': 5, 'F#': 6, 'G': 7, 'G#': 8, 'A': 9, 'A#': 10, 'B': 11 };
            const octave = parseInt(noteString.slice(-1));
            const note = noteString.slice(0, -1);          
            return noteMap[note] + (octave + 1) * 12;
	}

	function MIDIToNoteName(midi_note){
          if(midi_note < 21)
          {
              return "ERR"
          }
          else
          {
              midi_base = midi_note - 21
              pitch_class = midi_base % 12
              octave = Math.floor(midi_base/12)+1
	      if (pitch_class === 0 || pitch_class === 1 || pitch_class === 2) {
                    octave -= 1;
                }
              note = ""
              switch(pitch_class)
              {
                  case 0:
                  note = "A"
                  break;
                  case 1:
                  note = "A#"
                  break;
                  case 2:
                  note = "B"
                  break;
                  case 3:
                  note = "C"
                  break;
                  case 4:
                  note = "C#"
                  break;
                  case 5:
                  note = "D"
                  break;
                  case 6:
                  note = "D#"
                  break;
                  case 7:
                  note = "E"
                  break;
                  case 8:
                  note = "F"
                  break;
                  case 9:
                  note = "F#"
                  break;
                  case 10:
                  note = "G"
                  break;
                  case 11:
                  note = "G#"
                  break;
              }
              return "" + note + "" + octave
          }
      }
	const sceneData = {{ scene_data }}; 

        window.onload = () => {
            document.querySelectorAll(".sensor").forEach((sensor, index) => {
                const savedMidi = sceneData[index];
                
                if (savedMidi && savedMidi !== 0) { 
                    const noteString = MIDIToNoteName(savedMidi);
                    if (noteString !== "ERR") {
                        sensor.querySelector(".sensor-note").textContent = `Note: ${noteString}`;
                    }
                }
            });
        };



    </script>


</body>

</html>