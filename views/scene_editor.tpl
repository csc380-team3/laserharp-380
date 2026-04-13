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
            gap: 40px;
            align-items: flex-start;
        }

        /*sensor list*/
        .sensor-list {
            display: flex;
            flex-direction: column;
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
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /*keyboard*/
        .piano {
            display: flex;
            position: relative;
            height: 300px;
        }

        /*white keys*/

        .key {
            width: 60px;
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
        .key.black {
            width: 40px;
            height: 190px;
            background: black;
            position: absolute;
            top: 0;
            z-index: 2;
            border-radius: 0 0 6px 6px;
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

        </div>

        <!-- PIANO -->
        <div class="piano-wrapper">
            <div class="piano" id="piano"></div>
            <div class="status" id="status">Click a sensor to start binding</div>
        </div>
    </div>


    <script>

        const whiteNotes = [
            "C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4", "F4",
            "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5"
        ];


        const blackKeys = [
            { note: "C#3", after: 0 }, { note: "D#3", after: 1 },
            { note: "F#3", after: 3 }, { note: "G#3", after: 4 }, { note: "A#3", after: 5 },
            { note: "C#4", after: 7 }, { note: "D#4", after: 8 },
            { note: "F#4", after: 10 }, { note: "G#4", after: 11 }, { note: "A#4", after: 12 },
            { note: "C#5", after: 14 }, { note: "D#5", after: 15 },
            { note: "F#5", after: 17 }, { note: "G#5", after: 18 }, { note: "A#5", after: 19 },
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

            key.addEventListener('click', () => bindNote(note, key));
            piano.appendChild(key);

        });

       //creating black keys
        const whiteKeyWidth = 60;
        blackKeys.forEach(({ note, after }) => {

            const key = document.createElement("div");
            key.classList.add("key", "black");
            key.dataset.note = note;


            //placing inbetween white keys
            key.style.left = (after * whiteKeyWidth + whiteKeyWidth * 0.65) + "px";

            key.addEventListener("click", (e) => {
                e.stopPropagation(); // restricting trigger of white key behind it
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

            //update the sensor's note display


            selectedSensor.querySelector(".sensor-note").textContent = `Note: ${note}`;



            //highlight the bound key

            document.querySelectorAll(".key").forEach(k => k.classList.remove("active"));
            keyElement.classList.add("active");
            status.textContent = "Bound " + note + " to Sensor " + selectedSensor.dataset.sensor;

            //deselect sensor after binding
            selectedSensor.classList.remove("selected");
            selectedSensor = null;
        }

    </script>
</body>

</html>
