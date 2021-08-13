import * as vs from 'vscode';
import { flutterExtensionIdentifier } from './constants';
import { createCommand } from './commands';

export async function activate(context: vs.ExtensionContext): Promise<void> {
	const flutterExt = vs.extensions.getExtension(flutterExtensionIdentifier);

	if (!flutterExt) {
		// This should not happen since the at_app extension has a dependency on the flutter one
		// but just in case, we'd like to give a useful error message.
		throw new Error("The Flutter extension is not installed, @App extension is unable to activate.");
	}

	await flutterExt.activate();

	let disposable = vs.commands.registerCommand('at-app.create', createCommand);

	context.subscriptions.push(disposable);
}

export function deactivate() {}
