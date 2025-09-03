

// ========= Toast helper =========
function toast(msg, ok=true) {
  const el = document.getElementById('toast');
  if (!el) { alert(msg); return; } // fallback si no existe

  el.textContent = msg;
  el.style.background = ok ? '#10331f' : '#3b1420'; // verde/rojo
  el.style.color = ok ? '#b6ffd3' : '#ffd3d3';
  el.classList.add('show');

  clearTimeout(el._timer);
  el._timer = setTimeout(() => {
    el.classList.remove('show');
  }, 3000);
}


// ========= CONFIG =========
const USE_BACKEND = true; // usa db.php
let cacheCats = {};

// ========= Datos de todas las tablas =========
window._user = null; // antes estaba fijo en admin
let USUARIOS = [];
let ROLES = [];
let PERMISOS = {};
let ROL_PERMISO = [];

async function cargarConstantes() {
  USUARIOS   = await fetch('db.php?action=list_usuarios').then(r=>r.json());
  ROLES      = await fetch('db.php?action=list_roles').then(r=>r.json());
  PERMISOS   = await fetch('db.php?action=list_permisos').then(r=>r.json());
  ROL_PERMISO= await fetch('db.php?action=list_rol_permiso').then(r=>r.json());
}

const $ = (sel, el=document) => el.querySelector(sel);
const $$ = (sel, el=document) => [...el.querySelectorAll(sel)];

// ========= API: usa db.php si USE_BACKEND =========
const API = {
  async listRespuestas() {
    const r = await fetch('db.php?action=list_respuestas');
    if (!r.ok) throw new Error('Error list_respuestas');
    return r.json();
  },

  async createRespuesta(item) {
    console.log('Enviando create:', item);
    const r = await fetch('db.php?action=create_respuesta', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(item)
    });
    if (!r.ok) throw new Error('Error create_respuesta');
    return r.json();
  },

  async updateRespuesta(numero, patch) {
    console.log('Enviando update:', numero, patch);
    const r = await fetch('db.php?action=update_respuesta&numero=' + encodeURIComponent(numero), {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(patch)
    });
    if (!r.ok) throw new Error('Error update_respuesta');
    return r.json();
  },

  async deleteRespuesta(numero) {
    const r = await fetch('db.php?action=delete_respuesta&numero=' + encodeURIComponent(numero));
    if (!r.ok) throw new Error('Error delete_respuesta');
    return true;
  },

  async listCatalogo(nombre) {
    const r = await fetch('db.php?action=list_catalogo&nombre=' + encodeURIComponent(nombre));
    if (!r.ok) throw new Error('Error list_catalogo ' + nombre);
    return r.json();
  }
};

// ========= UI helpers =========
const mapTxt = (catName, clave, cache) =>
  (cache?.[catName]?.find(x=> String(x.clave)===String(clave))?.valor ?? clave);

async function fillSelect(id, catName, cache){
  const sel = $('#'+id);
  sel.innerHTML = '';
  const items = cache?.[catName] ?? await API.listCatalogo(catName);
  if(cache && !cache[catName]) cache[catName] = items;
  items.forEach(opt=>{
    const o = document.createElement('option');
    o.value = opt.clave; o.textContent = opt.valor; sel.appendChild(o);
  });
}

async function fillCatalogLists(cache){
  for(const k of Object.keys(cacheCats)){ // usamos claves conocidas
    const ul = $('#cat-'+k);
    if(!ul) continue;
    ul.innerHTML = '';
    const items = cache?.[k] ?? await API.listCatalogo(k);
    if(cache && !cache[k]) cache[k] = items;
    items.forEach(({clave,valor})=>{
      const li = document.createElement('li');
      li.innerHTML = `<span class="tag">${clave}</span> ${valor}`;
      ul.appendChild(li);
    });
  }
}

function hasPerm(permName) {
  if (!window._user) return false;
  const role = window._user.idrol;
  const pid = Object.entries(PERMISOS).find(([, n]) => n === permName)?.[0];
  return ROL_PERMISO.some(rp => rp.idrol === role && String(rp.idpermiso) === String(pid));
}

async function renderTabla(filter='', cacheCats){
  const tb = $('#tablaRespuestas tbody');
  tb.innerHTML = '';
  const rows = (await API.listRespuestas()).filter(r=>{
    const f = filter.trim().toLowerCase();
    if(!f) return true;
    return [r.I, r.II, r.IV].some(x=> String(x).toLowerCase().includes(f));
  });
  for(const r of rows){
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${r.numero}</td>
      <td>${r.I}</td>
      <td>${r.II}</td>
      <td>${mapTxt('iii_sexo', r.III, cacheCats)}</td>
      <td>${r.IV}</td>
      <td>${mapTxt('v_departamento', r.V, cacheCats)}</td>
      <td>${mapTxt('vi_ciudad', r.VI, cacheCats)}</td>
      <td>${mapTxt('vii_facultad', r.VII, cacheCats)}</td>
      <td>${mapTxt('viii_carrera', r.VIII, cacheCats)}</td>
      <td>${r.IX}</td>
      <td>${mapTxt('x_matricula', r.X, cacheCats)}</td>
      <td>${mapTxt('xi_becado', r.XI, cacheCats)}</td>
      <td>${mapTxt('xii', r.XII, cacheCats)}</td>
      <td>${mapTxt('xiii', r.XIII, cacheCats)}</td>
      <td>${mapTxt('xiv', r.XIV, cacheCats)}</td>
      <td>${mapTxt('xv', r.XV, cacheCats)}</td>
      <td>${mapTxt('xvi', r.XVI, cacheCats)}</td>
      <td>${mapTxt('xvii', r.XVII, cacheCats)}</td>
      <td class="no-print">
        <div class="actions">
          <button class="btn ghost" data-act="edit">Editar</button>
          <button class="btn danger" data-act="del">Borrar</button>
        </div>
      </td>
    `;
    const canEdit = hasPerm('actualizar_encuesta');
    const canDel = hasPerm('borrar_encuesta');
    if(!canEdit) tr.querySelector('[data-act="edit"]').disabled = true;
    if(!canDel) tr.querySelector('[data-act="del"]').disabled = true;

    tr.querySelector('[data-act="edit"]').addEventListener('click', ()=> loadIntoForm(r));
    tr.querySelector('[data-act="del"]').addEventListener('click', async ()=>{
      if(!hasPerm('borrar_encuesta')){ toast('No tienes permiso para borrar'); return; }
      if(confirm('¿Borrar registro #' + r.numero + '?')){
        await API.deleteRespuesta(r.numero); toast('Eliminado', true); renderTabla($('#q').value, cacheCats)
      }
    });
    tb.appendChild(tr);
  }
}

function loadIntoForm(r){
  const f = $('#formEncuesta');
  for(const k of ['numero','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII']){
    f.elements[k].value = r[k];
  }
  $('#btnGuardar').textContent = 'Actualizar';
}

function resetForm(){
  $('#formEncuesta').reset();
  $('#btnGuardar').textContent = 'Guardar';
}

function updateChips(){
  const roleChip = $('#roleChip');
  const permChip = $('#permChip');
  if(window._user){
    const rol = ROLES.find(r=> r.idrol===window._user.idrol)?.nombre_rol || '—';
    roleChip.textContent = 'Rol: ' + rol;
    const ps = ROL_PERMISO.filter(rp=> rp.idrol===window._user.idrol).map(rp=> PERMISOS[rp.idpermiso]).join(', ');
    permChip.textContent = 'Permisos: ' + (ps||'—');
    $('#loginBtn').classList.add('hidden'); $('#logoutBtn').classList.remove('hidden');
  } else {
    roleChip.textContent = 'Rol: —'; permChip.textContent = 'Permisos: —';
    $('#loginBtn').classList.remove('hidden'); $('#logoutBtn').classList.add('hidden');
  }
}

function guardiaUI(){
  $('[data-view="usuarios"]').disabled = !window._user;
  $('#btnGuardar').disabled = !(hasPerm('registrar_encuesta') || hasPerm('actualizar_encuesta'));
  $('#btnExportCSV').disabled = !hasPerm('exportar_excel');
  $('#btnExportPDF').disabled = !hasPerm('exportar_pdf');
}

function renderUsuarios(){
  const tb = $('#tablaUsuarios tbody'); tb.innerHTML='';
  USUARIOS.forEach(u=>{
    const rol = ROLES.find(r=> r.idrol===u.idrol)?.nombre_rol || '—';
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${u.idusuario}</td><td>${u.login}</td><td>${u.nombre}</td><td><span class="tag">${rol}</span></td>`;
    tb.appendChild(tr);
  });
}

function renderPermMatrix(){
  const c = $('#permMatrix'); c.innerHTML = '';
  const table = document.createElement('table');
  const thead = document.createElement('thead');
  thead.innerHTML = '<tr><th>Rol</th>'+Object.values(PERMISOS).map(p=>`<th>${p}</th>`).join('')+'</tr>';
  table.appendChild(thead);
  const tbody = document.createElement('tbody');
  ROLES.forEach(rol=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td><b>${rol.nombre_rol}</b></td>` + Object.entries(PERMISOS).map(([idp,name])=>{
      const checked = ROL_PERMISO.some(rp=> rp.idrol===rol.idrol && rp.idpermiso===Number(idp));
      return `<td><input type="checkbox" data-r="${rol.idrol}" data-p="${idp}" ${checked?'checked':''}></td>`;
    }).join('');
    tbody.appendChild(tr);
  });
  table.appendChild(tbody); c.appendChild(table);
}

function exportCSV(){
  const headers = ['numero','I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII'];
  API.listRespuestas().then(rows=>{
    const csv = [headers.join(',')].concat(rows.map(r=> headers.map(h=> JSON.stringify(r[h]??'')).join(','))).join('\n');
    const blob = new Blob([csv], {type:'text/csv;charset=utf-8;'});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a'); a.href=url; a.download='respuestas.csv'; a.click(); URL.revokeObjectURL(url);
  });
}


function showView(name){
  $$('.tab').forEach(t=> t.setAttribute('aria-selected', String(t.dataset.view===name)));
  ['encuestas','catalogos','usuarios','conexion'].forEach(v=>{
    const el = $('#view-'+v);
    if(v===name){ el.classList.remove('hidden'); el.setAttribute('aria-hidden','false'); }
    else { el.classList.add('hidden'); el.setAttribute('aria-hidden','true'); }
  });
}

// ========= Inicialización =========
document.addEventListener('DOMContentLoaded', ()=>{
  const cacheCats = {};

  (async function init(){
    await cargarConstantes();

    // Cargar selects desde BD
    await Promise.all([
      fillSelect('III','iii_sexo', cacheCats),
      fillSelect('V','v_departamento', cacheCats),
      fillSelect('VI','vi_ciudad', cacheCats),
      fillSelect('VII','vii_facultad', cacheCats),
      fillSelect('VIII','viii_carrera', cacheCats),
      fillSelect('X','x_matricula', cacheCats),
      fillSelect('XI','xi_becado', cacheCats),
      fillSelect('XII','xii', cacheCats),
      fillSelect('XIII','xiii', cacheCats),
      fillSelect('XIV','xiv', cacheCats),
      fillSelect('XV','xv', cacheCats),
      fillSelect('XVI','xvi', cacheCats),
      fillSelect('XVII','xvii', cacheCats),
    ]);

    await fillCatalogLists(cacheCats);
    await renderTabla('', cacheCats);
    renderUsuarios();
    renderPermMatrix();
    updateChips();
    guardiaUI();
    showView('encuestas');

    // Tabs
    $$('.tab').forEach(t=> t.addEventListener('click', ()=> showView(t.dataset.view)));

    // Buscar
    $('#q').addEventListener('input', (e)=> renderTabla(e.target.value, cacheCats));
    $('#btnLimpiar').addEventListener('click', ()=> { $('#q').value=''; renderTabla('', cacheCats); });

    // CRUD form
    $('#formEncuesta').addEventListener('submit', async (e)=>{
      e.preventDefault();
      const f = e.target;
      const data = Object.fromEntries(new FormData(f).entries());
      ['numero','III','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII']
        .forEach(k=>{ if(data[k]!==undefined && data[k]!=='' ) data[k] = Number(data[k]) });

      if(data.numero){
        if(!hasPerm('actualizar_encuesta')){ toast('No tienes permiso para actualizar'); return; }
        await API.updateRespuesta(data.numero, data);
        toast('Encuesta actualizada', true);
      } else {
        if(!hasPerm('registrar_encuesta')){ toast('No tienes permiso para registrar'); return; }
        const created = await API.createRespuesta(data);
        toast('Encuesta registrada (#'+created.numero+')', true);
      }
      resetForm(); renderTabla($('#q').value, cacheCats);
    });
    $('#btnCancelar').addEventListener('click', resetForm);
    $('#btnCargarEjemplo').addEventListener('click', ()=>{
      $('#formEncuesta').reset();
      loadIntoForm({ I:'Benita Emelina', II:'Avendaño Arauz', III:1, IV:'2811505021015U', V:7, VI:7, VII:4, VIII:15, IX:5, X:1, XI:0, XII:1, XIII:2, XIV:3, XV:1, XVI:0, XVII:3 });
    });

    // Export
    $('#btnExportCSV').addEventListener('click', ()=> hasPerm('exportar_excel') ? exportCSV() : toast('Sin permiso'));
    $('#btnExportPDF').addEventListener('click', ()=> hasPerm('exportar_pdf') ? window.print() : toast('Sin permiso'));

    // Login
    const dlg = document.getElementById('dlgLogin');
    const formLogin = document.getElementById('loginForm');

    document.getElementById('loginBtn').addEventListener('click', () => dlg.showModal());
    document.getElementById('btnCancelLogin').addEventListener('click', () => {
      formLogin.reset();
      dlg.close();
    });

    formLogin.addEventListener('submit', e => {
      e.preventDefault();
      const login = formLogin.login.value.trim();
      const clave = formLogin.clave.value.trim();
      if(!login || !clave){ 
        toast('Debes ingresar usuario y clave'); 
        return; 
      }

      const u = USUARIOS.find(x => x.login === login && x.clave === clave);
      if(u){
        formLogin.reset();
        window._user = u;
        toast('Bienvenido, ' + u.nombre, true);
        updateChips();
        guardiaUI();
        renderTabla($('#q').value, cacheCats);
        dlg.close();
      } else {
        toast('Credenciales inválidas');
      }
    });

    //Log Out
    $('#logoutBtn').addEventListener('click', ()=>{
      window._user = null;
      updateChips();
      guardiaUI();
      renderTabla($('#q').value, cacheCats);
      toast('Sesión cerrada');
    });

    // Permisos demo
    $('#guardarPermisos').addEventListener('click', ()=>{
      const checks = $$('#permMatrix input[type="checkbox"]');
      const nuevo = [];
      ROLES.forEach(r=>{
        Object.keys(PERMISOS).forEach(idp=>{
          const ok = checks.find(c=> Number(c.dataset.r)===r.idrol && Number(c.dataset.p)===Number(idp))?.checked;
          if(ok) nuevo.push({idrol:r.idrol, idpermiso:Number(idp)});
        });
      });
      ROL_PERMISO = nuevo;
      updateChips(); guardiaUI(); renderTabla($('#q').value, cacheCats);
      toast('Permisos actualizados', true);
    });

    // Conexión
    $('#testConn').addEventListener('click', async ()=>{
      try{
        const r = await fetch('db.php?action=list_respuestas');
        if(!r.ok) throw new Error();
        await r.json();
        toast('Conexión OK', true);
        const chip = $('#connChip'); chip.textContent = 'DB: Conectado'; chip.style.background = '#10331f'; chip.style.color = '#b6ffd3';
      }catch(e){
        toast('Falla al conectar', false);
        const chip = $('#connChip'); chip.textContent = 'DB: Error'; chip.style.background = '#3b1420';
      }
    });
    $('#verRaw').addEventListener('click', async ()=>{
      try{
        const data = await API.listRespuestas();
        alert('JSON:\n'+JSON.stringify(data, null, 2).slice(0, 3000));
      }catch(e){ toast('No se pudo obtener JSON'); }
    });
  })();
});
