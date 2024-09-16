const { Client } = require('ssh2');
const express = require('express');
const app = express();

app.get('/deploy', (req, res) => {
    const conn = new Client();
    conn.on('ready', () => {
        console.log('Conectado al servidor remoto');
        conn.exec('home/testuser/scripts/deploy.sh', (err, stream) => {
            if (err) throw err;
            stream.on('close', (code, signal) => {
                console.log('Script ejecutado con código de salida:', code);
                conn.end();
                res.send('Despliegue completado');
            }).on('data', (data) => {
                console.log('Salida:', data.toString());
            }).stderr.on('data', (data) => {
                console.error('Error:', data.toString());
            });
        });
    }).connect({
        host: 'server_ip',
        port: 22,
        username: 'user',
        privateKey: require('fs').readFileSync('home/testuser/Keyfile')
    });
});

app.listen(3000, () => {
    console.log('Aplicación de despliegue corriendo en http://localhost:3000');
});
