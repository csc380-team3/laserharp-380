<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="color-scheme" content="light" />
    <title>LaserHarp</title>
    <style>
      body {
          font-family: sans-serif;
          background: #f5f5f5;
          margin: 0;
          padding: 0;
      }
      .help {
          position: fixed;
          top: 1rem;
          right: 1.25rem;
          width: 28px;
          height: 28px;
          border-radius: 50%;
          border: 2px solid #aaa;
          color: #aaa;
          font-size: 0.95rem;
          font-weight: bold;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: default;
          user-select: none;
      }

      tr {
          height:100%;
      }
      td {
          height:100%;
      }


      .scene-row {
          background: #cccccc;
          padding: 3px 3px 3px 3px;
          width: 100%;
          text-align: center;
          border-radius: 4px;
      }

      .scene-row:hover {
          background: #aaaaaa;
      }


      .card {
          background: #fff;
          border: 1px solid #ddd;
          border-radius: 10px;
          margin:3px 3px 3px 3px;
          padding: 1rem 1rem;
          text-align: center;
          box-shadow: 0 2px 8px rgba(0,0,0,0.07);
          height: 90vh;
      }
      h1 {
          margin: 0 0 0.5rem;
          font-size: 2rem;
      }
      p {
          color: #666;
          margin: 0 0 2rem;
          font-size: 0.95rem;
      }
      a.btn {
          display: inline-block;
          padding: 0.7rem 2rem;
          font-size: 1rem;
          background: #333;
          color: #fff;
          text-decoration: none;
          border-radius: 6px;
      }
      a.btn:hover { background: #555; }
    </style>
    <script>

      function MIDIToNoteName(midi_note){
          if(midi_note < 21)
          {
              return "ERR"
          }
          else
          {
              midi_base = midi_note - 21
              pitch_class = midi_base % 12
              octave = Math.floor(midi_base/12)
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

      function changeScene(scene,number)
      {
          const div_elem = document.getElementById("central-panel")
          scene_values = JSON.parse(scene)

          strout = ""
          
          strout = `
              <center>
              <h1>Scene ${number}</h1>
              <table>
              <tr>
          `;

          strout += "<td> <b> Sensor Number:</b></td>"
        
          scene_values.forEach(function(cur, index, arr){
             strout += `
               <td>
               ${index}
               </td>
             `; 
          });

          strout += "</tr><tr>"
          strout += "<td> <b> MIDI Note:</b></td>"
          scene_values.forEach(function(cur,index,arr){
              
              strout += `
                <td>
                ${MIDIToNoteName(cur)}
                </td>
              `;
          });

          strout += "</tr></table></center>"
          strout += `
            <button onclick="window.location.href = 'scene_edit/${number}'">Configure Scene</button>
          `;
          div_elem.innerHTML = strout
      }
    </script>
  </head>
  <body>
    <table style="width:100%;height:100%">
      <div class="help">?</div>
      <tr style="height:100%;">
        <td style="height:100%;width:200px">
          <div class="card">
            <h1>Scenes</h1>
            <table style="width:100%">
              % for k,scene in enumerate(data):
              <tr style="width:100%">
                <td>
                  <button class="scene-row" onclick="changeScene('{{scene}}', {{k}})">
                  Scene {{k}}
                  </button>
                </td>
              </tr>
              % end
            </table>
          </div>
        </td>
        <td style="height:100%">
          <div class="card" id="central-panel">
            <h1>LaserHarp</h1>
            <p>An interactive laser-based MIDI instrument for live performance.</p>
            <p>Select a scene on the left panel, and the click "Configure Scene" to open the scene editor.</p>
          </div>
        </td>
      </tr>
    </table>
  </body>
</html>
