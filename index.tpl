<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>LaserHarp</title>
    <style>
      body {
          font-family: sans-serif;
          background: #363a45;
          margin: 0;
          padding: 0;
      }
      .help {
          position: fixed;
          top: 1.5rem;
          right: 1.75rem;
          width: 28px;
          height: 28px;
          border-radius: 50%;
          border: 2px solid #fff;
          background: transparent;
          color: #fff;
          font-size: 0.95rem;
          font-weight: bold;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: default;
          user-select: none;
          box-shadow: 0 2px 6px rgba(0,0,0,0.35);
      }
      .help-tooltip {
         display: none;
         position: fixed;
         top: 3.5rem;
         right: 1.75rem;
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
          color: #0e1012;
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
          position: relative;
          left: 2px;
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
          background: rgb(127, 133, 140);
          border: 1px solid #1e2128;
          border-radius: 10px;
          margin:3px 3px 3px 3px;
          padding: 1rem 1rem;
          text-align: center;
          box-shadow: 0 2px 8px rgba(0,0,0,0.07);
          height: 90vh;
          display: flex;
          flex-direction: column;
      }
      .scene-list-scroll {
          flex: 1;
          overflow-y: auto;
          min-height: 0;
          direction: rtl;
          margin-left: calc(-1rem + 6px);
          padding-left: calc(1rem - 6px);
      }
      .scene-list-scroll > * {
          direction: ltr;
      }
      .scene-list-scroll::-webkit-scrollbar {
          width: 4px;
      }
      .scene-list-scroll::-webkit-scrollbar-track {
          background: transparent;
      }
      .scene-list-scroll::-webkit-scrollbar-thumb {
          background: rgba(255,255,255,0.25);
          border-radius: 2px;
          transition: background 0.2s;
      }
      .scene-list-scroll:hover::-webkit-scrollbar-thumb {
          background: rgba(255,255,255,0.45);
      }
      h1 {
          margin: 0 0 0.5rem;
          font-size: 2rem;
          color: #fff;
          text-shadow: 0 2px 8px rgba(0,0,0,0.38);
      }
      p {
          color: rgba(255,255,255,0.6);
          margin: 0 0 2rem;
          font-size: 0.95rem;
          text-shadow: 0 1px 3px rgba(0,0,0,0.3);
      }
      .main-content h1 {
          font-size: 2.4rem;
          font-weight: 700;
          margin: 0 0 0.6rem;
          color: #fff;
          text-shadow: 0 2px 8px rgba(0,0,0,0.38);
      }
      .main-content p {
          font-size: 1.05rem;
          font-weight: 500;
          margin: 0 0 2.2rem;
      }
      a.btn {
          display: inline-block;
          padding: 0.8rem 2.4rem;
          font-size: 1.05rem;
          font-weight: 600;
          background: #333;
          color: #e2e2e2;
          text-decoration: none;
          border-radius: 6px;
          box-shadow: 0 2px 7px rgba(0,0,0,0.35);
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

      .modal-overlay {
          display: none;
          position: fixed;
          inset: 0;
          background: rgba(0,0,0,0.45);
          z-index: 100;
          align-items: center;
          justify-content: center;
      }
      .modal-overlay.open { display: flex; }
      .modal {
          background: rgb(127, 133, 140);
          border-radius: 10px;
          width: 300px;
          position: relative;
          box-shadow: 0 8px 32px rgba(0,0,0,0.45);
          overflow: hidden;
      }
      .modal-titlebar {
          display: flex;
          align-items: center;
          gap: 14px;
          background: rgba(0,0,0,0.22);
          padding: 0.6rem 1rem;
      }
      .modal-title {
          flex: 1;
          font-size: 1.1rem;
          font-weight: bold;
          color: #e2e2e2;
          text-shadow: 0 1px 4px rgba(0,0,0,0.4);
      }
      .modal-body {
          padding: 1.25rem 1.5rem 1.5rem;
      }
      .modal-close {
          background: none;
          border: none;
          color: rgba(255,255,255,0.5);
          font-size: 1.4rem;
          cursor: pointer;
          line-height: 1;
          padding: 0;
          text-shadow: 0 1px 3px rgba(0,0,0,0.3);
      }
      .modal-close:hover { color: #e2e2e2; }
      .modal-help {
          width: 28px;
          height: 28px;
          border-radius: 50%;
          border: 2px solid rgba(255,255,255,0.5);
          background: transparent;
          color: rgba(255,255,255,0.5);
          font-size: 0.95rem;
          font-weight: bold;
          display: flex;
          align-items: center;
          justify-content: center;
          cursor: default;
          user-select: none;
          box-shadow: 0 2px 6px rgba(0,0,0,0.35);
      }
      .modal-help-tooltip {
          display: none;
          position: absolute;
          top: 52px;
          right: 12px;
          background: white;
          border: 1px solid #ccc;
          border-radius: 8px;
          padding: 12px 16px;
          width: 220px;
          font-size: 0.85rem;
          color: #333;
          box-shadow: 0 2px 8px rgba(0,0,0,0.15);
          z-index: 999;
      }
      .modal-help:hover + .modal-help-tooltip,
      .modal-help-tooltip:hover { display: block; }
      .net-field {
          display: flex;
          flex-direction: column;
          margin-bottom: 1rem;
      }
      .net-field label {
          font-size: 0.8rem;
          color: rgba(255,255,255,0.72);
          margin-bottom: 4px;
          text-shadow: 0 1px 3px rgba(0,0,0,0.3);
      }
      .net-field input {
          padding: 9px 12px;
          background: rgba(255,255,255,0.92);
          border: 1px solid rgba(0,0,0,0.25);
          border-radius: 6px;
          color: #1a1a1a;
          font-size: 1rem;
          box-sizing: border-box;
          width: 100%;
      }
      .net-field input::placeholder {
          color: #999;
      }
      .net-field input:focus {
          outline: none;
          background: #fff;
          border-color: rgba(0,0,0,0.45);
      }

    </style>
  </head>
  <body>
    <table style="width:100%;height:100%">
      <div class="help">?</div>
    <div class="help-tooltip">
        <strong>How to use:</strong><br><br>
        • Click a scene to edit it<br>
        • Click + Add Scene to create a new scene<br>
        • Click ✕ to delete a scene
    </div>
      <tr style="height:100%;">
        <td style="height:100%;width:200px">
          <div class="card">
            <h1>Scenes</h1>
            <div class="scene-list-scroll">
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
            </div>
            <button class="add-btn" onclick="addScene()">+ Add Scene</button>
          </div>
        </td>
        <td style="height:100%">
          <div class="card" style="display:flex;align-items:center;justify-content:center;">
            <div class="main-content" style="margin-bottom:5%">
              <h1>LaserHarp</h1>
              <p>An interactive laser-based MIDI instrument for live performance.</p>
              <a class="btn" href="#" onclick="openNetwork(event)">Network</a>
            </div>
          </div>
        </td>
      </tr>
    </table>
    <div id="networkModal" class="modal-overlay" onclick="overlayClick(event)">
      <div class="modal">
        <div class="modal-titlebar">
          <span class="modal-title">Network</span>
          <div class="modal-help">?</div>
          <div class="modal-help-tooltip">
              Enter the IP address and port of the device you want to connect to.
          </div>
          <button class="modal-close" onclick="closeNetwork()">&#x2715;</button>
        </div>
        <div class="modal-body">
          <div class="net-field">
            <label>IP Address</label>
            <input type="text" id="net-ip" placeholder="Enter IP address" />
          </div>
          <div class="net-field">
            <label>Port</label>
            <input type="text" id="net-port" placeholder="Enter port number" />
          </div>
        </div>
      </div>
    </div>

    <script>
      function openNetwork(e) {
          e.preventDefault();
          document.getElementById('networkModal').classList.add('open');
      }
      function closeNetwork() {
          document.getElementById('networkModal').classList.remove('open');
      }
      function overlayClick(e) {
          if (e.target === document.getElementById('networkModal')) closeNetwork();
      }

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
           const td = document.createElement('td');
           td.className = 'scene-row';
           td.onclick = function() { selectScene(i, this); };
           td.textContent = 'Scene ' + (i + 1);
           const btn = document.createElement('button');
           btn.className = 'delete-btn';
           btn.textContent = '✕';
           btn.onclick = function(e) { removeScene(e, i); };
           td.appendChild(btn);
           tr.appendChild(td);
           table.appendChild(tr);
           const scroll = document.querySelector('.scene-list-scroll');
           scroll.scrollTop = scroll.scrollHeight;
         });
      }

  
    </script>
  </body>
</html>

