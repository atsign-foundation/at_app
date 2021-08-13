// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vs from 'vscode';

const flutterExtensionIdentifier = 'Dart-Code.flutter';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export async function activate(context: vs.ExtensionContext): Promise<void> {
	const flutterExt = vs.extensions.getExtension(flutterExtensionIdentifier);
	if (!flutterExt) {
		// This should not happen since the at_app extension has a dependency on the flutter one
		// but just in case, we'd like to give a useful error message.
		throw new Error("The Flutter extension is not installed, @App extension is unable to activate.");
	}
	await flutterExt.activate();

	if (!flutterExt.exports) {
		console.error("The Dart extension did not provide an exported API. Maybe it failed to activate?");
		return;
	}

	// The command has been defined in the package.json file
	// Now provide the implementation of the command with registerCommand
	// The commandId parameter must match the command field in package.json
	let disposable = vs.commands.registerCommand('at-app.create', () => {
		// The code you place here will be executed every time your command is executed
		// Display a message box to the user
		vs.window.showInformationMessage('Hello World from at_app!');
	});

	context.subscriptions.push(disposable);
}

// this method is called when your extension is deactivated
export function deactivate() {}
