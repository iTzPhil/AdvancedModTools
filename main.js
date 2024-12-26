const { app, BrowserWindow } = require('electron');
const path = require('node:path');
const { updateElectronApp } = require('update-electron-app');
const Store = require('electron-store');
const store = new Store();

if (require('electron-squirrel-startup')) app.quit();

store.set('foo', 'bar');

const createWindow = () => {
	const win = new BrowserWindow({
		width: 800,
		height: 600,
		webPreferences: {
			preload: path.join(__dirname, 'preload.js'),
		},
	});

	win.loadFile('html/index.html');
};

app.whenReady().then(() => {
	createWindow();
	updateElectronApp();
	app.on('activate', () => {
		if (BrowserWindow.getAllWindows().length === 0) createWindow();
		
	});
});

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') app.quit();
});
