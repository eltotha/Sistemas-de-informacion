<?php
// db.php — DEMO SIN SEGURIDAD (no usar en producción)
header('Content-Type: application/json; charset=utf-8');

$host = '127.0.0.1';
$user = 'root';
$pass = 'Fierce#123';
$db   = 'encuesta';

$mysqli = @new mysqli($host, $user, $pass, $db);
if ($mysqli->connect_errno) {
    http_response_code(500);
    echo json_encode(['error' => 'Error de conexión: ' . $mysqli->connect_error]);
    exit;
}
$mysqli->set_charset('utf8mb4');

$action = $_GET['action'] ?? '';

function jerr($msg, $code = 400){ 
    http_response_code($code); 
    echo json_encode(['error'=>$msg]); 
    exit; 
}
function jok($data){ 
    echo json_encode($data, JSON_UNESCAPED_UNICODE); 
    exit; 
}

// Catálogos permitidos
$CATS = ['iii_sexo','v_departamento','vi_ciudad','vii_facultad','viii_carrera','x_matricula','xi_becado','xii','xiii','xiv','xv','xvi','xvii'];

switch ($action) {

    case 'list_respuestas': {
        $res = $mysqli->query("SELECT numero,I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII FROM respuestas ORDER BY numero ASC");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){ 
            foreach (['numero','III','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII'] as $k) { 
                $row[$k] = intval($row[$k]); 
            }
            $rows[] = $row;
        }
        jok($rows);
    }

    case 'create_respuesta': {
        $body = json_decode(file_get_contents('php://input'), true);
        if(!$body) jerr('JSON inválido');
        $stmt = $mysqli->prepare("INSERT INTO respuestas (I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,XVII) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
        $stmt->bind_param(
            "ssisiisiiiiiiiiii",
            $body['I'], $body['II'], $body['III'], $body['IV'], $body['V'], $body['VI'], $body['VII'], $body['VIII'],
            $body['IX'], $body['X'], $body['XI'], $body['XII'], $body['XIII'], $body['XIV'], $body['XV'], $body['XVI'], $body['XVII']
        );
        if(!$stmt->execute()) jerr('No se pudo insertar: '.$stmt->error, 500);
        $body['numero'] = intval($stmt->insert_id);
        foreach (['numero','III','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII'] as $k) { $body[$k] = intval($body[$k]); }
        jok($body);
    }

    case 'update_respuesta': {
        $numero = intval($_GET['numero'] ?? 0);
        if($numero <= 0) jerr('numero requerido');
        $body = json_decode(file_get_contents('php://input'), true);
        if(!$body) jerr('JSON inválido');
        $stmt = $mysqli->prepare("UPDATE respuestas SET I=?,II=?,III=?,IV=?,V=?,VI=?,VII=?,VIII=?,IX=?,X=?,XI=?,XII=?,XIII=?,XIV=?,XV=?,XVI=?,XVII=? WHERE numero=?");
        $stmt->bind_param(
            "ssisiisiiiiiiiiiii",
            $body['I'], $body['II'], $body['III'], $body['IV'], $body['V'], $body['VI'], $body['VII'], $body['VIII'],
            $body['IX'], $body['X'], $body['XI'], $body['XII'], $body['XIII'], $body['XIV'], $body['XV'], $body['XVI'], $body['XVII'], $numero
        );
        if(!$stmt->execute()) jerr('No se pudo actualizar: '.$stmt->error, 500);
        $body['numero'] = $numero;
        foreach (['numero','III','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','XVII'] as $k) { $body[$k] = intval($body[$k]); }
        jok($body);
    }

    case 'delete_respuesta': {
        $numero = intval($_GET['numero'] ?? 0);
        if($numero <= 0) jerr('numero requerido');
        $stmt = $mysqli->prepare("DELETE FROM respuestas WHERE numero=?");
        $stmt->bind_param("i", $numero);
        if(!$stmt->execute()) jerr('No se pudo borrar: '.$stmt->error, 500);
        jok(['ok'=>true]);
    }

    case 'list_catalogo': {
        $nombre = $_GET['nombre'] ?? '';
        if(!in_array($nombre, $CATS)) jerr('Catálogo no permitido: '.$nombre);
        $res = $mysqli->query("SELECT clave, valor FROM `$nombre` ORDER BY clave ASC");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){
            $row['clave'] = intval($row['clave']);
            $rows[] = $row;
        }
        jok($rows);
    }

    case 'list_usuarios': {
        $res = $mysqli->query("SELECT idusuario, nombre, login, clave, idrol FROM usuario");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){
            $row['idusuario'] = intval($row['idusuario']);
            $row['idrol'] = intval($row['idrol']);
            $rows[] = $row;
        }
        jok($rows);
    }

    case 'list_roles': {
        $res = $mysqli->query("SELECT idrol, nombre_rol FROM rol");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){
            $row['idrol'] = intval($row['idrol']);
            $rows[] = $row;
        }
        jok($rows);
    }

    case 'list_permisos': {
        $res = $mysqli->query("SELECT idpermiso, accion FROM permiso");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){
            $row['idpermiso'] = intval($row['idpermiso']);
            $rows[] = $row;
        }
        jok($rows);
    }

    case 'list_rol_permiso': {
        $res = $mysqli->query("SELECT idrol, idpermiso FROM rol_permiso");
        if(!$res) jerr('Error en query: '.$mysqli->error,500);
        $rows = [];
        while($row = $res->fetch_assoc()){
            $row['idrol'] = intval($row['idrol']);
            $row['idpermiso'] = intval($row['idpermiso']);
            $rows[] = $row;
        }
        jok($rows);
    }

    default: jerr('action inválido');
}
