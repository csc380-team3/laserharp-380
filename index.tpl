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
      .help-tooltip {
         display: none;
         position: fixed;
         top: 3rem;
         right: 1.25rem;
         background: white;
         border: 1px solid #ccc;
         border-radius: 8px;
         padding: 12px 16px;
         width: 280px;
         font-size: 0.85rem;
         color: #333;
         box-shadow: 0 2px 8px rgba(0,0,0,0.15);
         z-index: 999;
     }

     .help:hover + .help-tooltip,
     .help-tooltip:hover {
        display: block;
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
      .scene-row.active {
      background: #333;
      color: white;
      }

      /*delete option for scene*/
      .scene-lable{
          flex:1;
          text-align: center;
      }
      
      .delete-btn {
          background: none;
          color: #888;
          border: none;
          font-size: 14px;
          padding: 0 4px;
          cursor: pointer;
          inline-height: 1;
      }

      .delete-btn:hover {
          color: #f00;
      }

      .scene-row.active .delete-btn {
          color: #fff;
      }

      .scene-row.active .delete-btn:hover {
          color: #f00;
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
      a.btn.disabled {
          background: #aaa;
          pointer-events: none;
      }

       /*add new scene button*/
      .add-btn {
          display: inline-block;
          width:100%;
          margin-top: 10px;
          padding: 6px 0;
          background: #eee;
          border: 1px dashed #aaa;
          bordeer-radius: 4px;
          font-size: 0.9rem;
          color: #555;
          cursor: pointer;
          text-align: center;
      }
      .add-btn:hover {
          background: #ddd;
          color: #333;
      }
          
    </style>
  </head>
  <body>
    <table style="width:100%;height:100%">
      <div class="help">?</div>
    <div class="help-tooltip">
        <strong>How to use:</strong><br><br>
        • Click a scene to edit it<br>
        • Click + Add Scene to create a new one<br>
        • Click ✕ to delete a scene
    </div>
      <tr style="height:100%;">
        <td style="height:100%;width:200px">
          <div class="card">
            <h1>Scenes</h1>
            <table id="sceneTable" style="width:100%; border-collapse: separate; border-spacing: 0 8px;">
             % for i in range(len(data)):
             <tr style="width:100%">
            	<td class="scene-row" onclick="selectScene({{ i }}, this)">
            	 Scene {{ i + 1 }}
               <button class="delete-btn" onclick="removeScene(event, {{ i }})">&#x2715;</button>
            	</td>
             </tr>
            % end
            </table>
            <button class="add-btn" onclick="addScene()">+ Add Scene</button>
          </div>
        </td>
        <td style="height:100%">
          <div class="card">
            <h1>LaserHarp</h1>
            <p>An interactive laser-based MIDI instrument for live performance.</p>
          </div>
        </td>
      </tr>
    </table>
    <script>
      let currentScene = null;
      function selectScene(index, element) {
          window.location.href = '/scene_edit/' + index;
      }

      function removeScene(event, index) {
         event.stopPropagation();
         if (!confirm(`Delete Scene ${index + 1}? This cannot be undone.`)) return;
         fetch(`/remove_scene/${index}`)
         .then(res => res.text())
         .then(() => {
         document.querySelectorAll('#sceneTable tr')[index].remove();
       });
      }

      function addScene() {
         fetch('/add_scene')
         .then(res => res.text())
         .then(() => {
         const table = document.getElementById('sceneTable');
         const i = table.rows.length;
         const tr = document.createElement('tr');
         tr.style.width = '100%';
         tr.innerHTML = `<td class="scene-row" onclick="selectScene(${i}, this)">Scene ${i + 1}
	 <button class="delete-btn" onclick="removeScene(event, ${i})">&#x2715;</button>
	 </td>`;
         table.appendChild(tr);
        });
      }

  
    </script>
  </body>
</html>

